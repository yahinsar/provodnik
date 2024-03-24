import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: control
    text: qsTr("Log In")
    font.pointSize: 16
    property alias name: control.text
    property color baseColor: "transparent"
    property color borderColor: "#6fda9c"
    hoverEnabled: false
    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? borderColor : "#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        id: bgrect
        implicitWidth: 100
        implicitHeight: 50
        color: baseColor //"#6fda9c"
        opacity: control.down ? 0.7 : 1
        radius: height/2
        border.color: borderColor
    }
}
