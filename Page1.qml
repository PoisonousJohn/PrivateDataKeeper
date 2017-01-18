import QtQuick 2.7
import QuickAndroid 0.1

Page {
    id: page
    actionBar: ActionBar {
        title: "TTT"
    }

    Page1Form {
        anchors.fill: parent
        button1.onClicked: {
            console.log("Button Pressed. Entered text: " + textField1.text);
            page.stack.pop();
        }
    }

}
