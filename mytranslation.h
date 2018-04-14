#ifndef MYTRANSLATION_H
#define MYTRANSLATION_H
#include <QObject>
#include <QGuiApplication>
#include <QTranslator>
#include <mylang.h>
class MyTranslation:public QObject{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)
public:
    MyTranslation(QGuiApplication* app){
        myApp = app;
    }
    QString getEmptyString(){
        return "";
    }
signals:
    void languageChanged();
public slots:
    void updateLanguage(int lang){
//        if (lang == MyLang::VIE){
//            myTranslator.load("vie");
//            myApp->installTranslator(&myTranslator);
//        }
//        if (lang == MyLang::VIE){
//            myTranslator.load("vie");
//            myApp->installTranslator(&myTranslator);
//        }
        switch (lang) {
        case MyLang::VIE:
            myTranslator.load("vie", ":/");
            myApp->installTranslator(&myTranslator);
            break;
        default:
            myApp->removeTranslator(&myTranslator);
            break;
        }
        emit languageChanged();
    }
private:
        QGuiApplication* myApp;
        QTranslator myTranslator;
};
#endif // MYTRANSLATION_H
