import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    property Item pageContent: null

    Rectangle {
        id: background
        anchors.fill: parent
        color: "lightgrey"
    }

    ToolBar {
        id: header
    }

    Item {
        id: contentItem
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
        }
        Item {
            anchors.fill: parent
            visible: !!pageContent
            Loader {
                sourceComponent: pageContent
                anchors.fill: parent
            }
        }
    }
}
