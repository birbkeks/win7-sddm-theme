import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import QtMultimedia
import "Components"

Item {
    id: root
    width: Screen.width
    height: Screen.height

    FontLoader {
        id: segoeui
        source: Qt.resolvedUrl("fonts/segoeui.ttf")
    }

    FontLoader {
        id: segoeuil
        source: Qt.resolvedUrl("fonts/segoeuil.ttf")
    }

    FontLoader {
        id: iconfont
        source: Qt.resolvedUrl("fonts/SegMDL2.ttf")
    }

    Rectangle {
        id: background
        anchors.fill: parent
        width: parent.width
        height: parent.height

        MediaPlayer {
            id: startupSound
            autoPlay: true
            source: Qt.resolvedUrl("Assets/Startup-Sound.wav")
            audioOutput: AudioOutput {}
        }

        Image {
            anchors.fill: parent
            width: parent.width
            height: parent.height
            source: config.background

            Rectangle {
                width: parent.width
                height: parent.height
                color: "transparent"
            }
        }
    }

    Image {
        source: config.branding

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Item {
        id: rightPanel

        anchors {
            bottom: parent.bottom
            right: parent.right
            rightMargin: 92
            bottomMargin: 62
        }

        PowerPanel {
            id: powerPanel
        }
    }

    Item {
        id: leftPanel
        z: 9

        anchors {
            bottom: parent.bottom
            left: parent.left
            leftMargin: 34
            bottomMargin: 62
        }

        SessionPanel {
            id: sessionPanel
        }
    }

    Rectangle {
        id: startupPanel
        color: "transparent"
        anchors.fill: parent

        visible: listView2.count > 1 ? true : false
        enabled: listView2.count > 1 ? true : false

        Component {
            id: userDelegate2

            UserList {
                id: userList
                name: (model.realName === "") ? model.name : model.realName
                icon: "/var/lib/AccountsService/icons/" + name

                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        listView2.currentIndex = index
                        listView2.focus = true
                        listView.currentIndex = index
                        listView.focus = true
                        centerPanel.visible = true
                        centerPanel.enabled = true
                        startupPanel.visible = false
                        startupPanel.enabled = false
                    }
                }
            }
        }

        Rectangle {
            //width: user 60 + spacing 120 + user 60 + spacing 120 + user 60
            width: 180 * listView2.count
            height: Screen.height / 10
            color: "transparent"
            clip: true

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Item {
                id: usersContainer2
                width: parent.width
                height: parent.height

                Button {
                    id: prevUser2
                    visible: false
                    enabled: false
                    width: 60

                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                    }
                }

                ListView {
                    id: listView2
                    height: parent.height
                    focus: true
                    model: userModel
                    currentIndex: userModel.lastIndex
                    delegate: userDelegate2
                    orientation: ListView.Horizontal
                    interactive: false
                    spacing: 120

                    anchors {
                        left: prevUser2.right
                        right: nextUser2.left
                    }
                }

                Button {
                    id: nextUser2
                    visible: true
                    width: 0
                    enabled: false

                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }
                }
            }
        }
    }

    Item {
        id: centerPanel
        anchors.centerIn: root
        visible: listView2.count > 1 ? false : true
        enabled: listView2.count > 1 ? false : true

        Item {

            Component {
                id: userDelegate

                UserPanel {
                    anchors.centerIn: parent
                    name: (model.realName === "") ? model.name : model.realName
                    icon: "/var/lib/AccountsService/icons/" + name
                }
            }

            Button {
                id: prevUser
                anchors.left: parent.left
                enabled: false
                visible: false
            }

            ListView {
                id: listView
                focus: listView.count > 1 ? false : true
                model: userModel
                delegate: userDelegate
                currentIndex: userModel.lastIndex
                interactive: false

                anchors {
                    left: prevUser.right
                    right: nextUser.left
                }
            }

            Button {
                id: nextUser
                anchors.right: parent.right
                enabled: false
                visible: false
            }
        }

        Button {
            id: switchUser
            width: 108
            height: 27
            hoverEnabled: true

            visible: listView2.count > 1 ? true : false
            enabled: listView2.count > 1 ? true : false

            onClicked: {
                centerPanel.visible = false
                centerPanel.enabled = false

                startupPanel.visible = true
                startupPanel.enabled = true
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.bottom
                topMargin: 150
            }

            Text {
                text: "Switch user"
                font.pointSize: 11.5
                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                renderType: Text.NativeRendering
                color: "white"

                anchors.centerIn: parent
            }

            background: Rectangle {
                id: switchUserbg
                color: "transparent"

                Image {
                    id: switchImg

                    source: {
                        if (switchUser.pressed) return "Assets/switch-user-button-active.png"
                        if (switchUser.hovered && switchUser.focus) return "Assets/switch-user-button-hover-focus.png"
                        if (switchUser.hovered && !switchUser.focus) return "Assets/switch-user-button-hover.png"
                        if (!switchUser.hovered && switchUser.focus) return "Assets/switch-user-button-focus.png"
                        return "Assets/switch-user-button.png"
                    }
                }
            }
        }
    }
}
