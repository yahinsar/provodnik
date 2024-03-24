import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15

import "ui/BottomBar"
import "ui/MapRect"

Rectangle {
    width: parent.width
    height: parent.height
    property bool visibleMyCoordinates: false
    property var userCoordinate: QtPositioning.coordinate(51.523118, 46.019991)
    property int userID: 0
    //property alias routeQuery: routeQuery
    //property alias routeModel: routeModel

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    //MapView {}
    MapRect {
        id: map

        //MouseSettings {}

        StationMarker {
            coordinate: QtPositioning.coordinate(51.526777, 46.017251)
            stationID: 1
        }

        StationMarker {
            coordinate: QtPositioning.coordinate(51.522031, 46.019659)
            stationID: 2
        }

        StationMarker {
            coordinate: QtPositioning.coordinate(51.513254, 45.949231)
            stationID: 3
        }

        UserMarker {
            coordinate: userCoordinate
        }

        MapPolyline {
            id: routePolyline
            line.color: "green"
            line.width: 3
            visible: false
        }

        function calculateRoute(startCoordinate, endCoordinate) {
            routeQuery.clearWaypoints();
            routeQuery.addWaypoint(startCoordinate);
            routeQuery.addWaypoint(endCoordinate);
            routeQuery.travelModes = RouteQuery.CarTravel;
            routeQuery.routeOptimizations = RouteQuery.FastestRoute;
            routeModel.update();
        }

        RouteModel {
            id: routeModel
            plugin: mapPlugin
            query: RouteQuery {
                id: routeQuery
            }
            onStatusChanged: {
                if (status === RouteModel.Ready) {
                    switch (count) {
                        case 0:
                            // Технически это не ошибка
                            console.log("No route found");
                            break;
                        case 1:
                            console.log("Route found");
                            break;
                    }
                } else if (status === RouteModel.Error) {
                    console.log("Error finding route");
                }
            }
        }

        MapItemView {
            parent: map
            model: routeModel
            delegate: routeDelegate
            autoFitViewport: true
        }

    }
    BottomBar {
        BottomBarButtonsRow {

        }
    }
    //RouteCoordinateForm { }

    PositionSource {
        id: positionSource
        active: true

        onPositionChanged: {
            if (!valid) {
                console.log("Unable to determine current position");
            }
        }
    }

    function findClosestBlueMarker(userCoordinate) {
        var closestMarker = null;
        var closestDistance = Infinity;

        for (var i = 0; i < map.markers.length; i++) {
            var marker = map.markers[i];
            if (marker.sourceItem.source === "station_marker.png") {
                var distance = userCoordinate.distanceTo(marker.coordinate);
                if (distance < closestDistance) {
                    closestMarker = marker;
                    closestDistance = distance;
                }
            }
        }

        return closestMarker;
    }
}
