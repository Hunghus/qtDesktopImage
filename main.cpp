#include <QGuiApplication>

#include <QtQml/qqmlapplicationengine.h>

#include <QObject>
#include <showmessage.h>
#include <QDebug>
#include <bits/stdc++.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    ShowMessage smes;

    QObject* text = engine.rootObjects().first()->findChild<QObject*>("Text");

    QObject::connect(text, SIGNAL(showConsole()), &smes, SLOT(displayMessage()));
    return app.exec();
}
