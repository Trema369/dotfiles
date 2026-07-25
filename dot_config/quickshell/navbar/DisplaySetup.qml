import QtQuick

Item {
    id: displaySetup
    anchors.fill: parent

    onVisibleChanged: if (visible)
        Displays.refresh()

    // outputs that can receive a cast from the source screen
    readonly property var castTargets: {
        const out = [];
        for (let i = 0; i < Displays.monitors.length; i++) {
            if (Displays.monitors[i].name !== Displays.primaryName)
                out.push(Displays.monitors[i]);
        }
        return out;
    }

    // back button — top-left, matches PomodoroSetup
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        width: 28
        height: 28
        radius: 14
        color: Qt.rgba(1, 1, 1, 0.15)
        z: 2

        Text {
            anchors.centerIn: parent
            text: ""
            font.family: Theme.iconFontFamily
            color: "white"
            font.pixelSize: 12
        }

        MouseArea {
            anchors.fill: parent
            onClicked: Globals.requestReturnToExpanded = true
        }
    }

    Text {
        anchors.top: parent.top
        anchors.topMargin: 16
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Displays"
        color: "white"
        font.family: Theme.monofontFamily
        font.bold: true
        font.pixelSize: 14
        font.capitalization: Font.AllUppercase
    }

    Column {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 48
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 8

        Repeater {
            model: Displays.monitors

            delegate: Rectangle {
                id: card
                required property var modelData

                readonly property bool isPrimary: modelData.name === Displays.primaryName
                readonly property string mode: Displays.modeOf(modelData)
                readonly property bool lastLiveOutput: !modelData.disabled && Displays.enabledCount <= 1

                width: parent.width
                height: 76
                radius: 18
                color: Qt.rgba(1, 1, 1, 0.15)
                border.color: Qt.rgba(1, 1, 1, 0.3)
                border.width: 1

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 4

                    Row {
                        width: parent.width
                        spacing: 6

                        Text {
                            text: card.modelData.name
                            color: "white"
                            font.family: Theme.monofontFamily
                            font.bold: true
                            font.pixelSize: 12
                        }

                        Text {
                            width: parent.width - 6 - x
                            text: card.modelData.label
                            color: Qt.rgba(1, 1, 1, 0.5)
                            font.family: Theme.fontFamily
                            font.pixelSize: 11
                            elide: Text.ElideRight
                        }
                    }

                    Text {
                        text: {
                            if (card.modelData.disabled)
                                return "off";
                            if (card.mode === "mirror")
                                return "mirroring " + card.modelData.mirrorOf;
                            return card.modelData.mode + (card.isPrimary ? "  ·  source" : "");
                        }
                        color: card.modelData.disabled ? Qt.rgba(1, 1, 1, 0.4) : "lightgreen"
                        font.family: Theme.fontFamily
                        font.pixelSize: 11
                    }

                    Row {
                        width: parent.width
                        spacing: 6
                        topPadding: 2

                        Repeater {
                            model: [
                                {
                                    label: "Extend",
                                    key: "extend"
                                },
                                {
                                    label: "Mirror",
                                    key: "mirror"
                                },
                                {
                                    label: "Off",
                                    key: "off"
                                }
                            ]

                            delegate: Rectangle {
                                required property var modelData

                                readonly property bool active: card.mode === modelData.key
                                readonly property bool actionable: {
                                    if (!Displays.multiOutput)
                                        return false;
                                    if (modelData.key === "mirror")
                                        return !card.isPrimary;
                                    if (modelData.key === "off")
                                        return !card.lastLiveOutput;
                                    return true;
                                }

                                width: (card.width - 20 - 12) / 3
                                height: 24
                                radius: 12
                                color: active ? Qt.rgba(1, 1, 1, 0.4) : Qt.rgba(1, 1, 1, 0.1)
                                opacity: actionable || active ? 1 : 0.35

                                Text {
                                    anchors.centerIn: parent
                                    text: parent.modelData.label
                                    color: "white"
                                    font.family: Theme.fontFamily
                                    font.pixelSize: 11
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    enabled: parent.actionable
                                    onClicked: {
                                        switch (parent.modelData.key) {
                                        case "extend":
                                            Displays.extend(card.modelData.name);
                                            break;
                                        case "mirror":
                                            Displays.mirror(card.modelData.name, Displays.primaryName);
                                            break;
                                        case "off":
                                            Displays.off(card.modelData.name);
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Seperator {
            width: parent.width
        }

        Text {
            text: Displays.multiOutput ? "Cast this screen to" : "No other outputs connected"
            color: Qt.rgba(1, 1, 1, 0.5)
            font.family: Theme.fontFamily
            font.pixelSize: 11
        }

        Repeater {
            model: displaySetup.castTargets

            delegate: Item {
                id: target
                required property var modelData

                readonly property bool casting: modelData.mirrorOf === Displays.primaryName

                width: parent.width
                height: 26

                Row {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 12
                        height: 12
                        radius: 6
                        color: "transparent"
                        border.width: 1
                        border.color: target.casting ? "lightgreen" : Qt.rgba(1, 1, 1, 0.4)

                        Rectangle {
                            anchors.centerIn: parent
                            width: 6
                            height: 6
                            radius: 3
                            color: "lightgreen"
                            visible: target.casting
                        }
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: target.modelData.name
                        color: target.casting ? "lightgreen" : "white"
                        font.family: Theme.monofontFamily
                        font.pixelSize: 12
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (target.casting)
                            Displays.extend(target.modelData.name);
                        else
                            Displays.mirror(target.modelData.name, Displays.primaryName);
                    }
                }
            }
        }

        Text {
            width: parent.width
            visible: Displays.lastError !== ""
            text: Displays.lastError
            color: "#ff8888"
            font.family: Theme.fontFamily
            font.pixelSize: 10
            wrapMode: Text.Wrap
        }
    }
}
