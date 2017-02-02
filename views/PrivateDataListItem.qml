import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import QuickFlux 1.0
import "../actions"
//import QuickAndroid 0.1

Card {
    id: privateDataListItem
    
    property bool expanded: false
    property var fullScreenContainer
    property var model: {
        "uid" : 777,
        "title" : "Title",
        "password" : "pass"
    }

    signal clicked

    height: 60
    implicitHeight: height


    onClicked: {
        titleField.focus = false;
        if (expanded) {
            AppActions.closePasswordDetails(model.uid)
        } else {
            AppActions.openPasswordDetails(model.uid)
        }
    }

    Ripple {
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
            text: model ? model.title : ""
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: copyBtn.left
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        Button {
            id: copyBtn
            visible: model !== undefined && model != null && model.password.length > 0
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
//                floatingLabelText: "Title"
                text: model ? model.title : ""
            }

            TextField {
                id: passField
//                floatingLabelText: "Password"
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

    AppListener {
        onDispatched: {
            if (message.uid === privateDataListItem.model.uid)
            {
                switch (type) {
                    case "openPasswordDetails":
                        privateDataListItem.expanded = true;
                        break;
                    case "closePasswordDetails":
                        privateDataListItem.expanded = false;
                        break;
                }

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
                if (!running)
                {
                   AppActions.cancelEditingPassword(model.uid);
                }
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
