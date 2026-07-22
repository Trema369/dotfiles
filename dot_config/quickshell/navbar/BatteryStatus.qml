import Quickshell.Services.UPower
import QtQuick

Item {
    id: batteryStatus

    readonly property UPowerDevice battery: UPower.displayDevice
    readonly property bool isCharging: battery.state === UPowerDeviceState.Charging

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Qt.rgba(1, 1, 1, 0.15)
        border.color: Qt.rgba(1, 1, 1, 0.3)
        border.width: 1

        Row {
            anchors.centerIn: parent
            spacing: 6

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: batteryStatus.isCharging ? "\uf0e7" : "\uf240"
                font.family: Theme.fontFamily
                color: batteryStatus.isCharging ? "lightgreen" : "white"
                font.pixelSize: 12
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: batteryStatus.battery.ready ? Math.round(batteryStatus.battery.percentage * 100) + "%" : "--"
                color: "white"
                font.family: Theme.monoFontFamily
                font.pixelSize: 11
            }
        }
    }
}
