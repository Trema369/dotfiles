pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")
    readonly property string dateStr: Qt.formatDateTime(clock.date, "d ddd")

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
