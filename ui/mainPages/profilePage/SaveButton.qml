import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

//Button {
//    id: saveButton
//    //Layout.alignment: Qt.AlignVCenter
//    display: AbstractButton.TextUnderIcon
//    onClicked: {
//        saveChanges();
//    }
//    icon.source: "icons/save.png"
//    background: Rectangle {
//            color: parent.color
//            radius: 5
//            border.width: 1
//            border.color: "#000000"
//        }
//    width: 10
//    height: 10
//}

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
