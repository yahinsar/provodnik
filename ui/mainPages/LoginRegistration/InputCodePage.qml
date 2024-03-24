import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../mainButtons"
Rectangle {
    width: parent.width
    height: parent.height
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    property string phoneNumber: ""
    color: mainBackgroundColor

    CompanyLogo {}

    ColumnLayout {
        id: mainColumn
        anchors.centerIn: parent
        spacing: 10
        width: 300

        InputFieldWithIcon {
            id: codeInput
            iconName: "icons/message.png"
            startText: "Введите код..."
        }

        InputButton {
            id: loginButton
            height: 50
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            name: "Войти"
            onClicked: {
                if (databaseManager.checkUser(phoneNumber)) {
                    stackView.push("RegistrationPage.qml", {phoneNumber: phoneNumber});
                }
                else {
                    stackView.push("../mapPage/mainMapPage.qml", {userID: databaseManager.getUserIDByPhoneNumber(phoneNumber)});
                }
            }
        }
    }

    BackButton {
    }
}
