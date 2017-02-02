pragma Singleton

import QuickFlux 1.1

Store {
    property alias passwords: passwords

    bindSource: AppDispatcher

    PasswordsStore {
        id: passwords
    }

}
