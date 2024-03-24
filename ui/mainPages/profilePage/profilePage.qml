import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../../ui/mainButtons"
import "../../../ui/BottomBar"

Rectangle {
    id: profileRect
    width: parent.width
    height: parent.height

    property int userID: 0
    property var userInfo: ({})
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    color: mainBackgroundColor

    Component.onCompleted: {
        userInfo = databaseManager.getUserInfoByID(userID);
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

        Text {
            text: "Информация о пользователе"
            color: mainTextColor
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            Layout.leftMargin: 5
        }

        Row {
            Layout.topMargin: 15
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Имя"
            }
            ProfileInfoField {
                id: firstName
                startText: "Введите имя..."
                text: userInfo.firstName
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Фамилия"
            }
            ProfileInfoField {
                id: lastNameField
                startText: "Введите фамилию..."
                text: userInfo.lastName
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Отчество"
            }
            ProfileInfoField {
                id: middleNameField
                startText: "Введите отчество..."
                text: userInfo.middleName
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Номер телефона"
            }
            ProfileInfoField {
                id: phoneField
                startText: "Введите номер телефона..."
                text: userInfo.phone
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Электронная почта"
            }
            ProfileInfoField {
                id: emailField
                startText: "Введите эл. почту..."
                text: userInfo.email
            }
        }

        InputButton {
            id: sendCodeButton
            height: 50
            baseColor: mainAppColor
            Layout.preferredWidth: parent.width - 5
            Layout.alignment: Qt.AlignHCenter
            anchors.bottom: profileRect.bottom
            name: "Сохранить изменения"
            onClicked: {
               saveChanges()
            }
        }

        Text {
            text: "Дополнительная информация"
            color: mainTextColor
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            Layout.leftMargin: 5
        }

        Row {
            Layout.topMargin: 15
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Реферальный код"
            }
            ProfileInfoField {
                id: refCodeField
                text: userInfo.referralCode
                readOnly: true
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Номер бонусной карты"
            }
            ProfileInfoField {
                id: cardNumberField
                text: userInfo.cardNumber
                readOnly: true
            }
        }

        Row {
            leftPadding: 5
            spacing: 10
            ProfileInfoLabel {
                labelText: "Баланс бонусной карты"
            }
            ProfileInfoField {
                id: cardBalanceField
                text: userInfo.cardBalance + " ₽"
                readOnly: true
            }
        }

//        Text {
//            id: listText
//            text: "Список машин:"
//            color: mainTextColor
//            Layout.alignment: Qt.AlignLeft
//            Layout.fillWidth: true
//        }

        Text {
            id: carListLabel
            text: "Список машин"
            color: mainTextColor
            font.bold: true
            font.pointSize: 14
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 10
            Layout.leftMargin: 5
        }

        ListView {
            id: carList
            width: 300
            height: 100
            model: userInfo.carIDs
            //anchors.top: listText.bottom
            //interactive: false
            delegate: Item {
                width: parent.width
                height: 45
                Row {
                    leftPadding: 5
                    CarIcon {}

                    Text {
                        font.pointSize: 14
                        leftPadding: 5
                        text: carInfo.brand + " " + carInfo.model + " (" + carInfo.licensePlate + ")"
                        color: mainTextColor

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

        //SaveButton {}
    }

    BottomBar {
        ProfileBottomBarButtonsRow {

        }
    }

    BackButton {
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
