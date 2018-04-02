import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.1

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300
    FileDialog {
        id: fileDialog
        selectMultiple: true
        onAccepted: {
            for (var i = 0 ; i < fileDialog.fileUrls.length ; i ++){
                listView.model.append({name : fileDialog.fileUrls[i].toString()})
//                console.log(fileDialog.fileUrls[i].toString())
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
    Rectangle {
        id: rec
        border.color: "black"
        border.width: 1;
        x: 42
        y: 46
        width: 223
        height: 383
        ListView {
            id: listView
            model: ListModel {}
            anchors.fill: parent
            delegate:
                Text {
                    id: text
                    width: parent.width
                    wrapMode: Text.WordWrap
                    text: name
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            image.source = text.text
                        }
                    }
                }
            spacing: 10
        }
    }

    Image {
        id: image
        x: 310
        y: 46
        width: 303
        height: 383
        source: "qrc:/qtquickplugin/images/template_image.png"
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
