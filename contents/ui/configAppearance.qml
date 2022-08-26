import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Item {

    property alias cfg_showLogout: showLogout.checked
    property alias cfg_showLockscreen: showLockscreen.checked
    property alias cfg_showSuspend: showSuspend.checked
    property alias cfg_showHibernate: showHibernate.checked
    property alias cfg_showReboot: showReboot.checked
    property alias cfg_showKexec: showKexec.checked
    property alias cfg_showShutdown: showShutdown.checked
    property alias cfg_width: widthSpinBox.value
    property alias cfg_height: heightSpinBox.value

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
            id: showKexec
            text: i18n('Kexec Reboot')
            Layout.columnSpan: 2
        }
        CheckBox {
            id: showShutdown
            text: i18n('Shutdown')
            Layout.columnSpan: 2
        }
        
        Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        RowLayout {
            Kirigami.FormData.label: i18n("Size:")
            SpinBox {
                id: widthSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
            Label {
                text: " x "
            }
            SpinBox {
                id: heightSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
        }
    }

}
}


