pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property string activePopup: ""
    property string connectedWifiSsid: "Not connected"
    property string connectedBluetoothDevice: "Not connected"
    property bool requestPomodoroSetup: false
    property bool requestDisplaySetup: false
    property bool requestReturnToIdle: false
    property bool requestReturnToExpanded: false
}
