import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15

MouseArea {
    id: mouseSettings
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
