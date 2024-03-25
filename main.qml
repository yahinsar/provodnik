import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "ui/mainPages/LoginRegistration"
ApplicationWindow {
    visible: true
    width: 520
    height: 800

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: InputNumberPage {}
    }
}
