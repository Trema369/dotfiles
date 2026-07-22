import Quickshell.Io
import QtQuick

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

    // poll for external changes (macro keys, other tools)
    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            if (!setBrightness.running)
                getCurrent.running = true;
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

    Rectangle {
        id: track
        anchors.fill: parent
        radius: height / 2
        color: Qt.rgba(1, 1, 1, 0.15)
        border.color: Qt.rgba(1, 1, 1, 0.3)
        border.width: 1

        Rectangle {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            radius: height / 2
            color: Qt.rgba(1, 1, 1, 0.6)
            width: track.width * brightnessControl.currentBrightness
        }

        Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            width: parent.height - 8
            height: parent.height - 8
            radius: width / 2
            color: Qt.rgba(1, 1, 1, 0.9)
            z: 2
            Text {
                anchors.centerIn: parent
                text: "\uf185"
                font.family: Theme.fontFamily
                color: "gray"
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: brightnessControl.ready
            onPressed: mouse => updateBrightness(mouse.x)
            onPositionChanged: mouse => {
                if (pressed)
                    updateBrightness(mouse.x);
            }
            function updateBrightness(x) {
                let pct = Math.max(0, Math.min(1, x / width));
                brightnessControl.currentBrightness = pct;
                debounce.restart();
            }
        }
    }
}
