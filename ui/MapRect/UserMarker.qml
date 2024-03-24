import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

MapQuickItem {
            id: userLocationMarker
            visible: visibleMyCoordinates
            anchorPoint.x: marker.width / 2
            anchorPoint.y: marker.height * 2
            sourceItem: Image {
                id: marker
                source: "icons/user_marker.png"
                width: 36 * map.zoomLevel / 12
                height: 36 * map.zoomLevel / 12
            }
        }
