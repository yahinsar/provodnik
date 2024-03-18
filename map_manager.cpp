#include "map_manager.h"
#include <QtLocation>

MapManager::MapManager(QObject *parent) : QObject(parent), m_mapItem(nullptr)
{
}

void MapManager::setMap(QQuickItem *mapItem)
{
    m_mapItem = mapItem;
}

void MapManager::addMarker(const QString &title, double latitude, double longitude)
{
    if (!m_mapItem) {
        qWarning() << "Map item is not set. Call setMap() before adding markers.";
        return;
    }

    QGeoCoordinate coordinate(latitude, longitude);
    if (!coordinate.isValid()) {
        qWarning() << "Invalid coordinates.";
        return;
    }

    // Create map marker
    QVariantMap markerParams;
    markerParams["coordinate"] = QVariant::fromValue(coordinate);
    markerParams["title"] = title;

    QMetaObject::invokeMethod(m_mapItem, "addMarker", Q_ARG(QVariant, QVariant::fromValue(markerParams)));
}
