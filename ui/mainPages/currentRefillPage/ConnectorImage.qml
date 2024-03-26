import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property string labelText: ""
    property string imagePath: ""
    radius: 10
    color: "transparent"
    implicitWidth: 50
    implicitHeight: 50
    Image {
        id: chargeIcon
        source: imagePath
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 45
        height: 45
    }
}
