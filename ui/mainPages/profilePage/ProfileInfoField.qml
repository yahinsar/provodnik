import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField {
    id: profileInfoField
    property string iconName: ""
    property string startText: ""
    width: 250
    placeholderText: startText
    placeholderTextColor: mainTextColor
    Layout.preferredWidth: parent.width
    Layout.alignment: Qt.AlignHCenter
    color: mainTextColor
    font.pointSize: 14
    leftPadding: 5
    background: Rectangle {
        width: 200
        height: 40
        radius: implicitHeight / 2
        color: "transparent"
    }
    Rectangle {
        width: 265
        height: 1
        Layout.alignment: parent.AlignHCenter
        anchors.bottom: parent.bottom
        color: mainAppColor
    }
}
