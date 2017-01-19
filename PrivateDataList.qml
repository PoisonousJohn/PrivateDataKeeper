import QtQuick 2.7
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0

Page {
    id: page
    title: "asdf"
    
    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        Repeater {
            model: 3
            delegate: Item {
                id: testParent
                anchors.left: parent.left
                anchors.right: parent.right
                implicitHeight: privateDataListItem.implicitHeight
                PrivateDataListItem {
                    id: privateDataListItem
                    fullScreenContainer: fullPageContainer
                    anchors.left: parent.left
                    anchors.right: parent.right
                    state: "Normal"
                    onClicked: {
                        privateDataListItem.expanded = !privateDataListItem.expanded
                    }
                }
            }
        }
    }
    
    
    Item {
        id: fullPageContainer
        anchors.fill: parent
    }
    
}
