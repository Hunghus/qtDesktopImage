#include "showmessage.h"
#include <QDebug>
ShowMessage::ShowMessage()
{

}
void ShowMessage::displayMessage(){
    qDebug() << "ShowMessage:: receive from QML";

}
