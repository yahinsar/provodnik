import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
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
