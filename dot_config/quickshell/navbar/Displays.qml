// Displays.qml — hyprland output inventory + mode switching
pragma Singleton
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    // every output hyprland knows about, disabled ones included
    property var monitors: []
    property string lastError: ""

    // "" until probed, then "lua" or "keyword" — see monitorSpec()
    property string backend: ""
    property var pending: null

    readonly property int outputCount: monitors.length
    readonly property bool multiOutput: outputCount > 1

    readonly property int enabledCount: {
        let n = 0;
        for (let i = 0; i < monitors.length; i++) {
            if (!monitors[i].disabled)
                n++;
        }
        return n;
    }

    // the output we treat as the cast/mirror source
    readonly property string primaryName: {
        for (let i = 0; i < monitors.length; i++) {
            if (!monitors[i].disabled && monitors[i].focused)
                return monitors[i].name;
        }
        for (let i = 0; i < monitors.length; i++) {
            if (!monitors[i].disabled)
                return monitors[i].name;
        }
        return "";
    }

    // island size for the displays state, grows with the output count.
    // mirrors the layout in DisplaySetup.qml: 48 header, 76 per card,
    // 8 spacing, 31 for the separator + cast label, 34 per cast row, 16 pad.
    readonly property int panelHeight: {
        const cards = Math.max(1, outputCount);
        const castRows = Math.max(0, outputCount - 1);
        const h = 48 + cards * 76 + (cards - 1) * 8 + 31 + castRows * 34 + 16;
        return Math.min(600, h);
    }

    function modeOf(m) {
        if (m.disabled)
            return "off";
        if (m.mirrorOf && m.mirrorOf !== "none")
            return "mirror";
        return "extend";
    }

    function extend(name) {
        monitorSpec(name, 'mode = "preferred", position = "auto", scale = 1, disabled = false, mirror = ""', "preferred,auto,1");
    }

    function mirror(name, source) {
        if (!source || source === name) {
            lastError = "no source output to mirror";
            return;
        }
        monitorSpec(name, 'mode = "preferred", position = "auto", scale = 1, disabled = false, mirror = "' + quote(source) + '"', "preferred,auto,1,mirror," + source);
    }

    function off(name) {
        // never black out the session by disabling the last live output
        if (enabledCount <= 1) {
            lastError = "can't disable the only active output";
            return;
        }
        monitorSpec(name, "disabled = true", "disable");
    }

    function quote(s) {
        return String(s).replace(/["\\]/g, "");
    }

    // Two incompatible ways to reconfigure an output, depending on which config
    // parser this hyprland was started with:
    //   lua config     -> `hyprctl keyword` is refused, must use `hyprctl eval`
    //   hyprland.conf  -> no lua state exists, `eval` fails, must use `keyword`
    // backend is probed once at startup; actions before it resolves are queued.
    function monitorSpec(name, luaFields, keywordArgs) {
        lastError = "";
        const action = {
            lua: 'hl.monitor({ output = "' + quote(name) + '", ' + luaFields + ' })',
            keyword: name + "," + keywordArgs
        };

        if (backend === "") {
            pending = action;
            probeBackend();
            return;
        }
        run(action);
    }

    function run(action) {
        if (backend === "lua")
            Quickshell.execDetached(["hyprctl", "eval", action.lua]);
        else
            Quickshell.execDetached(["hyprctl", "keyword", "monitor", action.keyword]);
        settle.restart();
    }

    function probeBackend() {
        if (backend === "" && !probe.running)
            probe.running = true;
    }

    // a live lua state answers exactly "ok"; anything else ("error: lua state
    // not initialized", "unknown request") means fall back to keyword
    Process {
        id: probe
        command: ["hyprctl", "eval", "return 1"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                root.backend = this.text.trim().toLowerCase() === "ok" ? "lua" : "keyword";
                if (root.pending) {
                    const action = root.pending;
                    root.pending = null;
                    root.run(action);
                }
            }
        }
    }

    function refresh() {
        if (!query.running)
            query.running = true;
    }

    // hyprctl returns before the output is reconfigured, so re-read shortly after
    Timer {
        id: settle
        interval: 250
        repeat: false
        onTriggered: root.refresh()
    }

    Process {
        id: query
        command: ["hyprctl", "monitors", "all", "-j"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                let parsed;
                try {
                    parsed = JSON.parse(this.text);
                } catch (e) {
                    root.lastError = "could not read hyprctl output";
                    return;
                }
                if (!Array.isArray(parsed))
                    return;

                // hyprland reports mirrorOf as the source monitor's numeric id,
                // so build an id -> name map to turn it back into something usable
                const names = {};
                for (let i = 0; i < parsed.length; i++) {
                    names[String(parsed[i].id)] = parsed[i].name;
                }

                const result = [];
                for (let i = 0; i < parsed.length; i++) {
                    const m = parsed[i];
                    const modes = m.availableModes || [];
                    const raw = m.mirrorOf || "none";
                    result.push({
                        name: m.name || "",
                        label: m.description || m.model || m.name || "",
                        disabled: m.disabled === true,
                        focused: m.focused === true,
                        mirrorOf: raw !== "none" && names[raw] !== undefined ? names[raw] : raw,
                        // a disabled output reports 0x0, fall back to its preferred mode
                        mode: m.width > 0 ? m.width + "x" + m.height + "@" + Math.round(m.refreshRate) : (modes.length > 0 ? modes[0] : "—")
                    });
                }
                root.monitors = result;
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            const n = event.name;
            if (n === "monitoradded" || n === "monitoraddedv2" || n === "monitorremoved" || n === "monitorremovedv2")
                root.refresh();
        }
    }

    Component.onCompleted: {
        refresh();
        probeBackend();
    }
}
