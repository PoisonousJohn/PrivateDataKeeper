import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import Fluid.Controls 1.0
import QuickFlux 1.0
import "../"
import "../stores"
import "../actions"

Page {
    id: page
    title: "asdf"
    
    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        Repeater {
            id: repeater
            model: MainStore.passwords.model
            delegate: Item {
                id: testParent
                anchors.left: parent.left
                anchors.right: parent.right
                implicitHeight: privateDataListItem.implicitHeight

                PrivateDataListItem {
                    id: privateDataListItem
                    model: repeater.model.get(index)
                    fullScreenContainer: fullPageContainer
                    anchors.left: parent.left
                    anchors.right: parent.right
                    state: "Normal"
//                    onClicked: {
//                        privateDataListItem.expanded = !privateDataListItem.expanded
//                    }
                }
            }
        }
    }
    
    
    Item {
        id: fullPageContainer
        anchors.fill: parent
    }

    SmoothActionButton {
        id: addButton
        Material.elevation: 1
        iconName: "action/note_add"
        color: Material.color(Material.Blue, Material.Shade500)
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        onClicked: {
            AppActions.askToAddGenericPassword();
            var item = MainStore.passwords.model.get(MainStore.passwords.model.count - 1);
            AppActions.openPasswordDetails(item.uid);
        }

    }

    AppListener {
        onDispatched: {
            switch (type) {
                case "openPasswordDetails":
                    addButton.opacity = 0;
                    addButton.enabled = false;
                    break;
                case "closePasswordDetails":
                    addButton.opacity = 1;
                    addButton.enabled = true;
                    break;
            }
        }
    }
}
