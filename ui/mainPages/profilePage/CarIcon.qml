import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string labelText: ""
    radius: 10
    color: "transparent"
    width: 40
    height: 40
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
