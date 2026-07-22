import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Item {
    id: volumeControl
    readonly property PwNode sink: Pipewire.defaultAudioSink
    PwObjectTracker {
        objects: [volumeControl.sink]
    }
    readonly property real volume: sink?.audio?.volume ?? 0
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
            width: track.width * volumeControl.volume
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
                text: "\ue638"
                font.family: Theme.fontFamily
                color: "gray"
            }
        }
        MouseArea {
            anchors.fill: parent
            onPressed: mouse => updateVolume(mouse.x)
            onPositionChanged: mouse => {
                if (pressed)
                    updateVolume(mouse.x);
            }
            function updateVolume(x) {
                let pct = Math.max(0, Math.min(1, x / width));
                if (volumeControl.sink?.ready && volumeControl.sink?.audio)
                    volumeControl.sink.audio.volume = pct;
            }
        }
    }
}
