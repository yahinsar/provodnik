import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    property string labelText: ""
    radius: 10
    color: "transparent"
    implicitWidth: 40
    implicitHeight: 40
    border.color: mainAppColor
    Image {
        id: carIcon
        source: "icons/electric-car-green.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 35
        height: 35
    }
}