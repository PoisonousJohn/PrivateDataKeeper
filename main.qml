import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QuickAndroid 0.1

ApplicationWindow {
    id: app
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    PageStack {
        id: pageStack
        anchors.fill: parent
        initialPage: Page {
            id: page
            actionBar: ActionBar {
                id : actionBar
                title: "Component List"
                actionButtonEnabled: true
//                iconSource: "/icons/navigation_arrow_back.svg"
                menuBar: Icon {
                    name: "navigation_more_vert.svg"
                    color: "red"
                }
//                menuBar: Rectangle {
//                    width: 50
//                    height: 50
//                    color: "red"
//                }
            }

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

            FloatingActionButton {
                text: "test"
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 40
            }
        }

    }


}
