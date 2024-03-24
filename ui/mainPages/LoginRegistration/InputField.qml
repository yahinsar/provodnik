import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField {
    id: textFieldWithIcon
    property string iconName: ""
    property string startText: ""
    width: parent.width
    placeholderText: startText
    placeholderTextColor: mainTextCOlor
    Layout.preferredWidth: parent.width
    Layout.alignment: Qt.AlignHCenter
    color: mainTextCOlor
    font.pointSize: 14
    leftPadding: 20
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        radius: implicitHeight / 2
        color: "transparent"
    }
    Rectangle {
        width: parent.width - 10
        height: 1
        Layout.alignment: parent.AlignHCenter
        anchors.bottom: parent.bottom
        color: mainAppColor
    }
}
