import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    property Item pageContent: null

    Rectangle {
        id: background
        anchors.fill: parent
        color: "lightgrey"
    }

    ToolBar {
        id: header
        // Добавьте заголовок страницы, кнопку "Назад" и другие элементы
    }

    Item {
        id: contentItem
        anchors {
            left: parent.left
            right: parent.right
            top: header.bottom
            bottom: parent.bottom
        }
        // Поместите содержимое страницы в этот Item
        // Можно привязать к pageContent
        Item {
            anchors.fill: parent
            visible: !!pageContent
            Loader {
                sourceComponent: pageContent
                anchors.fill: parent
            }
        }
    }
}
