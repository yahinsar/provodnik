import QtQuick 2.0

Rectangle{
    property alias text: textItem.text
    height: container.visible ? columns.height+5 : 30
    property alias source: loader.source
    anchors { left: parent.left; right: parent.right }
    color: "#53d769"
    clip: true
    Column{
        id: columns
        anchors.left: parent.left
        anchors.right: parent.right
        Text {
            x: 5
            id: textItem
            height: 30
            verticalAlignment: Text.AlignVCenter
        }
        Rectangle{
            id: container
            visible: false
            color: Qt.darker("#53d769", 1.2)
            anchors { left: parent.left; right: parent.right; margins: 5}
            height: loader.height+10
            Loader{
                y: 5
                anchors { left: parent.left; right: parent.right; margins: 5}
                id: loader
                source: loadCmp
            }
        }

    }
    Behavior on height {
        NumberAnimation { duration: 100 }
    }

    MouseArea{
        height: 30
        anchors { left: parent.left; right: parent.right }
        onClicked: {
            container.visible = !container.visible
        }

    }
}
