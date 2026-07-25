import QtQuick

Item {
    id: actionBelt

    Rectangle {
        anchors.fill: parent
        radius: height / 2
        color: Qt.rgba(1, 1, 1, 0.15)
        border.color: Qt.rgba(1, 1, 1, 0.3)
        border.width: 1

        Row {
            anchors.fill: parent
            anchors.margins: 6
            spacing: 8

            Repeater {
                model: [
                    {
                        icon: "\uf030",
                        name: "screenshot"
                    }   // camera
                    ,
                    {
                        icon: "\uf111",
                        name: "record"
                    }       // circle/record
                    ,
                    {
                        icon: "\uf133",
                        name: "calendar"
                    }     // calendar
                    ,
                    {
                        icon: "\uf1d8",
                        name: "glance"
                    }       // search/paper-plane placeholder
                    ,
                    {
                        icon: "\uf017",
                        name: "pomodoro"
                    }     // clock
                    ,
                    {
                        icon: "\uf209",
                        name: "display"
                    }       // display / cast
                ]

                delegate: Rectangle {
                    required property var modelData
                    width: (actionBelt.width - 6 * 2 - 5 * 8) / 6
                    height: parent.height
                    radius: height / 2
                    color: Qt.rgba(1, 1, 1, 0.1)

                    Text {
                        anchors.centerIn: parent
                        text: modelData.icon
                        font.family: "Maple Mono NF Base"
                        font.pixelSize: 18
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            switch (modelData.name) {
                                case "pomodoro":
                                    Globals.requestPomodoroSetup = true;
                                    break;
                                case "display":
                                    Globals.requestDisplaySetup = true;
                                    break;
                                default:
                                    console.log(modelData.name + " clicked — not wired yet");
                            }
                        }
                    }

                    Row {
                        id: pomodoroPicker
                        visible: false
                        anchors.top: parent.bottom
                        anchors.topMargin: 5
                        anchors.horizontalCenter: parent.horizontalCenter
                        spacing: 8

                        Repeater {
                            model: [15, 25, 45]
                            delegate: Rectangle {
                                required property int modelData
                                width: 40
                                height: 24
                                radius: 12
                                color: Qt.rgba(1, 1, 1, 0.15)
                                Text {
                                    anchors.centerIn: parent
                                    text: modelData + "m"
                                    color: "white"
                                    font.pixelSize: 10
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        Pomodoro.start(modelData);
                                        pomodoroPicker.visible = false;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
