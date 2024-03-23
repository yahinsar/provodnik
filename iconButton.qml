import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    property bool isPressed: false

    signal clicked()

    onClicked: {
        isPressed = !isPressed;
        clicked();
    }

    background: Rectangle {
        color: isPressed ? "#CCCCCC" : control.pressed ? "#CCCCCC" : control.hovered ? "#EFEFEF" : "#FFFFFF"
        radius: 10
        border.width: 2
        border.color: "#000000"
    }
}
