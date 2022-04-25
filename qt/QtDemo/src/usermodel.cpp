#include "usermodel.h"


UserData::UserData(QObject*parent):QObject(parent)
{

}

UserData::UserData(const UserData &other):QObject(nullptr)
{
    m_name = other.m_name;
    m_age = other.m_age;
}
void UserData::operator=(const UserData &other)
{
    m_name = other.m_name;
    m_age = other.m_age;
}
//data
QString UserData::name() const
{
    return m_name;
}
void UserData::setName(const QString &value)
{
    m_name = value;
    emit dataChanged();
}
int UserData::age() const
{
    return m_age;
}
void UserData::setAge(const int value)
{
    m_age = value;
    emit dataChanged();
}

//model
UserModel::UserModel(QObject *parent)
    : QObject(parent)
{
    UserData* user =new UserData() ;
    user->setAge(12);
    user->setName("wxp");
    userSource.append(user);
    m_currentUser =userSource[0];
    m_count = userSource.count();

    m_UserListModel = new UserListModel();
}

UserModel::~UserModel()
{
    foreach (UserData *user, userSource)
        delete user;
}

bool UserModel::ready()const
{

    return m_isReady;
}
int UserModel::count()const
{

    return m_count;
}

UserData* UserModel::currentUser()const
{

    return m_currentUser;
}
void UserModel::setCurrentUser(UserData* user)
{

    m_currentUser = user;
    emit currentUserChanged();
}
void UserModel::modifyCurrentUser(UserData * user)
{

    m_currentUser->setAge( user->age());
    m_currentUser->setName( user->name());
}

void UserModel::appendUser(UserData *user)
{
    userSource.append(user);
}
int UserModel::userCount() const
{
    return userSource.count();
}
UserData* UserModel::userAt(int index) const
{
    return  userSource[index] ;
}
void UserModel::clearUsers()
{
    userSource.clear();
}

static void appendUserForQml(QQmlListProperty<UserData>*list,UserData *user)
{
    reinterpret_cast<UserModel *>(list->data)->appendUser(user);
}
static qsizetype userCountForQml(QQmlListProperty<UserData>*list)
{
    return reinterpret_cast<UserModel *>(list->data)->userCount();
}
static UserData* userAtForQml(QQmlListProperty<UserData>*list,qsizetype index)
{
    return reinterpret_cast<UserModel *>(list->data)->userAt(index);
}
static void clearUsersForQml(QQmlListProperty<UserData>*list)
{
    reinterpret_cast<UserModel *>(list->data)->clearUsers();
}


QQmlListProperty<UserData> UserModel::users()
{
    return QQmlListProperty<UserData>(this,this,
                                      appendUserForQml,
                                      userCountForQml,
                                      userAtForQml,
                                      clearUsersForQml);
}

void UserModel::addUser(UserData *user)
{
    UserData* temp = new UserData(*user);
    userSource.append(temp);
    m_count = userSource.count();
    emit  usersChanged();
    emit countChanged();
}

void UserModel::deleteUsersByName(QString name)
{
    for(int i =0;i<userSource.size();i++)
    {
        if(userSource[i]->name()==name)
        {
            userSource.removeAt(i);
            i--;
        }
    }

    m_count = userSource.count();
    emit  usersChanged();
    emit countChanged();
}

void UserModel::deleteUserByIndex(int index)
{
    if(userSource.count()>index)
    {
        userSource.removeAt(index);
    }

    m_count = userSource.count();
    emit  usersChanged();
    emit countChanged();
}

void UserModel::modifyUserByIndex(int index,UserData* user)
{
    if(userSource.count()>index)
    {
        UserData* temp =  userSource.at(index);
        temp->setAge( user->age());
        temp->setName( user->name());
    }
}

UserListModel::UserListModel(QObject *parent)
    : QAbstractListModel(parent)
{
}


int UserListModel::rowCount(const QModelIndex & parent) const {
    Q_UNUSED(parent);
    return m_Users.count();
}

QVariant UserListModel::data(const QModelIndex & index, int role) const {
    if (index.row() < 0 || index.row() >= m_Users.count())
        return QVariant();

    const UserData &user = m_Users[index.row()];
    if (role == NameRole)
        return user.name();
    else if (role == AgeRole)
        return user.age();
    return QVariant();
}

//![0]
QHash<int, QByteArray> UserListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameRole] = "name";
    roles[AgeRole] = "age";
    return roles;
}

void UserListModel::addUser( UserData *user)
{
    UserData temp(*user);
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_Users << temp;
    endInsertRows();
}
void UserListModel::removeUser(int row)
{
    beginRemoveRows(QModelIndex(), row, row);
    m_Users.removeAt(row);
    endRemoveRows();
}
void UserListModel::modifyUser(int row,UserData *user)
{
    if (row < 0 || row >= m_Users.count())
        return ;
    UserData* temp = &(m_Users[row]);
    temp->setAge(user->age());
    temp->setName(user->name());
    //发送dataChanged信号，通知view更新数据
    emit dataChanged (index(row),index(row));
}
