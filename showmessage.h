#ifndef SHOWMESSAGE_H
#define SHOWMESSAGE_H

#include <QObject>

class ShowMessage: public QObject
{
public:
    ShowMessage();
public slots:
    void displayMessage();
};

#endif // SHOWMESSAGE_H
