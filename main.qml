import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

import "functions.js" as Scripts

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

    Rectangle { // Custom drawer
        id: topMenu
        z: 1
        anchors { top: parent.top; leftMargin: 0 }
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
                        menuButtonsGroup.checkedButton = null // unchek all
                    }
                }
            }
        }
        HorizontalSeparator { }
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

    Rectangle {
        id: leftMenu
        z: 1
        x: -width
        anchors { top: topMenu.bottom; bottom: parent.bottom; topMargin: 1 }
        width: buttonsMenu.width
        color: "black"

        ListModel {
            id: buttonModel
            ListElement { text: "Settings"; icon: "settings.svg"; page: "UnitsSettings.qml" }
            ListElement { text: "Mission Planner"; icon: "waypoint.svg"; page: "" }
        }

        ButtonGroup {
            id: menuButtonsGroup
            exclusive: true;
        }

        ListView {
            id: buttonsMenu
            spacing: 1
            implicitWidth: contentItem.childrenRect.width
            height: parent.height

            model: buttonModel
            delegate: Button {
                id: menuButton
                property alias cursorShape: buttonMouseArea.cursorShape
                cursorShape: Qt.PointingHandCursor
                anchors { left: parent.left; right: parent.right }
                height: fontMetrics.height * 3
                checkable: true
                text: model.text;
                enabled: true
                hoverEnabled: true;
                ButtonGroup.group: menuButtonsGroup
                background: Rectangle {
                    color: parent.checked ? "#1c2171" : "black"
                }
                onClicked: settingsPageLoader.source = model.page

                MouseArea {
                    id: buttonMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    /// Pass signal transparently to upper Button
                    onPressed:  mouse.accepted = false
                }

                contentItem: Row {
                    id: row
                    spacing: fontMetrics.averageCharacterWidth * 2
                    Image {
                        source: model.icon
                        anchors.verticalCenter: parent.verticalCenter
                        ColorOverlay {
                            anchors.fill: parent
                            source: parent
                            color: parent.parent.parent.hovered ? "#00ffc8" : "transparent"
                        }
                    }
                    Text {
                        text: model.text
                        font: fontMetrics.font
                        anchors.verticalCenter: parent.verticalCenter
                        color: parent.parent.hovered ? "#00ffc8" : "white"
                    }
                }
                HorizontalSeparator { }
            }
        }

        states: [
            State {
                name: "slideOut"; when: leftMenu.slideOut
                PropertyChanges { target: leftMenu; x: 0; }
            },
            State {
                name: "slideIn"; when: leftMenu.slideIn
                PropertyChanges { target: leftMenu; x: -width; }
            }
        ]

        transitions: [
            Transition {
                to: "slideOut"
                NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 400; loops: 1 }
            },
            Transition {
                to: "slideIn"
                NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 400; loops: 1 }
            }
        ]
    }
}
