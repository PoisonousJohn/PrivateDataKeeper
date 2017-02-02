import QtQuick 2.7
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.0
import './views'

FluidWindow {
    id: app
    visible: true
    width: 640
    height: 480
    initialPage: PrivateDataList{}
    // @disable-check M303
//    initialPage: AuthOverlay {
//        id: auth
//        Button {
//            onClicked: {
//                auth.shown = !auth.shown
//            }
//        }
//    }

    title: qsTr("Hello World")



}
