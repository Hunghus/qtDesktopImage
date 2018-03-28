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
        onAccepted: {
            if (fileDialog.selectExisting)
                document.fileUrl = fileUrl
            else
                document.saveAs(fileUrl, selectedNameFilter)
        }
    }
    Action {
        id: fileOpenAction
        text: "Open"
        onTriggered: {
            fileDialog.selectExisting = true
            fileDialog.open()
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
