#ifndef USERMODEL_H
#define USERMODEL_H

#include <QObject>
#include <QtQml/QQmlListProperty>
#include <QtQml/qqml.h>
#include <QAbstractListModel>

class UserData:public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name
               READ name WRITE setName
               NOTIFY dataChanged)
    Q_PROPERTY(int age
               READ age WRITE setAge
               NOTIFY dataChanged)

public:
    explicit UserData(QObject *parent = 0);
    UserData(const UserData &other);
    void operator =(const UserData &other);
    QString name() const;
    int age() const;

    void setName(const QString &value);
    void setAge(const int value);

signals:
    void dataChanged();

private:
    QString m_name;
    int m_age;
    QString m_city;
    QString m_occupation;
};
Q_DECLARE_METATYPE(UserData)

class UserListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum AnimalRoles {
        NameRole = Qt::UserRole + 1,
        AgeRole
    };

    UserListModel(QObject *parent = 0);

    //modify
    Q_INVOKABLE  void modifyUser(int row, UserData *user);
    //add
    Q_INVOKABLE  void addUser( UserData *user);
    //del
    Q_INVOKABLE   void removeUser(int row);

protected:
    //count
    int rowCount(const QModelIndex & parent = QModelIndex()) const override;
    //read
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;
    //role
    QHash<int, QByteArray> roleNames() const override;
private:
    QList<UserData> m_Users;
    //![2]
};

class UserModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool ready
               READ ready
               NOTIFY readyChanged)
    Q_PROPERTY(int count
               READ count
               NOTIFY countChanged)

    Q_PROPERTY(UserData *currentUser
               READ currentUser
               WRITE setCurrentUser
               NOTIFY currentUserChanged)
    Q_PROPERTY(QQmlListProperty<UserData> users
               READ users
               NOTIFY usersChanged)
    Q_PROPERTY(UserListModel* userListModel
               READ userListModel
               CONSTANT)
public:
    explicit UserModel(QObject *parent = 0);

    ~UserModel();

    bool ready() const;
    int count() const;

    //自定义类型属性
    UserData *currentUser() const;
    void setCurrentUser(UserData *) ;


    //自定义类型集合属性
public:
    QQmlListProperty<UserData> users();
    void appendUser(UserData *user);
    int userCount() const;
    UserData *userAt(int idx) const;
    void clearUsers();

    inline UserListModel* userListModel(){

        return m_UserListModel;
    }

public slots:
    Q_INVOKABLE  void modifyCurrentUser(UserData *) ;
    //        Q_INVOKABLE UserData* getUsersByIndex(int index);
    //        Q_INVOKABLE QList<UserData*>getUsersByName(QString name);
    Q_INVOKABLE void deleteUsersByName(QString name);
    Q_INVOKABLE void deleteUserByIndex(int index);
    Q_INVOKABLE void addUser(UserData* user);
    Q_INVOKABLE void modifyUserByIndex(int index,UserData* user);
signals:
    void  readyChanged();
    void  countChanged();
    void  currentUserChanged();
    void  usersChanged();
private:
    bool m_isReady;
    int m_count;
    UserData * m_currentUser;
    QList<UserData*> userSource;

    UserListModel* m_UserListModel;
};



#endif // USERMODEL_H
