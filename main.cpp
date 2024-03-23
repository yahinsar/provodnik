#include <QCoreApplication>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "database_manager.h"
#include "map_manager.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    qmlRegisterType<MapManager>("MapManager", 1, 0, "MapManager");

    DatabaseManager databaseManager;

    qmlRegisterType<DatabaseManager>("MyApp", 1, 0, "DatabaseManager");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("databaseManager", &databaseManager);

    if (!databaseManager.openDatabase("E:/Qt_projects/provodnik/infoS.db")) {
        qDebug() << "Failed to open database.";
        return -1;
    }

    const QUrl url(QUrl::fromLocalFile("E:/Qt_projects/provodnik/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
