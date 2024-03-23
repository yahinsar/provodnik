import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    width: parent.width
    height: parent.height

    property int userID: 0
    property var userInfo: ({})

    color: "#fdfdfd"
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#a1f570";
        }
        GradientStop {
            position: 1.00;
            color: "#ffffff";
        }
    }

    Component.onCompleted: {
        userInfo = databaseManager.getUserInfoByID(userID);
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

        Text {
            text: "Профиль пользователя"
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            Layout.leftMargin: 5
        }

        Text {
            id: listText
            text: "Список машин:"
            Layout.alignment: Qt.AlignLeft
            Layout.fillWidth: true
        }

        ListView {
            id: carList
            width: 300
            height: 100
            model: userInfo.carIDs
            anchors.top: listText.bottom
            interactive: false
            delegate: Item {
                width: parent.width
                height: 75
                Rectangle {
                    id: portRect
                    width: listView.width
                    height: 50
                    color: "white"
                    border.color: "black"
                    border.width: 2

                    Image {
                        id: carIcon
                        source: "electric-car.png"
                        anchors {
                            top: parent.top
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                        width: 45
                        height: 35
                    }

                    Text {
                        text: carInfo.brand + " " + carInfo.model + " ; Номер: " + carInfo.licensePlate
                        color: "black"

                        anchors {
                            top: carIcon.top
                            left: carIcon.right
                            leftMargin: 5
                            verticalCenter: parent.verticalCenter
                        }
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Component.onCompleted: {
                    carInfo = databaseManager.getCarInfoByID(modelData)
                }

                property var carInfo: ({})
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Имя: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            TextField {
                id: firstNameField
                placeholderText: "Имя"
                text: userInfo.firstName
            }

            Item {
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: saveIcon1
                    source: "save.png"
                    width: 15
                    height: 15
                    MouseArea {
                        onClicked: saveChanges()
                    }
                }
            }

        }

        RowLayout {
            spacing: 10
            Label {
                text: "Фамилия: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            TextField {
                id: lastNameField
                placeholderText: "Фамилия"
                text: userInfo.lastName
            }
            Item {
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: saveIcon2
                    source: "save.png"
                    width: 15
                    height: 15
                    MouseArea {
                        onClicked: saveChanges()
                    }
                }
            }

        }

        RowLayout {
            spacing: 10
            Label {
                text: "Отчество: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            TextField {
                id: middleNameField
                placeholderText: "Отчество"
                text: userInfo.middleName
            }
            Item {
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: saveIcon3
                    source: "save.png"
                    width: 15
                    height: 15
                    MouseArea {
                        onClicked: saveChanges()
                    }
                }
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Номер телефона: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            TextField {
                id: phoneField
                placeholderText: "Номер телефона"
                text: userInfo.phone
            }
            Item {
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: saveIcon4
                    source: "save.png"
                    width: 15
                    height: 15
                    MouseArea {
                        onClicked: saveChanges()
                    }
                }
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Электронная почта: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            TextField {
                id: emailField
                placeholderText: "Электронная почта"
                text: userInfo.email
            }
            Item {
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: saveIcon5
                    source: "save.png"
                    width: 15
                    height: 15
                    MouseArea {
                        onClicked: saveChanges()
                    }
                }
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Реферальный код: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            Text {
                text: userInfo.referralCode
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Номер бонусной карты: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            Text {
                text: userInfo.cardNumber
            }
        }

        RowLayout {
            spacing: 10
            Label {
                text: "Баланс бонусной карты: "
                Layout.alignment: Qt.AlignVCenter
                Layout.leftMargin: 5
            }
            Text {
                text: userInfo.cardBalance + " ₽"
            }
        }


        Button {
            text: "Сохранить изменения"
            onClicked: saveChanges()
        }
    }

    Button {
        //text: "Back"
        onClicked: stackView.pop()
        icon.source: "back.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    function saveChanges() {
        var firstName = firstNameField.text;
        var lastName = lastNameField.text;
        var middleName = middleNameField.text;
        var phone = phoneField.text;
        var email = emailField.text;

        databaseManager.updateUserInfo(userID, firstName, lastName, middleName, phone, email);

        userInfo.firstName = firstName;
        userInfo.lastName = lastName;
        userInfo.middleName = middleName;
        userInfo.phone = phone;
        userInfo.email = email;
    }
}
