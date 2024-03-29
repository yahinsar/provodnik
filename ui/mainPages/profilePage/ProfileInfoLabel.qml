import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string labelText: ""
    radius: 10
    color: "transparent"
    width: 220
    height: 40
    border.color: mainAppColor
    Label {
        text: labelText
        color: mainTextColor
        font.pointSize: 14
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}
