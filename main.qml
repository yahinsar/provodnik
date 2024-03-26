import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "ui/mainPages/LoginRegistration"
ApplicationWindow {
    visible: true
    x: 0
    y: 0

    function setAndroidResolution() {
        width = 720
        height = 1080
        minimumWidth = 720
        minimumHeight = 1080
    }

    function oldResolution() {
        width = 520
        height = 800
        minimumWidth = 530
        minimumHeight = 800
    }

    function setDesktopResolution() {
        width = 1920
        height = 1080
        minimumWidth = 1920
        minimumHeight = 1080
    }

    Component.onCompleted: {
        //setAndroidResolution();
        //setDesktopResolution();
        oldResolution();
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: InputNumberPage {}
    }
}
