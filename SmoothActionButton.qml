import QtQuick 2.7
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0
import Fluid.Material 1.0
import QtQuick.Controls.Material 2.0
import QuickAndroid 0.1 as And

ActionButton {
    property color color

    id: actionButton
    Material.background: actionButton.enabled
                         ? color
                         : Material.color(Material.Grey)
    enabled: pass.displayText.length > 0
    
    Behavior on color {
        
        ColorAnimation {
        }
    }
    
}
