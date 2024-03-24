import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.15
import "../../../ui/BottomBar"

Row {

    id: profileBottomBarButtonsRow
    anchors.bottomMargin: 10
    spacing: 5
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    property color mainAppColor: "#6fda9c"
    property color pressedButtonColor: "#297F4B"
    property color hoveredButtonColor: "#35B166"
    property color mainButtonColor: "#6fda9c"
    property color mainTextColor: "white"

    BottomBarButton {
        text: "История"
        icon.source: "icons/history.png"
        onClicked: {
        }
    }

    BottomBarButton {
        text: "Способы оплаты"
        icon.source: "icons/wallet.png"
        onClicked: {
        }
    }

    BottomBarButton {
        text: "Поддержка"
        icon.source: "icons/support.png"
        onClicked: {
        }
    }


    BottomBarButton {
        text: "Настройки"
        icon.source: "icons/setting.png"
        onClicked: {
        }
    }
}
