import Quickshell.Io
import QtQuick
import QtQuick.Controls

Item {
    id: brightnessControl
    property real currentBrightness: 0.5
    property int maxBrightness: 100
    property bool ready: false

    Component.onCompleted: getMax.running = true

    Process {
        id: getMax
        command: ["brightnessctl", "m"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const max = parseInt(this.text.trim());
                if (!isNaN(max)) {
                    brightnessControl.maxBrightness = max;
                    getCurrent.running = true;
                }
            }
        }
    }

    Process {
        id: getCurrent
        command: ["brightnessctl", "g"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                const current = parseInt(this.text.trim());
                if (!isNaN(current)) {
                    brightnessControl.currentBrightness = current / brightnessControl.maxBrightness;
                    brightnessControl.ready = true;
                }
            }
        }
    }

    Timer {
        id: debounce
        interval: 150
        repeat: false
        onTriggered: {
            if (setBrightness.running)
                return;
            const pct = Math.round(brightnessControl.currentBrightness * 100);
            setBrightness.command = ["brightnessctl", "s", pct + "%"];
            setBrightness.running = true;
        }
    }

    Process {
        id: setBrightness
        running: false
    }

    Slider {
        anchors.fill: parent
        from: 0
        to: 1
        value: brightnessControl.currentBrightness
        enabled: brightnessControl.ready
        onMoved: {
            brightnessControl.currentBrightness = value;
            debounce.restart();
        }
    }
}
