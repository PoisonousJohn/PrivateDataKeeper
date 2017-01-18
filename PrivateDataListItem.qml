import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QuickAndroid 0.1

Paper {
    id: privateDataListItem
    
    property bool expanded: false
    property var fullScreenContainer
    property var model: {
        "title" : "Title",
        "password" : "pass"
    }

    height: 60
    implicitHeight: height

    signal clicked

    onClicked: {
        titleField.focus = false;
    }

    Ink {
        anchors.fill: parent
        onClicked: privateDataListItem.clicked()
    }

    Item {
        id: nonExpandedLayout
        opacity: !expanded ? 1 : 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            text: model.title
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: copyBtn.left
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        RaisedButton {
            id: copyBtn
            text: "Copy password"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
        }


        Behavior on opacity {
            PropertyAnimation {
                duration: 300
            }
        }
    }

    Item {
        id: expandedLayout
        opacity: expanded ? 1 : 0

        ColumnLayout {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.right
            anchors.leftMargin: 20
            anchors.topMargin: 20

            TextField {
                id: titleField
                floatingLabelText: "Title"
                text: model ? model.title : ""
            }

            TextField {
                id: passField
                floatingLabelText: "Password"
                echoMode: TextInput.Password
                text: model ? model.password : ""
            }

        }


        Behavior on opacity {
            PropertyAnimation {
                duration: 300
            }
        }

    }

    

    states: [
        State {
            name: "Normal"
            when: !privateDataListItem.expanded
            
            ParentChange {
                target: privateDataListItem
                parent: testParent
            }
        },
        State {
            name: "Selected"
            when: privateDataListItem.expanded
            
            PropertyChanges {
                target: privateDataListItem
                y: 0
            }
            
            ParentChange {
                target: privateDataListItem
                parent: fullScreenContainer
            }
            
            AnchorChanges {
                target: privateDataListItem
                anchors.top: fullScreenContainer.top
                anchors.bottom: fullScreenContainer.bottom
            }
        }
    ]
    
    transitions: [
        Transition {
            from: "Normal"
            to: "Selected"
            PropertyAnimation {
                duration: 300
                properties: "y"
                easing.type: Easing.OutCirc
            }
            ParentAnimation {
            }
            AnchorAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
            
        },
        Transition {
            from: "Selected"
            to: "Normal"
            onRunningChanged: {
                testParent.z = running ? 100 : 0
            }
            
            ParentAnimation {
                PropertyAnimation {
                    duration: 300
                    easing.type: Easing.OutCirc
                    properties: "y"
                    onStarted: {
                        console.log("started")
                        target.z = 100
                    }
                    onStopped: {
                        console.log("stopped")
                        target.z = 0
                    }
                }
                AnchorAnimation {
                    duration: 300
                    easing.type: Easing.OutCirc
                }
            }
            
        }
        
    ]
}
