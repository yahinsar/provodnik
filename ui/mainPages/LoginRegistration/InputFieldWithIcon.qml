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
    //font.family: "fontawesome"
    leftPadding: 50
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40
        radius: implicitHeight / 2
        color: "transparent"
    }

    Image {
        id: carIcon
        source: iconName
        anchors {
            left: parent.left
            leftMargin: 5
            Layout.alignment: parent.AlignHCenter
        }
        width: 30
        height: 30
    }

    Rectangle {
        width: parent.width - 10
        height: 1
        Layout.alignment: parent.AlignHCenter
        anchors.bottom: parent.bottom
        color: mainAppColor
    }
}
