import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../../../ui/mainButtons"

Rectangle {
    id: mainRect
    width: parent.width
    height: parent.height

    property int userID: 0
    property var unpaidRefillsInfo: []
    property var carInfo: ({})
    property var portInfo: ({})

    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"

    color: mainBackgroundColor

    Component.onCompleted: {
        unpaidRefillsInfo = databaseManager.getUnpaidRefillsInfo(userID);
        listView.model = unpaidRefillsInfo;
    }

    Text {
        id: dopText
        text: "Список текущих зарядок"
        font.bold: true
        font.pointSize: 14
        color: mainTextColor
        anchors {
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
            leftMargin: 5
        }
    }

    ListView {
        id: listView
        anchors.top: dopText.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model: unpaidRefillsInfo
        delegate: Component {
            Rectangle {
                //anchors.topMargin: 20
                id: mRect
                width: listView.width
                height: 250
                color: mainBackgroundColor
                border.color: mainAppColor
                border.width: 1
                radius: 10
                anchors {
                    topMargin: 5
                    left: parent.left
                    right: parent.right
                }
                ColumnLayout {
                    spacing: 5
                    property var carInfo: ({})
                    Row {
                        id: addressRow
                        leftPadding: 5
                        ChargeIcon {
                            imagePath: "icons/address.png"
                        }

                        Text {
                            font.pointSize: 14
                            leftPadding: 10
                            text: modelData.address
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

                    Row {
                        leftPadding: 5
                        ChargeIcon {
                            imagePath: "icons/electric-car-green.png"
                        }

                        Text {
                            font.pointSize: 14
                            leftPadding: 10
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

                    Row {
                        leftPadding: 5
                        ChargeIcon {
                            imagePath: "icons/charging-station2.png"
                        }

                        Text {
                            font.pointSize: 14
                            leftPadding: 10
                            text: "Станция №" + modelData.stationID + "  |  Порт №" + modelData.portID
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
                    property var portInfo: ({})
                    PortInfoRect {}
                    onPortInfoChanged: {
                        updatePortInfo(modelData.portID);
                    }
                    onCarInfoChanged: {
                        updateCarInfo(modelData.carID);
                    }
                }
                InputButton {
                    id: loginButton
                    width: parent.width - 60
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                        leftMargin: 30
                        rightMargin: 30
                        bottomMargin: 10
                    }
                    height: 50
                    Layout.preferredWidth: parent.width
                    Layout.alignment: Qt.AlignHCenter
                    name: "Перейти на страницу оплаты"
                    onClicked: {
                    }
                }
            }

        }
    }

    BackButton {
    }

    function updateCarInfo(carID) {
        carInfo = databaseManager.getCarInfoByID(carID);
    }

    function updatePortInfo(portID) {
        portInfo = databaseManager.getPortTypeInfo(portID);
    }

}
