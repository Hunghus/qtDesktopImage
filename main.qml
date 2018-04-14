import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick 2.6
import MyLang 1.0

ApplicationWindow {
    id: root
    title: qsTr("Image Viewer") + mytrans.emptyString
    visible: true
    width: 1024; height: 600
    property var array: Array
    property int i_old: 10
    property string picturesLocation : "C:\\"
    property var imageNameFilters : ["*.png","*.ppm", "*.jpg", "*.gif"];
    property var fileDiaTitle: qsTr("Choose some image")
    minimumWidth: 400
    minimumHeight: 300
    color: "#d5d6d8"
    FileDialog {
        id: fileDialog

        title: qsTr(root.fileDiaTitle)
        selectMultiple: true
        folder: picturesLocation
        onAccepted: {
            for (var i = 0 ; i < fileDialog.fileUrls.length ; i ++){
                array[i] = fileDialog.fileUrls[i].toString();
                if(i<10){
                    list.append({name : array[i]})
                }

            }
        }
    }
    Action {
        id: fileOpenAction
        text: qsTr("Open") + mytrans.emptyString
        onTriggered: {
            fileDialog.open()
        }
    }
    GridView {
        id: grid
        width: parent.width
        height: parent.height
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        onMovementEnded: {
            if (atYEnd){
                for (var i = i_old ; i < i_old + 10 ; i ++){
                    list.append({name : array[i]})
                }
                if (i_old + 10 < array.length){

                } else if (i_old < array.length){
                    for (var i = i_old ; i < array.length; i ++){
                        list.append({name : array[i]})
                    }
                }


                i_old += 10;
            }

        }
        cellWidth: parent.width / 3
        cellHeight: parent.height / 3
        model: ListModel{
            id: list
        }
        delegate:
            Rectangle {
                id: photoFrame
                width: grid.cellWidth * 0.9
                height: grid.cellHeight * 0.9
                border.color: "black"
                border.width: 2
                smooth: true
                antialiasing: true
                Image {
                    id: image
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: name
                    antialiasing: true
                }
        }
    }
    menuBar: MenuBar {
            Menu {
                title: qsTr("File") + mytrans.emptyString
                MenuItem { action: fileOpenAction }
                MenuItem { text: qsTr("Quit") + mytrans.emptyString; onTriggered: Qt.quit() }
            }
            Menu {
                title: qsTr("Help") + mytrans.emptyString
                MenuItem { text: qsTr("About...") ; onTriggered: aboutBox.open() }
            }
            Menu {
                title: qsTr("Translate") + mytrans.emptyString
                MenuItem {
                    text: qsTr("English") + mytrans.emptyString
                    onClicked: {
                        mytrans.updateLanguage(MyLang.ENG);
                    }
                }
                MenuItem {
                    text: qsTr("Vietnamese") + mytrans.emptyString
                    onClicked: {
                        mytrans.updateLanguage(MyLang.VIE);
                    }
                }
            }
        }
}
