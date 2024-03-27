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

int DatabaseManager::getUserIDByPhoneNumber(const QString &phoneNumber)
{
    QSqlQuery query;
    query.prepare("SELECT ID FROM Users WHERE Phone = :phone");
    query.bindValue(":phone", phoneNumber);
    if (query.exec() && query.next()) {
        return query.value(0).toInt();
    } else {
        qDebug() << "Error getting user ID by phone number:" << query.lastError().text();
        return -1;
    }
}

QVariantList DatabaseManager::getUnpaidRefillsInfo(int userID)
{
    QVariantList unpaidRefillsInfo;

    QSqlQuery query;
    query.prepare("SELECT UserID, CarID, PortID, StationID, LastChargeStart, Address, PortType, Power "
                  "FROM UnpaidRefills "
                  "WHERE UserID = :userID");
    query.bindValue(":userID", userID);
    if (query.exec()) {
        while (query.next()) {
            QVariantMap refillMap;
            refillMap["userID"] = query.value(0).toInt();
            refillMap["carID"] = query.value(1).toInt();
            refillMap["portID"] = query.value(2).toInt();
            refillMap["stationID"] = query.value(3).toInt();
            refillMap["lastChargeStart"] = query.value(4).toString();
            refillMap["address"] = query.value(5).toString();
            refillMap["portType"] = query.value(6).toInt();
            refillMap["power"] = query.value(7).toInt();
            unpaidRefillsInfo.append(refillMap);
        }
    } else {
        qDebug() << "Error getting unpaid refills info:" << query.lastError().text();
    }

    return unpaidRefillsInfo;
}

QVariantMap DatabaseManager::getCarInfoByID(int carID)
{
    QVariantMap carInfo;

    QSqlQuery query;
    query.prepare("SELECT Brand, Model, LicensePlate "
                  "FROM Cars "
                  "WHERE ID = :carID");
    query.bindValue(":carID", carID);
    if (query.exec() && query.next()) {
        carInfo["brand"] = query.value(0).toString();
        carInfo["model"] = query.value(1).toString();
        carInfo["licensePlate"] = query.value(2).toString();
    } else {
        qDebug() << "Error getting car info by ID:" << query.lastError().text();
    }

    return carInfo;
}

QVariantMap DatabaseManager::getPortTypeInfo(int portType) {
    QVariantMap portTypeInfo;

    QSqlQuery query;
    query.prepare("SELECT TypeName, ConnectorImage FROM PortTypes WHERE ID = :portType");
    query.bindValue(":portType", portType);
    if (query.exec() && query.next()) {
        portTypeInfo["typeName"] = query.value(0).toString();
        portTypeInfo["connectorImage"] = query.value(1).toString();
    } else {
        qDebug() << "Error: Failed to fetch Port Type info:" << query.lastError().text();
    }

    return portTypeInfo;
}

QVariantMap DatabaseManager::getUserInfoByID(int userID) {
    QVariantMap userInfo;

    QSqlQuery query;
    query.prepare("SELECT FirstName, LastName, MiddleName, ReferralCode, CardNumber, "
                  "CardBalance, Phone, Email FROM Users WHERE ID = :userID");
    query.bindValue(":userID", userID);
    if (query.exec() && query.next()) {
        userInfo["firstName"] = query.value(0).toString();
        userInfo["lastName"] = query.value(1).toString();
        userInfo["middleName"] = query.value(2).toString();
        userInfo["referralCode"] = query.value(3).toString();
        userInfo["cardNumber"] = query.value(4).toString();
        userInfo["cardBalance"] = query.value(5).toDouble();
        userInfo["phone"] = query.value(6).toString();
        userInfo["email"] = query.value(7).toString();

        QSqlQuery carQuery;
        carQuery.prepare("SELECT ID FROM Cars WHERE UserID = :userID");
        carQuery.bindValue(":userID", userID);
        if (carQuery.exec()) {
            QVariantList carIDs;
            while (carQuery.next()) {
                carIDs.append(carQuery.value(0).toInt());
            }
            userInfo["carIDs"] = carIDs;
        } else {
            qDebug() << "Error: Failed to fetch Car IDs for user:" << carQuery.lastError().text();
        }
    } else {
        qDebug() << "Error: Failed to fetch user info:" << query.lastError().text();
    }

    return userInfo;
}

bool DatabaseManager::updateUserInfo(int userID, const QString &firstName, const QString &lastName,
                                     const QString &middleName, const QString &phone,
                                     const QString &email) {
    QSqlQuery query;
    query.prepare("UPDATE Users SET FirstName = :firstName, LastName = :lastName, "
                  "MiddleName = :middleName, Phone = :phone, Email = :email WHERE ID = :userID");
    query.bindValue(":firstName", firstName);
    query.bindValue(":lastName", lastName);
    query.bindValue(":middleName", middleName);
    query.bindValue(":phone", phone);
    query.bindValue(":email", email);
    query.bindValue(":userID", userID);

    if (!query.exec()) {
        qDebug() << "Error: Failed to update user info:" << query.lastError().text();
        return false;
    }
    return true;
}

QVariantMap DatabaseManager::getStationInfoByID(int stationID)
{
    QVariantMap stationInfo;

    QSqlQuery query;
    query.prepare("SELECT Address, ChargingPortsCount "
                  "FROM ElectricStations "
                  "WHERE ID = :stationID");
    query.bindValue(":stationID", stationID);
    if (query.exec() && query.next()) {
        stationInfo["address"] = query.value(0).toString();
        stationInfo["chargingPortsCount"] = query.value(1).toString();
    } else {
        qDebug() << "Error getting station info by ID:" << query.lastError().text();
    }

    return stationInfo;
}

QVariantList DatabaseManager::getStationCoordinates()
{
    QVariantList coordinatesList;

    QSqlQuery query("SELECT Latitude, Longitude FROM ElectricStations");
    while (query.next()) {
        double latitude = query.value(0).toDouble();
        double longitude = query.value(1).toDouble();
        QVariantMap coordMap;
        coordMap["latitude"] = latitude;
        coordMap["longitude"] = longitude;
        coordinatesList.append(coordMap);
    }

    return coordinatesList;
}
