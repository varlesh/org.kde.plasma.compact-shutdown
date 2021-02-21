// Copyright 2021 Alexey Varfolomeev <varlesh@gmail.com>
// Used sources & ideas:
// - Michail Vourlakos from https://github.com/psifidotos/applet-latte-sidebar-button
// - Jakub Lipinski from https://gitlab.com/divinae/uswitch

import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    id: root

    Layout.fillWidth: true
    Layout.fillHeight: true
    width: 135
    height: 150

    Plasmoid.compactRepresentation: Item {
        PlasmaCore.IconItem {
            anchors.fill: parent
            source: "system-shutdown"
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent

            onClicked: {
                plasmoid.expanded = !plasmoid.expanded
            }
        }
    }

    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)

        function exec(cmd) {
            executable.connectSource(cmd)
        }
    }

    function action_logOut() {
        executable.exec('qdbus org.kde.ksmserver /KSMServer logout 0 0 2')
    }

    function action_reBoot() {
        executable.exec('qdbus org.kde.ksmserver /KSMServer logout 0 1 2')
    }

    function action_shutDown() {
        executable.exec('qdbus org.kde.ksmserver /KSMServer logout 0 2 2')
    }
    
    function action_susPend() {
         executable.exec('qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend')
    }
    
    function action_hiberNate() {
         executable.exec('qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Hibernate')
    }

    PlasmaComponents.Highlight {
        id: delegateHighlight
        visible: false
        z: -1 // otherwise it shows ontop of the icon/label and tints them slightly
    }

    Plasmoid.fullRepresentation: Item {
        Layout.preferredWidth: 135
        Layout.preferredHeight: 150

        ColumnLayout {
            id: column
            anchors.fill: parent

            spacing: 0
            ListDelegate {
                id: logoutButton
                text: i18n("Logout")
                highlight: delegateHighlight
                icon: "system-log-out"
                onClicked: action_logOut()
            }
            ListDelegate {
                id: suspendButton
                text: i18n("Suspend")
                highlight: delegateHighlight
                icon: "system-suspend"
                onClicked: action_susPend()
            }

            ListDelegate {
                id: hibernateButton
                text: i18n("Hibernate")
                highlight: delegateHighlight
                icon: "system-suspend-hibernate"
                onClicked: action_hiberNate()
            }

            ListDelegate {
                id: rebootButton
                text: i18n("Reboot")
                highlight: delegateHighlight
                icon: "system-reboot"
                onClicked: action_reBoot()
            }
            ListDelegate {
                id: shutdownButton
                text: i18n("Shutdown")
                highlight: delegateHighlight
                icon: "system-shutdown"
                onClicked: action_shutDown()
            }
        }
    }
}
