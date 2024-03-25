import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: portRectangle
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    property color redColor: "#EA8B86"
    property string labelText: ""

    property string portNumber: modelData.portNumber
    property string power: modelData.power
    property string status: modelData.status
    property string typeName: modelData.typeName
    property string connectorImage: portInfo.connectorImage
    radius: 10
    border.width: 1
    //color: mainAppColor
    color: mainAppColor
    width: listView.width - 10
    anchors {
        left: parent.left
        right: listView.right
        leftMargin: 5
        rightMargin: 5
    }
    height: 40
    //anchors.leftMargin: 5
    //anchors.horizontalCenter: listView.horizontalCenter
    //anchors.left: stationRect + 10
    //anchors.right: parent.right
//    anchors.rightMargin: 5
    border.color: mainBackgroundColor
        Image {
            id: connectorTypeImage
            source: "icons/" + connectorImage
            //anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
//            anchors {
//                top: parent.top
//                topMargin: 10
//                leftMargin: 5
//            }
            width: 35
            height: 35
        }

        property string lastChargeStart: modelData.lastChargeStart
        property int elapsedTimeSeconds: 0
        property int hours: 0
        property int minutes: 0
        property int seconds: 0

        function updateElapsedTime() {
            var startDate = new Date(lastChargeStart.replace(/-/g, '/'));
            var now = new Date();
            var difference = Math.floor((now - startDate) / 1000);
            elapsedTimeSeconds = difference;
            hours = Math.floor(difference / 3600);
            difference = difference % 3600;
            minutes = Math.floor(difference / 60);
            seconds = difference % 60;
        }

        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: updateElapsedTime()
        }

        Text {
            font.pointSize: 11
            text: portInfo.typeName + " | " + modelData.power + " кВт | Зарядка | С момента начала: " + parent.hours + " ч. " + parent.minutes + " м. " + parent.seconds + " с."

            color: "black"
            anchors {
                top: connectorTypeImage.top
                left: connectorTypeImage.right
                leftMargin: 5
                verticalCenter: parent.verticalCenter
            }
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
}
