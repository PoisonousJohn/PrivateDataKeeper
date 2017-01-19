import QtQuick 2.7
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import QtQuick.Controls.Material 2.0
import QuickAndroid 0.1 as And

Page {

    property bool shown: false

    function show()
    {
        shown = true;
    }

    function hide()
    {
        shown = false;
        pass.text = "";
    }

    Curtain {
        id: left
        state: shown ? "closedLeft" : "openedLeft"
    }
    Curtain {
        id: right
        state: shown ? "closedRight" : "openedRight"
    }

    Icon {
        name: "action/lock"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: title.bottom
    }

    TitleLabel {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 20
        font.pixelSize: 40
        text: qsTr("Authorization required")
    }

    Item {
        id: form
        anchors.fill: parent
        opacity: auth.shown ? 1 : 0

        Behavior on opacity {
            PropertyAnimation {}
        }

        TitleLabel {
            text: qsTr("Password")
            anchors.bottom: pass.top
            anchors.left: pass.left
        }

        And.TextField {
            id: pass
            color: Material.color(Material.Red)
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.right: parent.right
            anchors.rightMargin: actionButton.width + 40
            anchors.verticalCenter: parent.verticalCenter
            implicitWidth: parent.width * 0.8
            font.pointSize: displayText.length > 10 ? 25 : 50
            echoMode: TextInput.Password
            focus: shown
            placeholderText: "Enter password"
        }

        SmoothActionButton {
            id: actionButton
            color: Material.color(Material.Green)
            anchors.left: pass.right
            anchors.verticalCenter: pass.verticalCenter
            iconName: "navigation/check"
            onClicked: {
                auth.hide()
            }
        }
    }




}
