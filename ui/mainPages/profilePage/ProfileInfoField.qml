import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

TextField {
    id: profileInfoField
    property string iconName: ""
    property string startText: ""
    width: profileRect.width - 230 - 40
    anchors {
        left: ProfileInfoLabel.right
        right: profileRect.right
        leftMargin: 20
        rightMargin: 20
    }
    placeholderText: startText
    placeholderTextColor: mainTextColor
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
        width: profileRect.width - 230 - 40
        anchors {
            left: ProfileInfoLabel.right
            right: profileRect.right
            leftMargin: 20
            rightMargin: 20
        }
        height: 1
        Layout.alignment: parent.AlignHCenter
        anchors.bottom: parent.bottom
        color: mainAppColor
    }
}
