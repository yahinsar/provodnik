// stationInfo.qml

import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: parent.width
    height: parent.height

    property string markerType: "" // определите свойство markerType
    property int stationID: 0 // определите свойство markerType

    Row {
        Button {
            text: "Back"
            //anchors.top: parent.top
            //anchors.left: parent.left
            onClicked: stackView.pop()
        }

        Text {
            text: "This stationInfo.qml was launched from " + markerType
        }
    }
}
