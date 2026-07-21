import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent

    property int selectedMinutes: 25
    property bool sessionActive: Pomodoro.running || Pomodoro.paused

    // back button — top-left
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        width: 28
        height: 28
        radius: 14
        color: Qt.rgba(1, 1, 1, 0.15)

        Text {
            anchors.centerIn: parent
            text: "\uf060"   // left-arrow, verify against your font
            font.family: "Maple Mono NF Base"
            color: "white"
            font.pixelSize: 12
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Globals.requestReturnToExpanded = true
        }
    }

    // fresh picker — only when nothing is active
    Column {
        anchors.centerIn: parent
        spacing: 15
        width: parent.width - 40
        visible: !sessionActive

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: selectedMinutes + " min"
            color: "white"
            font.family: Theme.monoFontFamily
            font.pixelSize: 28
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter
            Repeater {
                model: [15, 25, 45, 60]
                delegate: Rectangle {
                    required property int modelData
                    width: 50
                    height: 30
                    radius: 15
                    color: selectedMinutes === modelData ? Qt.rgba(1, 1, 1, 0.4) : Qt.rgba(1, 1, 1, 0.15)
                    Text {
                        anchors.centerIn: parent
                        text: modelData + "m"
                        color: "white"
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: selectedMinutes = modelData
                    }
                }
            }
        }

        Slider {
            width: parent.width
            from: 1
            to: 120
            stepSize: 1
            value: selectedMinutes
            onMoved: selectedMinutes = Math.round(value)
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 36
            radius: 18
            color: Qt.rgba(1, 1, 1, 0.25)
            Text {
                anchors.centerIn: parent
                text: "Start"
                color: "white"
                font.family: Theme.fontFamily
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Pomodoro.start(selectedMinutes);
                    Globals.requestReturnToIdle = true;
                }
            }
        }
    }

    // running/paused controls
    Column {
        anchors.centerIn: parent
        spacing: 15
        visible: sessionActive

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Pomodoro.formatted()
            color: "white"
            font.family: Theme.monoFontFamily
            font.pixelSize: 32
        }

        Row {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: 90
                height: 36
                radius: 18
                color: Qt.rgba(1, 1, 1, 0.25)
                Text {
                    anchors.centerIn: parent
                    text: Pomodoro.running ? "Pause" : "Resume"
                    color: "white"
                    font.family: Theme.fontFamily
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Pomodoro.running ? Pomodoro.pause() : Pomodoro.resume()
                }
            }

            Rectangle {
                width: 90
                height: 36
                radius: 18
                color: Qt.rgba(1, 0.3, 0.3, 0.25)
                Text {
                    anchors.centerIn: parent
                    text: "Stop"
                    color: "white"
                    font.family: Theme.fontFamily
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        Pomodoro.stop();
                        Globals.requestReturnToIdle = true;
                    }
                }
            }
        }
    }
}
