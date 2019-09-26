import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Mockup Window")

    FontMetrics {
        id: fontMetrics
        font.family: "Arial"
        font.pixelSize: 18
    }

    MainToolbar {
        id: topMenu
        anchors { top: parent.top; leftMargin: 0 }
        z: 1
    }

    Loader {
        id: settingsPageLoader
        anchors {
            left: leftMenu.right;
            top: leftMenu.top;
            bottom: leftMenu.bottom
            right: parent.right
            leftMargin: 1
        }
    }

    LeftToolbar {
        id: leftMenu
        anchors { top: topMenu.bottom; bottom: parent.bottom; topMargin: 1 }
        z: 1
    }
}
