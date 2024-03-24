import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.15

Button {
    property color backgroundColor: "#FFFFFF"
    display: AbstractButton.TextUnderIcon
    background: Rectangle {
            color: backgroundColor
            radius: 10
            border.width: 2
            border.color: "#000000"
        }
}
