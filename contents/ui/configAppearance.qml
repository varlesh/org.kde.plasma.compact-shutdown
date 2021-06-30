import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

Item {

    property alias cfg_showLogout: showLogout.checked
    property alias cfg_showLockscreen: showLockscreen.checked
    property alias cfg_showSuspend: showSuspend.checked
    property alias cfg_showHibernate: showHibernate.checked
    property alias cfg_showReboot: showReboot.checked
    property alias cfg_showShutdown: showShutdown.checked

    GridLayout {
        columns: 2
        Label {
            text: i18n('Show buttons:')
        }
        CheckBox {
            id: showLogout
            text: i18n('Logout')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showLockscreen
            text: i18n('Lock Screen')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showSuspend
            text: i18n('Suspend')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showHibernate
            text: i18n('Hibernate')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showReboot
            text: i18n('Reboot')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showShutdown
            text: i18n('Shutdown')
            Layout.columnSpan: 2
        }
    }
}
