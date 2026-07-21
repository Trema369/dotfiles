import Quickshell.Io
import QtQuick
import QtQuick.Controls

Item {
    id: brightnessControl
    property real currentBrightness: 0.5

    Process {
        id: getBrightness
        command: ["brightnessctl", "g"]
        stdout: StdioCollector {
            onStreamFinished: {
                // parse raw brightness value, compare to max separately
            }
        }
    }

    Slider {
        anchors.fill: parent
        from: 0
        to: 1
        value: brightnessControl.currentBrightness
        onMoved: {
            brightnessControl.currentBrightness = value;
            setBrightness.command = ["brightnessctl", "s", Math.round(value * 100) + "%"];
            setBrightness.running = true;
        }
    }

    Process {
        id: setBrightness
        running: false
    }
}
