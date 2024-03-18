#ifndef MAPMANAGER_H
#define MAPMANAGER_H

#include <QObject>
#include <QGeoCoordinate>
#include <QQuickItem>

class MapManager : public QObject
{
    Q_OBJECT
public:
    explicit MapManager(QObject *parent = nullptr);

    Q_INVOKABLE void setMap(QQuickItem *mapItem);
    Q_INVOKABLE void addMarker(const QString &title, double latitude, double longitude);

private:
    QQuickItem *m_mapItem;
};

#endif // MAPMANAGER_H
