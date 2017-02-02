pragma Singleton
import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal addGenericPassword(string title, string password);
    signal askToAddGenericPassword;
    signal openPasswordDetails(int uid);
    signal closePasswordDetails(int uid);
    signal cancelEditingPassword(int uid);
}
