import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

MapQuickItem {
    id: markerItem
    anchorPoint.x: marker.width / 2
    anchorPoint.y: marker.height * 2
    property int stationID: 0
    sourceItem: Image {
        id: marker
        source: "icons/station_marker.png"
        width: 36 * map.zoomLevel / 12
        height: 36 * map.zoomLevel / 12
    }
    MouseArea {
            anchors.fill: parent
            onClicked: {
                    stackView.push("../../stationInfo.qml", { stationID: markerItem.stationID });
                }
        }
}
