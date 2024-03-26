import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.15
import "../../../ui/BottomBar"

Row {

    id: profileBottomBarButtonsRow
    spacing: 5
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    property color mainButtonColor: mainAppColor

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
