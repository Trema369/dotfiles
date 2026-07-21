// Pomodoro.qml
pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root
    property int remainingSeconds: 0
    property bool running: false
    property bool paused: false

    function start(minutes) {
        remainingSeconds = minutes * 60;
        running = true;
        paused = false;
    }

    function pause() {
        running = false;
        paused = true;
    }

    function resume() {
        running = true;
        paused = false;
    }

    function stop() {
        running = false;
        paused = false;
        remainingSeconds = 0;
    }

    function formatted() {
        const m = Math.floor(remainingSeconds / 60);
        const s = remainingSeconds % 60;
        return m + ":" + (s < 10 ? "0" : "") + s;
    }

    Timer {
        interval: 1000
        running: root.running
        repeat: true
        onTriggered: {
            if (root.remainingSeconds > 0) {
                root.remainingSeconds--;
            } else {
                root.running = false;
            }
        }
    }
}
