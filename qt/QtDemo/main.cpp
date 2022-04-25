#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include  "./src/usermodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<UserData>("UserModule", 1, 0, "UserData");
    qmlRegisterType<UserModel>("UserModule", 1, 0, "UserModel");
    qmlRegisterType<UserListModel>("UserModule", 1, 0, "UserListModel");
    QQmlApplicationEngine engine;

    const QUrl url(u"qrc:/QtDemo/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
