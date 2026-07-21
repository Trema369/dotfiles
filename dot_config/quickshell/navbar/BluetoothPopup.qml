import Quickshell
import Quickshell.Bluetooth
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
    visible: Globals.activePopup === "bluetooth"
    anchors.left: true
    margins.left: (screen.width / 2) + 220

    onVisibleChanged: {
        if (visible && Bluetooth.defaultAdapter) {
            Bluetooth.defaultAdapter.discovering = true;
        }
    }

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(0.02, 0.035, 0.04, 0.85)

        radius: 12
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
                    text: "Bluetooth"
                    color: "white"
                    font.family: Theme.monoFontFamily
                    font.bold: true
                    font.pixelSize: 14
                }
                Seperator {
                    Layout.fillWidth: true
                }

                Repeater {
                    model: Bluetooth.devices
                    delegate: deviceDelegate
                }
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            let found = "Not connected";
            for (let i = 0; i < Bluetooth.devices.values.length; i++) {
                if (Bluetooth.devices.values[i].connected) {
                    found = Bluetooth.devices.values[i].name;
                    break;
                }
            }
            Globals.connectedBluetoothDevice = found;
        }
    }

    Component {
        id: deviceDelegate
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
                    text: "\udb80\udcaf"
                    font.family: Theme.fontFamily
                    color: modelData && modelData.connected ? "lightgreen" : "white"
                    font.pixelSize: 16
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: modelData ? modelData.name : ""
                        font.pixelSize: 14
                        font.family: Theme.monoFontFamily
                        color: "white"
                    }
                    Text {
                        text: {
                            if (!modelData)
                                return "";
                            if (modelData.connected)
                                return "Connected";
                            return modelData.paired ? "Paired" : "Available";
                        }
                        font.pixelSize: 11
                        font.family: Theme.fontFamily
                        color: modelData && modelData.connected ? "lightgreen" : Qt.rgba(1, 1, 1, 0.5)
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (!modelData)
                        return;
                    if (modelData.connected) {
                        modelData.disconnect();
                    } else if (modelData.paired) {
                        modelData.connect();
                    } else {
                        modelData.pair();
                    }
                }
            }
        }
    }
}
