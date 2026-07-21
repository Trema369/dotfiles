import Quickshell.Services.UPower
import QtQuick

Item {
    id: batteryProfile

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Qt.rgba(1, 1, 1, 0.15)
        border.color: Qt.rgba(1, 1, 1, 0.3)
        border.width: 1

        Row {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 4

            Repeater {
                model: [
                    {
                        label: "\udb84\udf94",
                        value: PowerProfile.PowerSaver
                    },
                    {
                        label: "\uf24e",
                        value: PowerProfile.Balanced
                    },
                    {
                        label: "\udb85\udc0b",
                        value: PowerProfile.Performance
                    }
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: (parent.width - 8) / 3
                    height: parent.height
                    radius: height / 2
                    visible: modelData.value !== PowerProfile.Performance || PowerProfiles.hasPerformanceProfile
                    color: PowerProfiles.profile === modelData.value ? Qt.rgba(1, 1, 1, 0.5) : "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: modelData.label
                        color: "white"
                        font.pixelSize: 18
                        font.family: "Maple Mono NF Base"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: PowerProfiles.profile = modelData.value
                    }
                }
            }
        }
    }
}
