import QtQuick 2.15
import QtQuick.Controls 2.15
import QtPositioning 5.15
import "../../BottomBar"
import "../../MapRect"
Row {

    id: bottomBarButtonsRow
    spacing: 5
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalCenter
    property color pressedButtonColor: "#297F4B"
    property color hoveredButtonColor: "#35B166"
    property color mainButtonColor: "#6fda9c"
    property bool isVisibleRoute: false
    property var myCenter: map.center;
    property int myZoom: map.zoomLevel;
    BottomBarButton {
        text: "Исходный вид"
        icon.source: "icons/reset.png"
        onClicked: {
            map.center = QtPositioning.coordinate(51.52, 46.03);
            map.zoomLevel = 12;
        }
    }

    BottomBarButton {
        text: "Мое местоположение"
        icon.source: "icons/my-location.png"
        property bool isPressed: false
        onClicked: {
            visibleMyCoordinates = !visibleMyCoordinates;
            isPressed = !isPressed;
            userCoordinate = QtPositioning.coordinate(51.523118, 46.019991);
            if (isPressed)
            {
                background.color = pressedButtonColor;
                map.zoomLevel = 14;
                map.center = userCoordinate
            }
            else
                background.color = mainButtonColor;
        }
    }

    BottomBarButton {
        text: "Маршрут"
        icon.source: "icons/route.png"
        property bool isPressed: false
        onClicked: {
            myCenter = map.center;
            myZoom = map.zoomLevel;

            if (isPressed)
            {
                mapRectObject.clearMarkerRoute();
                isPressed = !isPressed;
                isVisibleRoute = false;
            }
            else
            {
                if (mapRectObject && visibleMyCoordinates)
                {
                    isPressed = !isPressed;
                    mapRectObject.calculateMarkerRoute();
                    isVisibleRoute = true;
                }
            }

            if (isPressed)
                background.color = pressedButtonColor;
            else
                background.color = mainButtonColor;
            map.center = userCoordinate;
            map.zoomLevel = myZoom;
        }
    }

    BottomBarButton {
        text: "Текущие зарядки"
        icon.source: "icons/electric.png"
        onClicked: {
            stackView.push("../currentRefillPage/currentRefillPage.qml", {userID: userID});
        }
    }

    BottomBarButton {
        text: "Профиль"
        icon.source: "icons/profile.png"
        onClicked: {
            stackView.push("../profilePage/profilePage.qml", {userID: userID});
        }
    }
}
