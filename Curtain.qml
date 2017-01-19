import QtQuick 2.7
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0
import QtQuick.Controls.Material 2.0

Card {
    id: curtain
    Material.background: Material.color(Material.Red, Material.Shade200)
    Material.elevation: 0
    width: parent.width * 0.5
    height: parent.height

    states: [
        State {
            name: "openedLeft"
            AnchorChanges {
                target: curtain
                anchors.right: curtain.parent.left
                anchors.left: undefined
            }
        },
        State {
            name: "openedRight"
            AnchorChanges {
                target: curtain
                anchors.left: curtain.parent.right
                anchors.right: undefined
            }
        },
        State {
            name: "closedLeft"
            AnchorChanges {
                target: curtain
                anchors.left: undefined
                anchors.right: parent.horizontalCenter
            }
        },
        State {
            name: "closedRight"
            AnchorChanges {
                target: curtain
                anchors.left: parent.horizontalCenter
                anchors.right: undefined
            }
        }
    ]

    transitions: [
        Transition {
            AnchorAnimation {
                easing.type: Easing.OutCirc
                duration: 300
            }
        }

    ]

}
