import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../mainButtons"

Rectangle {
    id: stationRect
    width: parent.width
    height: parent.height

    property int stationID: 0
    property var stationsInfo: []
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    color: mainBackgroundColor
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
                color: mainBackgroundColor
                radius: 10
                border.color: mainAppColor
                border.width: 1
                anchors.top: backButton.bottom
                Column {
                    spacing: 10
                    Text {
                        font.pointSize: 1
                        color: mainTextColor2
                        property string stationNumber: modelData.stationNumber
                        text: " "
                        leftPadding: 10
                        //visible: false
                    }

                    Text {
                        font.pointSize: 1
                        color: mainTextColor3
                        property string portsString: modelData.portsStrings
                        text: " "
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 10
                        //visible: false
                    }

                    Text {
                        anchors.centerIn: parent.Center
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 11
                        color: mainTextColor
                        property string stationID: modelData.stationID
                        text: "Зарядная станция №" + stationID
                        font.bold: true
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: 170
                    }


                    ListView {
                        id: lv
                        anchors.top: mainTextColor.bottom
                        property var ports: modelData.ports
                        width: parent.width
                        height: parent.height / 2
                        model: ports
                        interactive: false
                        spacing: 5
                        delegate: Component {
                            PortInfoRect {}

                        }
                    }
                }
            }
        }

        BackButton {

        }

    }




}
