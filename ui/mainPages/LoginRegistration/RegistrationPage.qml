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
    property color mainTextColor: "white"
    color: mainBackgroundColor
    CompanyLogo {}

    ColumnLayout {
        id: mainColumn
        anchors.centerIn: parent
        spacing: 10
        width: parent.width * 0.6

        InputField {
            id: lastNameInput
            startText: "Введите фамилию"
        }

        InputField {
            id: firstNameInput
            startText: "Введите имя"
        }

        InputField {
            id: middleNameInput
            startText: "Введите отчество"
        }

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
            onClicked: {
                databaseManager.saveUserInfo(firstNameInput.text, lastNameInput.text, middleNameInput.text, phoneNumber, emailInput.text);
                stackView.push("../mapPage/mainMapPage.qml", {userID: databaseManager.getUserIDByPhoneNumber(phoneNumber)});
            }
        }

    }

    BackButton {
        twoPop: true
    }

}
