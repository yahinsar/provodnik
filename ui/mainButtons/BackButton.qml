import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: backButton
    property bool twoPop: false
    //text: "Back"
    onClicked: {
        stackView.pop()
        if (twoPop)
            stackView.pop()
    }
    icon.source: "icons/back.png"
    anchors.bottom: parent.bottom
    anchors.left: parent.left
}
