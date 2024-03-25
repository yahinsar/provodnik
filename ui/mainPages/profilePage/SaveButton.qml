import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    text: qsTr("Сохранить изменения")
    palette.buttonText: "white"
    onClicked: saveChanges()
    background: Rectangle {
            color: "transparent"
            radius: 10
            border.width: 2
            border.color: mainAppColor
        }
}
