import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15

import "../../../ui/BottomBar"
import "../../../ui/MapRect"

Rectangle {
    id: rootRect
    width: parent.width
    height: parent.height
    property color mainAppColor: "#6fda9c"
    property color mainTextColor: "white"
    property bool visibleMyCoordinates: false
    property var userCoordinate: QtPositioning.coordinate(51.523118, 46.019991)
    property int userID: 0
    property alias routeQuery: routeQuery
    property alias routeModel: routeModel
    property var stationCoordinates: []

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    MapRect {
        id: map

        MapItemView {
            parent: map
            model: routeModel
            delegate: routeDelegate
            autoFitViewport: true
        }

        StationMarker {
            coordinate: QtPositioning.coordinate(51.576628, 45.973733)
            stationID: 1
        }

        StationMarker {
            coordinate: QtPositioning.coordinate(51.510451, 45.977341)
            stationID: 2
        }

        StationMarker {
            coordinate: QtPositioning.coordinate(51.582209, 46.104929)
            stationID: 3
        }

        UserMarker {
            coordinate: userCoordinate
        }

        function calculateMarkerRoute()
        {
            routeQuery.clearWaypoints();
            routeQuery.addWaypoint(findClosestStation(userCoordinate));
            routeQuery.addWaypoint(userCoordinate);
            routeQuery.travelModes = RouteQuery.CarTravel
            routeQuery.routeOptimizations = RouteQuery.ShortestRoute

            routeModel.update();
        }

        function clearMarkerRoute()
        {
            routeQuery.clearWaypoints();
            routeModel.reset();
        }

        MapItemView {
            parent: map
            model: routeModel
            delegate: routeDelegate
            autoFitViewport: true
        }

        MapItemView {
            model: routeModel
            delegate: routeDelegate
        }

        RouteModel {
            id: routeModel
            plugin : map.plugin
            query:  RouteQuery {
                id: routeQuery
            }
            onStatusChanged: {
            }
        }

        Component {
            id: routeDelegate

            MapRoute {
                id: route
                route: routeData
                line.color: mainAppColor
                line.width: 5
                smooth: true
                opacity: 0.8
                TapHandler {
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                }
            }
        }

    }

    property var mapRectObject: map;

    BottomBar {
        MapBottomBarButtonsRow {

        }
    }

    PositionSource {
        id: positionSource
        active: true

        onPositionChanged: {
            if (!valid) {
                console.log("Unable to determine current position");
            }
        }
    }

    function findClosestStation(userCoordinate) {
        var closestStation = null;
        var closestDistance = Infinity;

        for (var i = 0; i < stationCoordinates.length; i++) {
            var stationCoord = stationCoordinates[i];
            var distance = userCoordinate.distanceTo(stationCoord);
            if (distance < closestDistance) {
                closestStation = stationCoord;
                closestDistance = distance;
            }
        }

        return closestStation;
    }

    Component.onCompleted: {
        stationCoordinates = databaseManager.getStationCoordinates();
        for (var i = 0; i < stationCoordinates.length; i++) {
            var coord = stationCoordinates[i];
            stationCoordinates[i] = QtPositioning.coordinate(coord.latitude, coord.longitude);
        }
    }
}
