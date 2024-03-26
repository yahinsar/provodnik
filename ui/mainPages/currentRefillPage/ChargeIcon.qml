import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string labelText: ""
    property string imagePath: ""
    radius: 10
    color: "transparent"
    implicitWidth: 40
    implicitHeight: 40
    border.color: mainAppColor
    Image {
        id: chargeIcon
        source: imagePath
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 35
        height: 35
    }
}
