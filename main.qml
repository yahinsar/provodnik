import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
ApplicationWindow {
    visible: true
    width: 500
    height: 800

    StackView {
        id: stackView
        anchors.fill: parent

        // Создаем экземпляр CustomPage с использованием sourceComponent
        initialItem: LoginRegistration {}
    }
}
