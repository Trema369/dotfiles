import Quickshell
import Quickshell.Networking
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
    visible: Globals.activePopup === "wifi"
    anchors.right: true
    margins.right: (screen.width / 2) + 220

    property var wifiDevice: {
        for (let i = 0; i < Networking.devices.values.length; i++) {
            if (Networking.devices.values[i].type === DeviceType.Wifi)
                return Networking.devices.values[i];
        }
        return null;
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            let found = "Not connected";
            for (let i = 0; i < allNetworks.length; i++) {
                if (allNetworks[i].connected) {
                    found = allNetworks[i].name;
                    break;
                }
            }
            Globals.connectedWifiSsid = found;
        }
    }

    property var allNetworks: {
        let result = [];
        if (wifiDevice) {
            for (let i = 0; i < wifiDevice.networks.values.length; i++) {
                result.push(wifiDevice.networks.values[i]);
            }
        }
        return result;
    }

    onVisibleChanged: {
        if (visible && wifiDevice) {
            wifiDevice.scannerEnabled = true;
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
                    text: "Wi-fi"
                    color: "white"
                    font.family: Theme.monoFontFamily
                    font.bold: true
                    font.pixelSize: 14
                }
                Seperator {
                    Layout.fillWidth: true
                }

                Repeater {
                    model: allNetworks
                    delegate: networkDelegate
                }
            }
        }
    }

    Component {
        id: networkDelegate
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
                    text: "\uf1eb"
                    font.family: Theme.fontFamily
                    color: modelData.connected ? "lightgreen" : "white"
                    font.pixelSize: 16
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: modelData.name
                        font.pixelSize: 14
                        font.family: Theme.monoFontFamily
                        color: "white"
                    }
                    Text {
                        text: modelData.connected ? "Connected" : WifiSecurityType.toString(modelData.security)
                        font.pixelSize: 11
                        font.family: Theme.fontFamily
                        color: modelData.connected ? "lightgreen" : Qt.rgba(1, 1, 1, 0.5)
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (modelData.connected) {
                        modelData.disconnect();
                    } else if (modelData.known) {
                        modelData.connect();
                    } else {
                        passwordDialog.targetNetwork = modelData;
                        passwordDialog.visible = true;
                    }
                }
            }
        }
    }

    Rectangle {
        id: passwordDialog
        property var targetNetwork: null

        anchors.fill: parent
        color: "#000000cc"
        radius: 12
        visible: false

        Column {
            anchors.centerIn: parent
            spacing: 10
            width: parent.width - 40

            Text {
                text: passwordDialog.targetNetwork ? "Connect to " + passwordDialog.targetNetwork.name : ""
                color: "white"
            }

            TextField {
                id: pskInput
                width: parent.width
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: "white"
                placeholderTextColor: "#888888"

                background: Rectangle {
                    color: "#1a1a1a"
                    radius: 6
                    border.color: "#333333"
                    border.width: 1
                }
            }

            Row {
                spacing: 10
                Button {
                    text: "Connect"
                    onClicked: {
                        passwordDialog.targetNetwork.connectWithPsk(pskInput.text);
                        passwordDialog.visible = false;
                        pskInput.text = "";
                    }
                }
                Button {
                    text: "Cancel"
                    onClicked: {
                        passwordDialog.visible = false;
                        pskInput.text = "";
                    }
                }
            }
        }
    }
}
