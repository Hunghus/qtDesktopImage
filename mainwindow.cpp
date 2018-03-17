#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPixmap>
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QPixmap pix("C:/Users/Public/Pictures/Sample Pictures/Desert.jpg");
    ui->label_pic->setPixmap(pix.scaled(ui->label_pic->width(),ui->label_pic->height(), Qt::KeepAspectRatio));

}

MainWindow::~MainWindow()
{
    delete ui;
}
