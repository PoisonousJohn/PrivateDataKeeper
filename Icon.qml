import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: icon
    property alias image: image
    property color color
    property string name

    implicitHeight: image.height
    implicitWidth: image.width

    Image {
        id: image
        visible: name && name.length > 0
        source: name && name.length > 0 ? "icons/" + name : ""
//        anchors.fill: parent

    }

    ColorOverlay {
        id: overlay
        anchors.fill: image
        source: image
        cached: true
        visible: color !== undefined
        color: icon.color
    }

}
