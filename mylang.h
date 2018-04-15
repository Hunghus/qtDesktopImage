#ifndef MYLANG_H
#define MYLANG_H
#include <QObject>
#include <QLocale>

class MyLang: public QObject{
    Q_OBJECT
public:
    MyLang(){}
    enum E_Language{
        ENG = QLocale::English,
        VIE = QLocale::Vietnamese
    };
    Q_ENUM(E_Language)
};
#endif // MYLANG_H
