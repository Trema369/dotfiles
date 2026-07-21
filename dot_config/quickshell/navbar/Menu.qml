import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire

Item {
    id: menu
    width: parent.width
    height: parent.height

    GridLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.leftMargin: 20
        anchors.rightMargin: 20

        columns: 2
        rows: 6
        rowSpacing: 10
        columnSpacing: 10

        // clock / date row
        Row {
            id: idleRow
            spacing: 6
            Layout.row: 0
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.fillWidth: true

            Text {
                id: time
                text: Time.time
                color: "white"
                font.family: Theme.fontFamily
                font.bold: true
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
            }
            Text {
                anchors.baseline: time.baseline
                text: Time.dateStr
                color: "gray"
                font.family: Theme.fontFamily
                font.pixelSize: 15
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Rectangle {
            id: wifiButton
            Layout.row: 1
            Layout.column: 0
            Layout.fillWidth: true
            Layout.preferredHeight: 60
            radius: 35
            color: Qt.rgba(1, 1, 1, 0.15)
            border.color: Qt.rgba(1, 1, 1, 0.3)
            border.width: 1

            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                spacing: 10

                Rectangle {
                    width: 36
                    height: 36
                    radius: width / 2
                    color: Qt.rgba(1, 1, 1, 0.15)
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        anchors.centerIn: parent
                        text: "\uf1eb"
                        font.family: Theme.fontFamily
                        color: "white"
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        text: "Wi-fi"
                        color: "white"
                        font.family: Theme.monofontFamily
                        font.weight: Font.Bold
                        font.pixelSize: 13
                        font.bold: true
                        font.capitalization: Font.AllUppercase
                    }
                    Text {
                        text: Globals.connectedWifiSsid
                        color: "white"
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Globals.activePopup = Globals.activePopup === "wifi" ? "" : "wifi"
            }
        }

        // bluetooth
        Rectangle {
            Layout.row: 1
            Layout.column: 1
            Layout.fillWidth: true
            Layout.preferredHeight: 65
            radius: 35
            color: Qt.rgba(1, 1, 1, 0.15)
            border.color: Qt.rgba(1, 1, 1, 0.3)
            border.width: 1
            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                spacing: 10

                Rectangle {
                    width: 36
                    height: 36
                    radius: width / 2
                    color: Qt.rgba(1, 1, 1, 0.15)
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        anchors.centerIn: parent
                        text: "\udb80\udcaf"
                        font.family: Theme.fontFamily
                        font.pixelSize: 14
                        color: "white"
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        text: "Bluetooth"
                        color: "white"
                        font.family: Theme.monofontFamily
                        font.weight: Font.Bold
                        font.pixelSize: 13
                        font.bold: true

                        font.capitalization: Font.AllUppercase
                    }
                    Text {
                        text: Globals.connectedBluetoothDevice
                        color: "white"
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Globals.activePopup = Globals.activePopup === "bluetooth" ? "" : "bluetooth"
            }
        }

        // audio output
        Rectangle {
            Layout.row: 2
            Layout.column: 0
            Layout.fillWidth: true
            Layout.preferredHeight: 65
            radius: 35
            color: Qt.rgba(1, 1, 1, 0.15)
            border.color: Qt.rgba(1, 1, 1, 0.3)
            border.width: 1

            property string currentOutput: {
                const sink = Pipewire.defaultAudioSink;
                return sink ? (sink.description || sink.name) : "No output";
            }

            Row {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                spacing: 10

                Rectangle {
                    width: 36
                    height: 36
                    radius: width / 2
                    color: Qt.rgba(1, 1, 1, 0.15)
                    anchors.verticalCenter: parent.verticalCenter
                    Text {
                        anchors.centerIn: parent
                        text: "\ue638"
                        font.family: Theme.monofontFamily
                        color: "white"
                        font.pixelSize: 16
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2
                    Text {
                        text: "Audio"
                        color: "white"
                        font.family: Theme.monofontFamily
                        font.weight: Font.Bold
                        font.pixelSize: 13
                        font.bold: true

                        font.capitalization: Font.AllUppercase
                    }
                    Text {
                        text: currentOutput
                        color: "white"
                        font.family: Theme.fontFamily
                        font.pixelSize: 12
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Globals.activePopup = Globals.activePopup === "audioOutput" ? "" : "audioOutput"
            }
        }

        BatteryProfile {
            Layout.row: 2
            Layout.column: 1
            Layout.fillWidth: true
            Layout.preferredHeight: 65
        }

        Seperator {
            Layout.row: 3
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 5
            Layout.bottomMargin: 5
            width: parent.width * 2.5
        }

        ActionBelt {
            Layout.row: 4
            Layout.column: 0
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.preferredHeight: 65
        }

        Volume {
            Layout.row: 5
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.fillWidth: true
            Layout.preferredHeight: 40
        }
    }
}
