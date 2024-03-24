import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.15

Row {
    id: bottomBarButtonsRow
    //anchors.bottom: parent.bottom
    anchors.bottomMargin: 10
    spacing: 5
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    BottomBarButton {
        text: "Reset View"
        icon.source: "icons/reset.png"
        onClicked: {
            map.center = QtPositioning.coordinate(51.52, 46.03);
            map.zoomLevel = 12;
        }
    }

    BottomBarButton {
        text: "Мое местоположение"
        icon.source: "icons/my-location.png"
        backgroundColor: control.pressed ? "#CCCCCC" : control.hovered ? "#EFEFEF" : "#FFFFFF"

        property bool isPressed: false
        onClicked: {
            visibleMyCoordinates = !visibleMyCoordinates;

            if (positionSource.valid)
                userCoordinate = positionSource.position.coordinate;
            else
                userCoordinate = QtPositioning.coordinate(51.523118, 46.019991);

            if (isPressed)
                background.color = "#FFFFFF";
            else
            {
                background.color = "#CCCCCC";
                map.zoomLevel = 14;
                map.center = userCoordinate
            }

            isPressed = !isPressed;
        }
    }

    BottomBarButton {
        text: "Маршрут"
        icon.source: "icons/route.png"
        backgroundColor: control.pressed ? "#CCCCCC" : control.hovered ? "#EFEFEF" : "#FFFFFF"
        property bool isPressed: false
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
            if (isPressed) {
                        background.color = "#FFFFFF";
                    } else {
                        background.color = "#CCCCCC";
                    }
                    isPressed = !isPressed;
        }
    }

    BottomBarButton {
        text: "Текущая зарядка"
        icon.source: "icons/electric.png"
        onClicked: {
            stackView.push("../../userRefillPage.qml", {userID: userID});
        }
    }

    BottomBarButton {
        text: "Профиль"
        icon.source: "icons/profile.png"
        onClicked: {
            stackView.push("../../profilePage.qml", {userID: userID});
        }
    }
}
