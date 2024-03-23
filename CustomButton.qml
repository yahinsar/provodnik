import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: customButton
    property alias text: buttonText.text
    property alias anchors: customButton.anchors

    contentItem: Text {
        id: buttonText
        color: "#000000"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 10
        text: customButton.text
    }

    background: Rectangle {
        Gradient {
            id: normalGradient
            GradientStop { position: 0.0; color: "#FFFFFF" }
            GradientStop { position: 0.5; color: "#a1f570" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
        Gradient {
            id: hoveredGradient
            GradientStop { position: 0.0; color: "#FFFFFF" }
            GradientStop { position: 0.5; color: "#a1f570" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
        Gradient {
            id: pressedGradient
            GradientStop { position: 0.0; color: "#FFFFFF" }
            GradientStop { position: 0.5; color: "#a1f570" }
            GradientStop { position: 1.0; color: "#FFFFFF" }
        }
        implicitWidth: 100
        implicitHeight: 50
        gradient: testButton.pressed ? pressedGradient :
                  testButton.hovered ? hoveredGradient :
                                       normalGradient
        radius: 5
        border.width: 1.0
        border.color: "#9C9C9C"
    }
}
