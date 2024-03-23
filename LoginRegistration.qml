import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Page {
    width: parent.width
    height: parent.height
    //color: "lightgrey"

    Image {
        source: "provodnikWithoutBackgroundColor.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 10
        width: 400
        height: 400
    }

    ColumnLayout {
        id: mainColumn
        anchors.centerIn: parent
        spacing: 10

        Label {
            id: infoLabel
            text: "Enter your phone number:"
            font.bold: true
        }

        TextField {
                    id: phoneNumberInput
                    width: parent.width
                    placeholderText: "Enter phone number here..."
                }

        Button {
            id: sendCodeButton
            text: "Send Code"
            onClicked: {
                // Скрыть информационные элементы
                infoLabel.visible = false
                phoneNumberInput.visible = false
                sendCodeButton.visible = false

                // Показать окно ввода кода и кнопку "Login"
                codeInput.visible = true
                loginButton.visible = true
            }
        }

        // Окно ввода кода
        TextField {
                    id: codeInput
                    width: parent.width
                    visible: false
                    placeholderText: "Enter code..."
                }



        // Кнопка "Login"
        Button {
                    id: loginButton
                    text: "Login"
                    visible: false
                    onClicked: {
                        if (databaseManager.checkUser(phoneNumberInput.text)) {
                            codeInput.visible = false;
                            loginButton.visible = false;
                            personalInfoForm.visible = true; // Показываем форму для заполнения личной информации
                        }
                        else {
                            stackView.push("mainMapPage.qml", {userID: databaseManager.getUserIDByPhoneNumber(phoneNumberInput.text)});
                            //stackView.pop(); // Убираем экран входа/регистрации из стека
                        }
                    }
                }

        // Форма для заполнения личной информации
        Rectangle {
            id: personalInfoForm
            visible: false // Изначально скрыта
            width: 300
            height: 200
            color: "lightgrey"

            // Поле для ввода имени
            TextField {
                id: firstNameInput
                placeholderText: "Enter your first name"
                width: parent.width
                height: 30
            }

            // Поле для ввода фамилии
            TextField {
                id: lastNameInput
                placeholderText: "Enter your last name"
                width: parent.width
                height: 30
                anchors.top: firstNameInput.bottom
            }

            // Поле для ввода отчества
            TextField {
                id: middleNameInput
                placeholderText: "Enter your middle name"
                width: parent.width
                height: 30
                anchors.top: lastNameInput.bottom
            }

            // Поле для ввода email
            TextField {
                id: emailInput
                placeholderText: "Enter your email"
                width: parent.width
                height: 30
                anchors.top: middleNameInput.bottom
            }

            // Кнопка "Save"
            Button {
                text: "Save"
                width: 100
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: emailInput.bottom
                onClicked: {
                    databaseManager.saveUserInfo(firstNameInput.text, lastNameInput.text, middleNameInput.text, phoneNumberInput.text, emailInput.text);
                    // Переключаемся на страницу с картой
                    stackView.push("mainMapPage.qml");
                    //stackView.pop(); // Убираем экран входа/регистрации из стека
                }
            }
        }
    }
}
