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
    property int highestZ: 0
    property real defaultSize: 200
    property var currentFrame: undefined
    property real surfaceViewportRatio: 1.5
    property string picturesLocation : "C:\\"
    property var imageNameFilters : ["*.png","*.ppm", "*.jpg", "*.gif"];
    minimumWidth: 400
    minimumHeight: 300
    color: "#d5d6d8"
    FileDialog {
        id: fileDialog

        title: "Choose a folder with some images"
        selectMultiple: true
        folder: picturesLocation
        onAccepted: {
            console.log("tesst")
            for (var i = 0 ; i < fileDialog.fileUrls.length ; i ++){

                array[i] = fileDialog.fileUrls[i].toString();
                 console.log(array[i])
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
    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: width * surfaceViewportRatio
        contentHeight: height * surfaceViewportRatio
        onMovementEnded: {
            console.log("tests")
            for (var i = i_old ; i < i_old + 10 ; i ++){
                console.log(array[i])
                list.append({name : array[i]})

            }
            if (i_old + 10 < array.length){

            } else if (i_old < array.length){
                for (var i = i_old ; i < array.length; i ++){
                    list.append({name : array[i]})
//                    console.log(array[i])
                }
            }


            i_old += 10;
        }
        Repeater {
            model: ListModel{
                id: list
            }
            Rectangle {
                id: photoFrame
                width: image.width * (1 + 0.10 * image.height / image.width)
                height: image.height * 1.10
                scale: defaultSize / Math.max(image.sourceSize.width, image.sourceSize.height)
                Behavior on scale { NumberAnimation { duration: 200 } }
                Behavior on x { NumberAnimation { duration: 200 } }
                Behavior on y { NumberAnimation { duration: 200 } }
                border.color: "black"
                border.width: 2
                smooth: true
                antialiasing: true
//                Component.onCompleted: {
//                    x = Math.random() * root.width - width / 2
//                    y = Math.random() * root.height - height / 2
//                    rotation = Math.random() * 13 - 6
//                }
                Image {
                    id: image
                    anchors.centerIn: parent
                    fillMode: Image.PreserveAspectFit
                    source: name
                    antialiasing: true
                }
                PinchArea {
                    anchors.fill: parent
                    pinch.target: photoFrame
                    pinch.minimumRotation: -360
                    pinch.maximumRotation: 360
                    pinch.minimumScale: 0.1
                    pinch.maximumScale: 10
                    pinch.dragAxis: Pinch.XAndYAxis
                    onPinchStarted: setFrameColor();
                    property real zRestore: 0
                    onSmartZoom: {
                        if (pinch.scale > 0) {
                            photoFrame.rotation = 0;
                            photoFrame.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                            photoFrame.x = flick.contentX + (flick.width - photoFrame.width) / 2
                            photoFrame.y = flick.contentY + (flick.height - photoFrame.height) / 2
                            zRestore = photoFrame.z
                            photoFrame.z = ++root.highestZ;
                        } else {
                            photoFrame.rotation = pinch.previousAngle
                            photoFrame.scale = pinch.previousScale
                            photoFrame.x = pinch.previousCenter.x - photoFrame.width / 2
                            photoFrame.y = pinch.previousCenter.y - photoFrame.height / 2
                            photoFrame.z = zRestore
                            --root.highestZ
                        }
                    }

                    MouseArea {
                        id: dragArea
                        hoverEnabled: true
                        anchors.fill: parent
                        drag.target: photoFrame
                        scrollGestureEnabled: false  // 2-finger-flick gesture should pass through to the Flickable
                        onPressed: {
                            photoFrame.z = ++root.highestZ;
                            parent.setFrameColor();
                        }
                        onEntered: parent.setFrameColor();
                        onWheel: {
                            if (wheel.modifiers & Qt.ControlModifier) {
                                photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                                if (Math.abs(photoFrame.rotation) < 4)
                                    photoFrame.rotation = 0;
                            } else {
                                photoFrame.rotation += wheel.angleDelta.x / 120;
                                if (Math.abs(photoFrame.rotation) < 0.6)
                                    photoFrame.rotation = 0;
                                var scaleBefore = photoFrame.scale;
                                photoFrame.scale += photoFrame.scale * wheel.angleDelta.y / 120 / 10;
                            }
                        }
                    }
                    function setFrameColor() {
                        if (currentFrame)
                            currentFrame.border.color = "black";
                        currentFrame = photoFrame;
                        currentFrame.border.color = "red";
                    }
                }
            }
        }
    }
//    ScrollView {
//        anchors.fill: parent
//        GridView {
//            id: gridView
//            anchors.leftMargin: 20
//            anchors.rightMargin: 20
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.left: parent.left
//            anchors.right: parent.right
//            leftMargin: 10
//            topMargin: 20
//            cellWidth: width/3
//            cellHeight: height/3
//            model: ListModel {}
//            delegate: Rectangle {
//                border.color: "black"
//                border.width: 10
//                width: 200
//                height: 100
//                Image {
//                    fillMode: Image.PreserveAspectCrop
//                    antialiasing: true
//                    anchors.fill: parent
//                    horizontalAlignment: Image.AlignHCenter
//                    source: name

//                }
//            }
//        }
//    }
//    Rectangle {
//        id: rec
//        border.color: "black"
//        border.width: 0;
//        x: 42
//        y: 46
//        width: 223
//        height: 383
//        color: "transparent"
//        ListView {
//            id: listView
//            boundsBehavior: Flickable.StopAtBounds
//            flickableDirection: Flickable.HorizontalAndVerticalFlick
//            model: ListModel {}
//            anchors.fill: parent
//            clip: true
//            ScrollBar.vertical: ScrollBar{
//                size: 5
//            }
//            delegate:
//                Text {
//                    id: text
//                    objectName: "Text"
//                    signal showConsole(string msg);
//                    width: parent.width
//                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
//                    text: ic + " " + name
//                    MouseArea{
//                        id: ma
//                        objectName: "MouseArea"

//                        anchors.fill: parent

//                        onClicked: {
//                            text.showConsole("hello from QML");
//                            image.source = name
//                        }
//                    }
//                }
//            spacing: 10
//        }
//    }

//    Image {
//        id: image
//        x: 310
//        y: 46
//        width: 563
//        height: 383
////        fillMode: Image.PreserveAspectFit
//    }
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
