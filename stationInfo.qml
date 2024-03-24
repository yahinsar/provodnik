import QtQuick 2.15
import QtQuick.Controls 2.15
import "ui/mainButtons"

Rectangle {
    width: parent.width
    height: parent.height

    property int stationID: 0
    property var stationsInfo: []

    Component.onCompleted: {
        var stationsInfo = databaseManager.getChargingStationsInfo(stationID);
        listView.model = stationsInfo;
    }

    ListView {
        id: listView
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        model: stationsInfo

        delegate: Component {
            Rectangle {
                id: stationRect
                width: listView.width
                height: 200
                //color: index % 2 === 0 ? "lightgray" : "white"
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
                anchors.top: backButton.bottom
                Column {
                    spacing: 5


                    Text {
                        property string stationID: modelData.stationID
                        text: "Номер зарядной станции: " + stationID
                        font.bold: true
                        leftPadding: 10
                    }

                    Text {
                        property string stationNumber: modelData.stationNumber
                        text: "-"
                        leftPadding: 10
                    }

                    Text {
                        property string portsString: modelData.portsString
                        text: "-"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                    }

                    ListView {
                        property var ports: modelData.ports
                        width: parent.width
                        height: parent.height / 2
                        model: ports
                        interactive: false

                        delegate: Component {
                            Rectangle {
                                id: portRect
                                width: listView.width
                                height: 50
                                //color: index % 2 === 0 ? "lightblue" : "lightgreen"
                                color: "white"
                                border.color: "black"
                                border.width: 1

                                Image {
                                    id: connectorTypeImage
                                    property string connectorImage: modelData.connectorImage
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

                                property string lastChargeStart: modelData.lastChargeStart
                                property int elapsedTimeSeconds: 0
                                property int hours: 0
                                property int minutes: 0
                                property int seconds: 0

                                function updateElapsedTime() {
                                    var startDate = new Date(lastChargeStart.replace(/-/g, '/'));
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
                                    onTriggered: updateElapsedTime()
                                }

                                Text {
                                    property string portNumber: modelData.portNumber
                                    property string power: modelData.power
                                    property string status: modelData.status
                                    property string typeName: modelData.typeName



                                    text: status === "Свободно" ? typeName + " | " + power + " кВт | " + status :
                                                                  typeName + " | " + power + " кВт | " + status + " | С начала зарядки прошло: " + hours + " ч. " + minutes + " м. " + seconds + " с."

                                    color: status === "Свободно" ? "green" : "red"

                                    anchors {
                                        top: connectorTypeImage.top
                                        left: connectorTypeImage.right
                                        leftMargin: 5
                                        verticalCenter: parent.verticalCenter
                                    }
                                    horizontalAlignment: Text.AlignLeft
                                    verticalAlignment: Text.AlignVCenter
                                }

                            }
                        }
                    }
                }
            }
        }

        BackButton {

        }

    }




}
