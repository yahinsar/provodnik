import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15


Rectangle {
    width: parent.width
    height: parent.height
    property bool visibleMyCoordinates: false
    property var userCoordinate: QtPositioning.coordinate(51.523118, 46.019991)
    //property alias routeQuery: routeQuery
    //property alias routeModel: routeModel

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(51.52, 46.03)
        zoomLevel: 12

        MouseArea {
            anchors.fill: parent
            drag.target: map
            onClicked: {
                // Prevent clicks from being triggered during drag
                if (!dragActive) {
                    console.log("Map clicked")
                }
            }

            property bool dragActive: false
            property real dragStartX: 0
            property real dragStartY: 0
            property var dragStartCenter

            function handleMapPressed(event) {
                //console.log("handleMapPressed")
                dragActive = true;
                dragStartX = event.x;
                dragStartY = event.y;
                dragStartCenter = map.center;
            }

            function handleMapReleased() {
                //console.log("handleMapReleased")
                dragActive = false;
            }

            function handleMapPositionChanged(event) {
                if (dragActive) {
                    // Проверяем, находится ли курсор мыши в пределах приложения
                    if (event.x >= 0 && event.x <= map.width &&
                        event.y >= 0 && event.y <= map.height) {
                        var deltaX = event.x - dragStartX;
                        var deltaY = event.y - dragStartY;

                        // Расчет нового центра карты с учетом уровня масштабирования
                        var distanceFromCenter = Math.sqrt((event.x - map.width / 2) * (event.x - map.width / 2) + (event.y - map.height / 2) * (event.y - map.height / 2));
                        var scaleFactor = 0.1 / distanceFromCenter * (1 / map.zoomLevel);
                        var newCenter = QtPositioning.coordinate(
                            dragStartCenter.latitude + deltaY * scaleFactor / (map.height),
                            dragStartCenter.longitude - deltaX * scaleFactor / (map.width)
                        );

                        map.center = newCenter;
                    }
                }
            }

            onPressed: handleMapPressed(mouse)
            onReleased: handleMapReleased()
            onPositionChanged: handleMapPositionChanged(mouse)
            onWheel: {
                if (wheel.angleDelta.y > 0) {
                    map.zoomLevel += 1; // Увеличение масштаба при прокрутке вверх
                } else {
                    map.zoomLevel -= 1; // Уменьшение масштаба при прокрутке вниз
                }
            }
        }

        //! [marker]
        MapQuickItem {
            id: marker1Item
            coordinate: QtPositioning.coordinate(51.526777, 46.017251)
            anchorPoint.x: marker.width / 2
            anchorPoint.y: marker.height * 2
            sourceItem: Image {
                id: marker1
                source: "marker_blue.png" // Путь к изображению метки
                width: 24
                height: 24
            }
            MouseArea {
                    anchors.fill: parent
                    onClicked: {
                            stackView.push("stationInfo.qml", { markerType: "marker1Item", stationID: 1 });
                        }
                }
        }

        MapQuickItem {
            id: marker2Item
            coordinate: QtPositioning.coordinate(51.522031, 46.019659)
            anchorPoint.x: marker.width / 2
            anchorPoint.y: marker.height * 2
            sourceItem: Image {
                id: marker2
                source: "marker_blue.png" // Путь к изображению метки
                width: 24 * map.zoomLevel / 12
                height: 24 * map.zoomLevel / 12
            }
            MouseArea {
                    anchors.fill: parent
                    onClicked: {
                            stackView.push("stationInfo.qml", { markerType: "marker2Item", stationID: 2  });
                        }
                }
        }

        MapQuickItem {
            id: marker3Item
            coordinate: QtPositioning.coordinate(51.513254, 45.949231)
            anchorPoint.x: marker.width / 2
            anchorPoint.y: marker.height * 2
            sourceItem: Image {
                id: marker3
                source: "marker_blue.png" // Путь к изображению метки
                width: 24
                height: 24
            }
            MouseArea {
                    anchors.fill: parent
                    onClicked: {
                            stackView.push("stationInfo.qml", { markerType: "marker3Item", stationID: 3 });
                        }
                }
        }

        MapQuickItem {
                    id: userLocationMarker
                    visible: visibleMyCoordinates
                    coordinate: userCoordinate
                    anchorPoint.x: marker.width / 2
                    anchorPoint.y: marker.height * 2
                    sourceItem: Image {
                        id: marker
                        source: "marker_red.png" // Путь к изображению метки
                        width: 24
                        height: 24
                    }
                }
        //! [marker]

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

    Row {
        anchors.bottom: parent.bottom
        Button {
            text: "Reset View"
            onClicked: {
                map.center = QtPositioning.coordinate(51.52, 46.03);
                map.zoomLevel = 12;
            }
        }

        Button {
            text: "Мое местоположение"
            onClicked: {
                visibleMyCoordinates = !visibleMyCoordinates;
                if (positionSource.valid) {
                    userCoordinate = positionSource.position.coordinate;
                } else {
                    userCoordinate = QtPositioning.coordinate(51.523118, 46.019991);
                }
                map.center = userCoordinate
                map.zoomLevel = 14;
            }
        }

        Button {
            text: "Построить путь"
            onClicked: {
                // Находим ближайшую синюю метку
                var nearestMarker = marker1;
                var minDistance = Math.sqrt(Math.pow(marker1Item.coordinate.latitude - userLocationMarker.latitude, 2) +
                                            Math.pow(marker1Item.coordinate.longitude - userLocationMarker.longitude, 2));
                var markers = [marker2Item, marker3Item]; // Массив всех синих меток

                for (var i = 0; i < markers.length; ++i) {
                    var distance = Math.sqrt(Math.pow(markers[i].coordinate.latitude - userLocationMarker.latitude, 2) +
                                             Math.pow(markers[i].coordinate.longitude - userLocationMarker.longitude, 2));
                    if (distance < minDistance) {
                        minDistance = distance;
                        nearestMarker = markers[i];
                    }
                }


                // Строим маршрут от текущего местоположения до ближайшей метки
                routeQuery.clearWaypoints();
                routeQuery.addWaypoint(userCoordinate);
                routeQuery.addWaypoint(nearestMarker.coordinate);
                routeQuery.travelModes = RouteQuery.CarTravel;
                routeQuery.routeOptimizations = RouteQuery.FastestRoute;
                routeModel.update();
            }
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
            if (marker.sourceItem.source === "marker_blue.png") {
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
