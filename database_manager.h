#ifndef DATABASE_MANAGER_H
#define DATABASE_MANAGER_H

#include <QObject>
#include <QtSql>
#include <QVector>

struct ChargingPortInfo {
    int portNumber;
    QString typeName;
    QString connectorImage;
    int power;
    QString status;
    QString lastChargeStart;
};

struct ChargingStationInfo {
    QString stationNumber;
    QVector<ChargingPortInfo> ports;
};

class DatabaseManager : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);

    bool openDatabase(const QString &databaseName);
    void closeDatabase();

    // Методы для работы с таблицами
    bool createTables();
    bool addNewUser(const QString &firstName, const QString &lastName, const QString &middleName,
                    const QString &phone, const QString &email, const QString &referralCode,
                    const QString &cardNumber, double cardBalance);

private:
    QSqlDatabase m_database;

public slots:
    bool checkUser(const QString& phoneNumber);
    bool saveUserInfo(const QString &firstName, const QString &lastName, const QString &middleName,
                      const QString &phone, const QString &email);
    QVariantList getChargingStationsInfo(int stationID);
    int getUserIDByPhoneNumber(const QString &phoneNumber);
    QVariantList getUnpaidRefillsInfo(int userID);
    QVariantMap getCarInfoByID(int carID);
    QVariantMap getPortTypeInfo(int portType);
    QVariantMap getUserInfoByID(int userID);
    QVariantMap getStationInfoByID(int stationID);
    bool updateUserInfo(int userID, const QString &firstName, const QString &lastName,
                                         const QString &middleName, const QString &phone,
                                         const QString &email);
};

#endif // DATABASE_MANAGER_H
