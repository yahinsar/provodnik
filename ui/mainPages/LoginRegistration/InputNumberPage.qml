import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../mainButtons"

Rectangle {
    width: parent.width
    height: parent.height
    property int userID: 0
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    color: mainBackgroundColor

    CompanyLogo {}

    ColumnLayout {
        id: mainColumn
        anchors.centerIn: parent
        spacing: 10
        width: 300

        InputFieldWithIcon {
            id: phoneNumberInput
            iconName: "icons/phone.png"
            startText: "Введите номер телефона..."
        }

        InputButton {
            id: sendCodeButton
            height: 50
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            name: "Отправить код"
            onClicked: {
                stackView.push("InputCodePage.qml", {phoneNumber: phoneNumberInput.text});
            }
        }
    }
}
