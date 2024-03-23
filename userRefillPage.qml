import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: mainRect
    width: parent.width
    height: parent.height

    property int userID: 0
    property var unpaidRefillsInfo: []
    property var carInfo: ({})
    property var portInfo: ({})

    Component.onCompleted: {
        unpaidRefillsInfo = databaseManager.getUnpaidRefillsInfo(userID);
        listView.model = unpaidRefillsInfo;
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model: unpaidRefillsInfo

        delegate: Component {
            Rectangle {
                //anchors.topMargin: 20
                id: mRect
                width: listView.width
                height: mainRect.height
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
                border.color: "black"
                border.width: 1

                Column {
                    spacing: 5
                    property var carInfo: ({})
                    //anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    Text {
                        text: "Информация о текущей зарядке"
                        font.bold: true
                        font.pointSize: 14
                        anchors {
                            topMargin: 10
                            horizontalCenter: parent.horizontalCenter
                            leftMargin: 5
                        }
                    }
                    Text {
                        text: "Автомобиль: " + carInfo.brand + " " + carInfo.model
                        anchors {
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                    }
                    Text {
                        text: "Регистрационный номер: " + carInfo.licensePlate
                        anchors {
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                    }
                    Text {
                        text: "Номер станции: " + modelData.stationID
                        anchors {
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                    }
                    Text {
                        text: "Номер порта: " + modelData.portID
                        anchors {
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                    }
                    Text {
                        text: "Зарядка осуществляется по адресу: " + modelData.address
                        anchors {
                            topMargin: 10
                            left: parent.left
                            leftMargin: 5
                        }
                    }

                    Rectangle {
                                            property var portInfo: ({})
                                            id: portRect
                                            width: listView.width
                                            height: 50
                                            color: "white"
                                            border.color: "black"
                                            border.width: 1

                                            Image {
                                                id: connectorTypeImage
                                                property string connectorImage: portInfo.connectorImage
                                                source: connectorImage
                                                anchors {
                                                    top: parent.top
                                                    topMargin: 10
                                                    left: parent.left
                                                    leftMargin: 5
                                                }
                                                width: 45
                                                height: 35
                                            }
                                            property int elapsedTimeSeconds: 0
                                            property int hours: 0
                                            property int minutes: 0
                                            property int seconds: 0

                                            function updateElapsedTime() {
                                                var startDate = new Date(modelData.lastChargeStart.replace(/-/g, '/'));
                                                var now = new Date();
                                                var difference = Math.floor((now - startDate) / 1000);
                                                elapsedTimeSeconds = difference;
                                                hours = Math.floor(difference / 3600);
                                                difference = difference % 3600;
                                                minutes = Math.floor(difference / 60);
                                                seconds = difference % 60;
                                            }

                                            Timer {
                                                interval: 1000
                                                running: true
                                                repeat: true
                                                onTriggered: parent.updateElapsedTime()
                                            }

                                            Text {
                                                text: portInfo.typeName + " | " + modelData.power + " кВт | Зарядка | С начала зарядки прошло: " + parent.hours + " ч. " + parent.minutes + " м. " + parent.seconds + " с."

                                                color: "green"

                                                anchors {
                                                    top: connectorTypeImage.top
                                                    left: connectorTypeImage.right
                                                    leftMargin: 5
                                                    verticalCenter: parent.verticalCenter
                                                }
                                                horizontalAlignment: Text.AlignLeft
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            onPortInfoChanged: {
                                                updatePortInfo(modelData.portID);
                                            }
                                        }
                                        onCarInfoChanged: {
                                            updateCarInfo(modelData.carID);
                                        }
                                    }
                                }
                            }
                        }


    Row {
        id: buttonRow
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Button {
            id: customButton
            contentItem: Text {
                id: buttonText
                color: "#000000"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                text: "Перейти на страницу оплаты"
            }

            background: Rectangle {
                Gradient {
                    id: normalGradient
                    GradientStop { position: 0.0; color: "#FFFFFF" }
                    GradientStop { position: 0.5; color: "#a1f570" }
                    GradientStop { position: 1.0; color: "#FFFFFF" }
                }
                Gradient {
                    id: hoveredGradient
                    GradientStop { position: 0.0; color: "#FFFFFF" }
                    GradientStop { position: 0.5; color: "#a1f570" }
                    GradientStop { position: 1.0; color: "#FFFFFF" }
                }
                Gradient {
                    id: pressedGradient
                    GradientStop { position: 0.0; color: "#FFFFFF" }
                    GradientStop { position: 0.5; color: "#a1f570" }
                    GradientStop { position: 1.0; color: "#FFFFFF" }
                }
                implicitWidth: 100
                implicitHeight: 50
                gradient: testButton.pressed ? pressedGradient :
                          testButton.hovered ? hoveredGradient :
                                               normalGradient
                radius: 5
                border.width: 1.0
                border.color: "#9C9C9C"
            }
        }


        anchors.bottomMargin: 40 // Отступ внизу кнопки
    }


    Button {
        //text: "Back"
        onClicked: stackView.pop()
        icon.source: "back.png"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
    }

    function updateCarInfo(carID) {
        carInfo = databaseManager.getCarInfoByID(carID);
    }

    function updatePortInfo(portID) {
        portInfo = databaseManager.getPortTypeInfo(portID);
    }

}
