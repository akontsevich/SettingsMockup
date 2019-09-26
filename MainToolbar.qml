import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: topMenu
    z: 1
    height: fontMetrics.height * 3
    width: parent.width
    color: "black"
    Image {
        id: hamburger
        anchors {
            left: parent.left
            leftMargin: parent.height / 3
            verticalCenter: parent.verticalCenter
        }
        source: "menu.svg"
        height: parent.height / 3
        width: height
        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                if(leftMenu.state == "slideOut") {
                    leftMenu.state = "slideIn";
                    settingsPageLoader.source = ""
                } else {
                    leftMenu.state = "slideOut"
                    leftMenu.menuButtonsGroup.checkedButton = null // unchek all
                }
            }
        }
    }
    HorizontalSeparator { }
}
