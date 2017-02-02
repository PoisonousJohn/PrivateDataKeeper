import QtQuick 2.0
import QuickFlux 1.1
import "../actions"

Store {
    property alias model: model
    property int lastUid: 3

    function findIndexByUid(uid) {
        for(var i = 0; i < model.count; ++i) {
            var item = model.get(i);
            if (item.uid === uid)
            {
                return i;
            }
        }

        return -1;
    }

    function isTemporary(item) {
        return item.uid === -1;
    }

    ListModel {
        id: model;
        ListElement {
            uid: 1
            title: "Great password 1"
            password: "pass"
        }
        ListElement {
            uid: 2
            title: "Great password 2"
            password: "pass2"
        }
        ListElement {
            uid: 3
            title: "Great password 3"
            password: "pass3"
        }
    }

    Filter {
        type: "cancelEditingPassword"
        onDispatched: {
           var index = findIndexByUid(message.uid);
            if (index < 0 || !isTemporary(model.get(index)))
            {
                return;
            }

            // removing temporary item
            model.remove(index);
        }
    }

    Filter {
        type: "addGenericPassword"
        onDispatched: {
            var item = {
                title: 	message.title,
                password: message.password
            }

            model.append(item);
        }
    }

    Filter {
        type: "askToAddGenericPassword"
        onDispatched: {
            var item = {
                uid: -1,
                title: "",
                password: ""
            }

            model.append(item);
        }
    }
}
