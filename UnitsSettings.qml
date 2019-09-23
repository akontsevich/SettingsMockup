import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
    anchors.fill: parent
    FontMetrics {
        id: fontMetrics
        font.family: "Arial"
        font.pixelSize: 18
    }

    Rectangle {
        id: unitsPage
        anchors.fill: parent
        z: 1
        color: "black"

        ListModel {
            id: unitsModel
            ListElement {
                text: qsTr("Distance")
                units: [
                    ListElement{ unit: "Feet"},
                    ListElement{ unit: "Meters"}
                ]
            }
            ListElement {
                text: qsTr("Altitude");
                units: [
                    ListElement{ unit: "Feet"},
                    ListElement{ unit: "Meters"},
                    ListElement{ unit: "Kilometers"}
                ]
            }
            ListElement {
                text: qsTr("Area");
                units: [
                    ListElement{ unit: "SquareFeet"},
                    ListElement{ unit: "SquareMeters"},
                    ListElement{ unit: "SquareKilometers"},
                    ListElement{ unit: "Hectares"},
                    ListElement{ unit: "Acres"},
                    ListElement{ unit: "SquareMiles"}
                ]
            }
            ListElement {
                text: qsTr("Speed");
                units: [
                    ListElement{ unit: "Feet/second"},
                    ListElement{ unit: "Meters/second"},
                    ListElement{ unit: "Miles/hour"},
                    ListElement{ unit: "Kilometers/hour"},
                    ListElement{ unit: "Knots"}
                ]
            }
        }

        ListView {
            id: settingsView
            anchors {
                top: parent.top;
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width * 0.85
            height: parent.height

            model: unitsModel

            header: Item {
                id: header
                width: settingsView.width
                height: fontMetrics.height * 3

                Text {
                    color: "grey"
                    text: qsTr("UNITS")
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    font: fontMetrics.font
                    anchors.verticalCenter: parent.verticalCenter
                }
                HorizontalSeparator { }
            }

            delegate: Item {
                id: element
                width: settingsView.width
                height: fontMetrics.height * 5

                Column {
                    anchors.topMargin: fontMetrics.height
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 8
                    Text {
                        color: "white"
                        text: model.text
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        font: fontMetrics.font
                    }
                    UnitsCombobox {
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        model: units
                        width: element.width / 2
                        font: fontMetrics.font
                    }
                }

                HorizontalSeparator { }
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
