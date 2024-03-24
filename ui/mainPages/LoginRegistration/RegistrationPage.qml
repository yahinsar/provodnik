import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../mainButtons"

Rectangle {
    width: parent.width
    height: parent.height
    //color: "lightgrey"
    property string phoneNumber: ""
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextCOlor: "white"
    color: mainBackgroundColor
    CompanyLogo {}

    ColumnLayout {
        id: mainColumn
        anchors.centerIn: parent
        spacing: 10
        width: 300


        // Поле для ввода фамилии
        InputField {
            id: lastNameInput
            startText: "Введите фамилию"
        }

        // Поле для ввода имени
        InputField {
            id: firstNameInput
            startText: "Введите имя"
        }

        // Поле для ввода отчества
        InputField {
            id: middleNameInput
            startText: "Введите отчество"
        }

        // Поле для ввода email
        InputField {
            id: emailInput
            startText: "Введите адрес эл. почты"
        }

        InputButton {
            id: sendCodeButton
            height: 50
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            name: "Завершить регистрацию"
            anchors.top: emailInput.bottom + 30
            onClicked: {
                databaseManager.saveUserInfo(firstNameInput.text, lastNameInput.text, middleNameInput.text, phoneNumber, emailInput.text);
                stackView.push("../../../mainMapPage.qml", {userID: databaseManager.getUserIDByPhoneNumber(phoneNumber)});
            }
        }

    }

    BackButton {
        twoPop: true
    }

}
