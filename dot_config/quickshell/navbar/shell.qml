import Quickshell
import QtQuick

PanelWindow {
    anchors.top: true
    implicitHeight: 370
    implicitWidth: 410
    color: "transparent"
    margins.top: 5
    exclusiveZone: 40
    mask: Region {
        item: shape
    }
    BluetoothPopup {}
    WifiPopup {}
    AudioPopup {}
    Rectangle {
        id: shape
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 150
        height: 40
        color: "#04090a"
        radius: 18
        antialiasing: true
        state: "idle"
        onStateChanged: {
            if (state === "idle") {
                Globals.activePopup = "";
            }
        }

        Connections {
            target: Globals
            function onRequestPomodoroSetupChanged() {
                if (Globals.requestPomodoroSetup) {
                    shape.state = "pomodoroSetup";
                    Globals.requestPomodoroSetup = false;
                }
            }
            function onRequestReturnToIdleChanged() {
                if (Globals.requestReturnToIdle) {
                    shape.state = "idle";
                    Globals.requestReturnToIdle = false;
                }
            }
            function onRequestReturnToExpandedChanged() {
                if (Globals.requestReturnToExpanded) {
                    shape.state = "expanded";
                    Globals.requestReturnToExpanded = false;
                }
            }
        }
        Item {
            anchors.centerIn: parent
            width: idleRow.width
            height: idleRow.height
            visible: shape.state === "idle"

            Text {
                id: pomodoroText
                anchors.centerIn: parent
                text: Pomodoro.formatted()
                color: "white"
                font.family: Theme.fontFamily
                visible: Pomodoro.running
                font.bold: true
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
            }

            Row {
                id: idleRow
                anchors.centerIn: parent
                spacing: 6
                visible: !Pomodoro.running

                Text {
                    id: time
                    text: Time.time
                    color: "white"
                    font.family: Theme.fontFamily
                    font.bold: true
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle {
                    width: 4
                    height: 4
                    radius: width / 2
                    color: "white"
                    anchors.verticalCenter: parent.verticalCenter

                    SequentialAnimation on y {
                        loops: Animation.Infinite
                        NumberAnimation {
                            from: 0
                            to: -3
                            duration: 800
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            from: -3
                            to: 0
                            duration: 800
                            easing.type: Easing.InOutSine
                        }
                    }
                }

                Text {
                    anchors.baseline: time.baseline
                    text: Time.dateStr
                    color: "white"
                    font.family: Theme.fontFamily
                    font.pixelSize: 15
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (shape.state === "idle") {
                    shape.state = Pomodoro.running ? "pomodoroSetup" : "expanded";
                } else {
                    shape.state = "idle";
                }
            }
        }
        Menu {
            visible: shape.state === "expanded"
        }

        PomodoroSetup {
            visible: shape.state === "pomodoroSetup"
        }
        states: [
            State {
                name: "idle"
                PropertyChanges {
                    target: shape
                    width: 210
                    height: 40
                }
            },
            State {
                name: "expanded"
                PropertyChanges {
                    target: shape
                    width: 410
                    height: 370
                }
            },
            State {
                name: "pomodoroSetup"
                PropertyChanges {
                    target: shape
                    width: 300
                    height: 220
                }
            }
        ]
        transitions: Transition {
            NumberAnimation {
                properties: "width,height"
                duration: 250
                easing.type: Easing.OutCubic
            }
        }
    }
}
