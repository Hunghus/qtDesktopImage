#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <stdio.h>
#include<iostream>
#include <QPixmap>
#include <QFileDialog>
#include <iostream>
#include <QVBoxLayout>
#include <QMessageBox>
QStringList file_names;

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->label_pic->setScaledContents( true );
    connect(ui->lstFiles, SIGNAL(itemDoubleClicked(QListWidgetItem*)), this, SLOT(on_lstFiles_itemDoubleClicked(QListWidgetItem *item)));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_actionOpen_triggered()
{
    QFileDialog diag(this);
    diag.setFileMode(QFileDialog::ExistingFiles);
    file_names = diag.getOpenFileNames(this,"Open a file", "C://");
    if( !file_names.isEmpty() )
    {
        for (int i =0;i<file_names.count();i++){
            ui->lstFiles->addItem(file_names.at(i));
        }
    }
}



void MainWindow::on_lstFiles_itemDoubleClicked(QListWidgetItem *item)
{
        QString name = item->text();
        QPixmap pix(name);
        ui->label_pic->setPixmap(pix.scaled(ui->label_pic->width(),ui->label_pic->height(), Qt::KeepAspectRatioByExpanding));

}
