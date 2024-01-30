import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import org.kde.draganddrop 2.0 as DragDrop
import org.kde.plasma.components 2.0 as PlasmaComponents

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

    property string cfg_icon: plasmoid.configuration.icon
    property bool cfg_useCustomButtonImage: plasmoid.configuration.useCustomButtonImage
    property string cfg_customButtonImage: plasmoid.configuration.customButtonImage

    Kirigami.FormLayout {
        RowLayout {
            Label {
                text: i18n("Icon:")
            }
            Button {
                id: iconButton
                Layout.minimumWidth: previewFrame.width + units.smallSpacing * 2
                Layout.maximumWidth: Layout.minimumWidth
                Layout.minimumHeight: previewFrame.height + units.smallSpacing * 2
                Layout.maximumHeight: Layout.minimumWidth

                DragDrop.DropArea {
                    id: dropArea

                    property bool containsAcceptableDrag: false

                    anchors.fill: parent

                    onDragEnter: {
                        // Cannot use string operations (e.g. indexOf()) on "url" basic type.
                        var urlString = event.mimeData.url.toString();

                        // This list is also hardcoded in KIconDialog.
                        var extensions = [".png", ".xpm", ".svg", ".svgz"];
                        containsAcceptableDrag = urlString.indexOf("file:///") === 0 && extensions.some(function (extension) {
                            return urlString.indexOf(extension) === urlString.length - extension.length; // "endsWith"
                        });

                        if (!containsAcceptableDrag) {
                            event.ignore();
                        }
                    }
                    onDragLeave: containsAcceptableDrag = false

                    onDrop: {
                        if (containsAcceptableDrag) {
                            // Strip file:// prefix, we already verified in onDragEnter that we have only local URLs.
                            iconDialog.setCustomButtonImage(event.mimeData.url.toString().substr("file://".length));
                        }
                        containsAcceptableDrag = false;
                    }
                }

                KQuickAddons.IconDialog {
                    id: iconDialog

                    function setCustomButtonImage(image) {
                        cfg_customButtonImage = image || cfg_icon || "start-here-kde"
                        cfg_useCustomButtonImage = true;
                    }

                    onIconNameChanged: setCustomButtonImage(iconName);
                }

                // just to provide some visual feedback, cannot have checked without checkable enabled
                checkable: true
                checked: dropArea.containsAcceptableDrag
                onClicked: {
                    checked = Qt.binding(function() {
                        return iconMenu.status === PlasmaComponents.DialogStatus.Open || dropArea.containsAcceptableDrag;
                    })

                    iconMenu.open(0, height)
                }

                PlasmaCore.FrameSvgItem {
                    id: previewFrame
                    anchors.centerIn: parent
                    imagePath: plasmoid.location === PlasmaCore.Types.Vertical || plasmoid.location === PlasmaCore.Types.Horizontal
                            ? "widgets/panel-background" : "widgets/background"
                    width: units.iconSizes.medium + fixedMargins.left + fixedMargins.right
                    height: units.iconSizes.medium + fixedMargins.top + fixedMargins.bottom

                    PlasmaCore.IconItem {
                        anchors.centerIn: parent
                        width: units.iconSizes.medium
                        height: width
                        source: cfg_useCustomButtonImage ? cfg_customButtonImage : cfg_icon
                    }
                }
            }

            PlasmaComponents.ContextMenu {
                id: iconMenu
                visualParent: iconButton

                PlasmaComponents.MenuItem {
                    text: i18n('Choose...')
                    icon: "document-open-folder"
                    onClicked: iconDialog.open()
                }
                PlasmaComponents.MenuItem {
                    text: i18n('Clear Icon...')
                    icon: "edit-clear"
                    onClicked: {
                        cfg_useCustomButtonImage = false;
                    }
                }
            }
        }

        RowLayout {
            spacing: 0
            Rectangle { Layout.bottomMargin: 5 }
        }

        Column {
            Label {
                text: i18n('Show buttons:')
            }
            CheckBox {
                id: showLogout
                text: i18n('Logout')
            }
            CheckBox {
                id: showLockscreen
                text: i18n('Lock Screen')
            }
            CheckBox {
                id: showSuspend
                text: i18n('Suspend')
            }
            CheckBox {
                id: showHibernate
                text: i18n('Hibernate')
            }
            CheckBox {
                id: showReboot
                text: i18n('Reboot')
            }
            CheckBox {
                id: showKexec
                text: i18n('Kexec Reboot')
            }
            CheckBox {
                id: showShutdown
                text: i18n('Shutdown')
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
}


