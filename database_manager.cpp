#include "database_manager.h"
#include <QVector>

DatabaseManager::DatabaseManager(QObject *parent) : QObject(parent)
{
    m_database = QSqlDatabase::addDatabase("QSQLITE");
}

bool DatabaseManager::openDatabase(const QString &databaseName)
{
    m_database.setDatabaseName(databaseName);
    if (!m_database.open()) {
        qDebug() << "Error: Failed to open database:" << m_database.lastError().text();
        return false;
    }
    return true;
}

void DatabaseManager::closeDatabase()
{
    m_database.close();
}

bool DatabaseManager::createTables()
{
    QSqlQuery query;

    // Таблица Users
    if (!query.exec("CREATE TABLE IF NOT EXISTS Users ("
                    "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "FirstName TEXT,"
                    "LastName TEXT,"
                    "MiddleName TEXT,"
                    "Phone TEXT,"
                    "Email TEXT,"
                    "ReferralCode TEXT,"
                    "CardNumber TEXT,"
                    "CardBalance REAL)")) {
        qDebug() << "Error: Failed to create Users table:" << query.lastError().text();
        return false;
    }

    // Таблица Cars
    if (!query.exec("CREATE TABLE IF NOT EXISTS Cars ("
                    "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "UserID INTEGER,"
                    "Brand TEXT,"
                    "Model TEXT,"
                    "Year INTEGER,"
                    "LicensePlate TEXT,"
                    "FOREIGN KEY (UserID) REFERENCES Users(ID))")) {
        qDebug() << "Error: Failed to create Cars table:" << query.lastError().text();
        return false;
    }

    // Таблица Refills
    if (!query.exec("CREATE TABLE IF NOT EXISTS Refills ("
                    "ID INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "UserID INTEGER,"
                    "CarID INTEGER,"
                    "Date TEXT,"
                    "Amount REAL,"
                    "PortNumber INTEGER," // Добавляем новый столбец для номера порта
                    "FOREIGN KEY (UserID) REFERENCES Users(ID),"
                    "FOREIGN KEY (CarID) REFERENCES Cars(ID))")) {
        qDebug() << "Error: Failed to create Refills table:" << query.lastError().text();
        return false;
    }

    return true;
}

bool DatabaseManager::saveUserInfo(const QString &firstName, const QString &lastName,
                                 const QString &middleName, const QString &phone,
                                 const QString &email)
{

    QString referralCode;
    const QString possibleCharacters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for (int i = 0; i < 6; ++i) {
        const int index = QRandomGenerator::global()->bounded(possibleCharacters.length());
        referralCode += possibleCharacters.at(index);
    }

    QString cardNumber;
    for (int i = 0; i < 16; ++i) {
        const int digit = QRandomGenerator::global()->bounded(10);
        cardNumber += QString::number(digit);
    }

    bool userIsAdded = addNewUser(firstName, lastName, middleName, phone, email, referralCode, cardNumber, 0.0);
    return userIsAdded;
}

bool DatabaseManager::addNewUser(const QString &firstName, const QString &lastName,
                                 const QString &middleName, const QString &phone,
                                 const QString &email, const QString &referralCode,
                                 const QString &cardNumber, double cardBalance)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Users (FirstName, LastName, MiddleName, Phone, Email, ReferralCode, CardNumber, CardBalance)"
                  "VALUES (:firstName, :lastName, :middleName, :phone, :email, :referralCode, :cardNumber, :cardBalance)");
    query.bindValue(":firstName", firstName);
    query.bindValue(":lastName", lastName);
    query.bindValue(":middleName", middleName);
    query.bindValue(":phone", phone);
    query.bindValue(":email", email);
    query.bindValue(":referralCode", referralCode);
    query.bindValue(":cardNumber", cardNumber);
    query.bindValue(":cardBalance", cardBalance);

    if (!query.exec()) {
        qDebug() << "Error: Failed to add new user:" << query.lastError().text();
        return false;
    }
    return true;
}

bool DatabaseManager::checkUser(const QString& phoneNumber) {
    QSqlQuery checkQuery;
    checkQuery.prepare("SELECT COUNT(*) FROM Users WHERE Phone = :phone");
    checkQuery.bindValue(":phone", phoneNumber);
    if (checkQuery.exec() && checkQuery.next()) {
        int count = checkQuery.value(0).toInt();
        if (count > 0) {
            qDebug() << "User with phone number" << phoneNumber << "already exists!";
            return false;
        }
    } else {
        qDebug() << "Error checking for existing user:" << checkQuery.lastError().text();
        return false;
    }
}

QVariantList DatabaseManager::getChargingStationsInfo(int stationID) {
    QVariantList stationsInfo;

    QSqlQuery query;
    query.prepare("SELECT ChargingStations.ID, ChargingStations.StationNumber, "
                  "ChargingPorts.ID, PortTypes.TypeName, PortTypes.ConnectorImage, "
                  "ChargingPorts.Power, ChargingPorts.IsCharging, ChargingPorts.LastChargeStart "
                  "FROM ChargingStations "
                  "INNER JOIN ChargingPorts ON ChargingStations.ID = ChargingPorts.StationID "
                  "INNER JOIN PortTypes ON ChargingPorts.PortType = PortTypes.ID "
                  "WHERE ChargingStations.ElectricStationID = :stationID");
    query.bindValue(":stationID", stationID);
    if (query.exec()) {
        QMap<int, QVariantMap> stationsMap;

        while (query.next()) {
            int stationID = query.value(0).toInt();
            QString stationNumber = query.value(1).toString();

            if (!stationsMap.contains(stationID)) {
                QVariantMap stationMap;
                stationMap["stationID"] = stationID;
                stationMap["stationNumber"] = stationNumber;
                stationMap["ports"] = QVariantList();
                stationsMap.insert(stationID, stationMap);
            }

            QVariantMap portMap;
            portMap["portNumber"] = query.value(2).toInt();
            portMap["typeName"] = query.value(3).toString();
            portMap["connectorImage"] = query.value(4).toString();
            portMap["power"] = query.value(5).toInt();
            bool isCharging = query.value(6).toBool();
            if (isCharging) {
                portMap["status"] = "Зарядка";
                portMap["lastChargeStart"] = query.value(7).toString();
            } else {
                portMap["status"] = "Свободно";
                portMap["lastChargeStart"] = "";
            }

            QVariantList portsList = stationsMap.value(stationID)["ports"].toList();
            portsList.append(portMap);
            stationsMap[stationID]["ports"] = portsList;
        }

        for (const QVariantMap &stationMap : stationsMap) {
            stationsInfo.append(stationMap);
        }
    }

    return stationsInfo;
}
