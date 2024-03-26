import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../mainButtons"

Rectangle {
    id: stationRect
    width: parent.width
    height: parent.height

    property int stationID: 0
    property var stationsInfo: []
    property var stationInfo: ({})
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    color: mainBackgroundColor
    Component.onCompleted: {
        var stationsInfo = databaseManager.getChargingStationsInfo(stationID);
        stationInfo = databaseManager.getStationInfoByID(stationID);
        listView.model = stationsInfo;
    }

    Text {
        id: stationNameLabel
        text: "Станция зарядки электромобилей №" + stationID
        font.bold: true
        font.pointSize: 14
        color: mainTextColor
        topPadding: 10
        anchors {
            horizontalCenter: parent.horizontalCenter
            leftMargin: 5
        }
    }

    Row {
        id: addressRow
        leftPadding: 5
        topPadding: 5
        bottomPadding: 5
        anchors.top: stationNameLabel.bottom
        SomeIcon {
            imagePath: "icons/address.png"
        }

        Text {
            font.pointSize: 14
            leftPadding: 10
            text: stationInfo.address + " | " + stationInfo.chargingPortsCount + " зарядных станции"
            color: mainTextColor
            anchors {
                top: SomeIcon.top
                left: SomeIcon.right
                leftMargin: 5
                verticalCenter: parent.verticalCenter
            }
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
        }
    }

    ListView {
        id: listView
        anchors.top: addressRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        model: stationsInfo

        delegate: Component {
            Rectangle {
                id: stationRect
                width: listView.width
                height: 170
                color: mainBackgroundColor
                radius: 10
                border.color: mainAppColor
                border.width: 1
                anchors.top: backButton.bottom

                Text {
                    id: stationNumberText
                    anchors.horizontalCenter: stationRect.horizontalCenter
                    anchors.top: stationRect.top
                    font.pointSize: 11
                    color: mainTextColor
                    property string stationID: modelData.stationID
                    text: "Зарядная станция №" + stationID
                    font.bold: true
                    anchors.topMargin: 10
                }

                ListView {
                    id: lv
                    property var ports: modelData.ports
                    width: parent.width
                    height: parent.height / 2
                    anchors.top: stationNumberText.bottom
                    anchors.topMargin: 10
                    model: ports
                    interactive: false
                    spacing: 5
                    delegate: Component {
                        PortInfoRect {}

                    }
                }
            }
        }

        BackButton {

        }

    }




}
