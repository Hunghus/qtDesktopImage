#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>
#include "mylang.h"
#include "mytranslation.h"

#include <QtQml/qqmlapplicationengine.h>


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<MyLang>("MyLang",1,0,"MyLang");
    MyTranslation myTrans(&app);

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mytrans", &myTrans);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
