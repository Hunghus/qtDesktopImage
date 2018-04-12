import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1
import QtQuick 2.6
import Qt.labs.folderlistmodel 1.0


ApplicationWindow {
    id: root
    visible: true
    width: 1024; height: 600
    property var array: Array
    property int i_old: 10
    property string picturesLocation : "C:\\"
    property var imageNameFilters : ["*.png","*.ppm", "*.jpg", "*.gif"];
    minimumWidth: 400
    minimumHeight: 300
    color: "#d5d6d8"
    FileDialog {
        id: fileDialog

        title: "Choose some images"
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
        text: "Open"
        onTriggered: {
            fileDialog.open()
        }
    }
//    Flickable {
//        id: flick
//        anchors.fill: parent
//        contentWidth: width
//        contentHeight: height * surfaceViewportRatio
//        flickableDirection: Flickable.HorizontalAndVerticalFlick
//        onFlickStarted : {
//            console.log(flick.contentWidth, flick.contentHeight)
//            for (var i = i_old ; i < i_old + 10 ; i ++){
//                console.log(array[i])
//                list.append({name : array[i]})

//            }
//            if (i_old + 10 < array.length){

//            } else if (i_old < array.length){
//                for (var i = i_old ; i < array.length; i ++){
//                    list.append({name : array[i]})
//                    console.log(array[i])
//                }
//            }


//            i_old += 10;
//        }
//        onMovementEnded: {
//            console.log("tests")
//            for (var i = i_old ; i < i_old + 10 ; i ++){
//                console.log(array[i])
//                list.append({name : array[i]})

//            }
//            if (i_old + 10 < array.length){

//            } else if (i_old < array.length){
//                for (var i = i_old ; i < array.length; i ++){
//                    list.append({name : array[i]})
////                    console.log(array[i])
//                }
//            }


//            i_old += 10;
//        }
        GridView {
            id: grid
            width: parent.width
            height: parent.height
            //            clip: true
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            onMovementEnded: {
                console.log("tests")
                for (var i = i_old ; i < i_old + 10 ; i ++){
//                    console.log(array[i])
                    list.append({name : array[i]})

                }
                if (i_old + 10 < array.length){

                } else if (i_old < array.length){
                    for (var i = i_old ; i < array.length; i ++){
                        list.append({name : array[i]})
//                            console.log(array[i])
                    }
                }


                i_old += 10;
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
                title: "&File"
                MenuItem { action: fileOpenAction }
                MenuItem { text: "Quit"; onTriggered: Qt.quit() }
            }
            Menu {
                title: "&Help"
                MenuItem { text: "About..." ; onTriggered: aboutBox.open() }
            }
        }
}
