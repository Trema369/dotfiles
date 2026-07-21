import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

PanelWindow {
    anchors.top: true
    implicitWidth: 280
    implicitHeight: 300
    margins.top: 5
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"
    visible: Globals.activePopup === "audioOutput"
    anchors.left: true
    margins.left: (screen.width / 2) + 220

    property var sinkNodes: {
        let result = [];
        for (let i = 0; i < Pipewire.nodes.values.length; i++) {
            const n = Pipewire.nodes.values[i];
            if (n.type === PwNodeType.AudioSink && !n.isStream)
                result.push(n);
        }
        return result;
    }
    PwObjectTracker {
        objects: sinkNodes
    }

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: Qt.rgba(0.02, 0.035, 0.04, 0.85)
        border.width: 1
        border.color: "gray"

        ScrollView {
            anchors.fill: parent
            anchors.margins: 10
            clip: true
            contentWidth: availableWidth
            ScrollBar.vertical.policy: ScrollBar.AlwaysOff

            ColumnLayout {
                width: parent.width
                spacing: 8

                Text {
                    Layout.fillWidth: true
                    text: "Audio Output"
                    color: "white"
                    font.family: Theme.monoFontFamily
                    font.bold: true
                    font.pixelSize: 14
                }
                Seperator {
                    Layout.fillWidth: true
                }

                Repeater {
                    model: sinkNodes
                    delegate: sinkDelegate
                }
            }
        }
    }

    Component {
        id: sinkDelegate
        Rectangle {
            width: parent ? parent.width : 0
            height: 44
            radius: 8
            color: "transparent"

            Row {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                spacing: 10

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "\uf028"
                    font.family: Theme.fontFamily
                    color: Pipewire.defaultAudioSink === modelData ? "lightgreen" : "white"
                    font.pixelSize: 16
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: modelData ? (modelData.description || modelData.name) : ""
                        font.pixelSize: 14
                        font.family: Theme.monoFontFamily
                        color: "white"
                        elide: Text.ElideRight
                        width: 160
                    }
                    Text {
                        text: modelData && Pipewire.defaultAudioSink === modelData ? "Active" : "Available"
                        font.pixelSize: 11
                        font.family: Theme.fontFamily
                        color: modelData && Pipewire.defaultAudioSink === modelData ? "lightgreen" : Qt.rgba(1, 1, 1, 0.5)
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (modelData)
                        Pipewire.preferredDefaultAudioSink = modelData;
                }
            }
        }
    }
}
