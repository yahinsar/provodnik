import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField {
    id: textFieldWithIcon
    property string iconName: ""
    property string startText: ""
    width: parent.width
    placeholderText: startText
    placeholderTextColor: mainTextColor
    Layout.preferredWidth: parent.width
    Layout.alignment: Qt.AlignHCenter
    color: mainTextColor
    font.pointSize: 14
    leftPadding: 25
    background: Rectangle {
        color: "transparent"
    }
    Rectangle {
        width: parent.width - 40
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: 20
            rightMargin: 20
        }
        height: 1
        Layout.alignment: parent.AlignHCenter
        anchors.bottom: parent.bottom
        color: mainAppColor
    }
}
