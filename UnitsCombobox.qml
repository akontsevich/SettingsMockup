import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id: control

    delegate: ItemDelegate {
        width: control.width
        contentItem: Text {
            text: modelData
            color: hovered ? "#00ffc8" : "#486fff"
            font: control.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
        background: Rectangle {
            color: control.currentIndex === index ? "#ffffc8" : "white"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            /// Pass signal transparently to upper Combobox
            onPressed:  mouse.accepted = false
        }

        highlighted: control.highlightedIndex === index
    }

    /// No indicator
    indicator: Canvas {
    }

    contentItem: Text {
        id: text
        leftPadding: 0
        rightPadding: control.spacing

        text: control.displayText
        font: control.font
        color: control.pressed ? "#486fff" : "#486fff"
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        //implicitWidth: 240
        implicitHeight: control.font.pixelSize + 8
        color: "black"
        border.color: "#486fff"
        border.width: control.hovered ? 2 : 0
        radius: 8
        anchors { fill: parent; leftMargin: -8; rightMargin: -8; }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            /// Pass signal transparently to upper Combobox
            onPressed:  mouse.accepted = false
        }
    }

    popup: Popup {
        x: -4
        y: control.height
        width: control.width + 8
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitWidth: contentItem.childrenRect.width
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            //color: "#808080"
            anchors { fill: parent; margins: -4; }
            radius: 8
            border.color: "#486fff"
            border.width: 2
        }
    }
}
