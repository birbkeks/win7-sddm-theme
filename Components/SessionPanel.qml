import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    property int session: sessionList.currentIndex

    implicitHeight: sessionButton.height
    implicitWidth: sessionButton.width

    DelegateModel {
        id: sessionWrapper
        model: sessionModel
        delegate: ItemDelegate {
            id: sessionEntry
            width: parent.width
            height: 36
            highlighted: sessionList.currentIndex == index
            contentItem: Text {
                renderType: Text.NativeRendering
                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                font.pointSize: 10
                verticalAlignment: Text.AlignVCenter
                color: "black"
                text: name

                Text {
                    id: offon
                    text: "Off"
                    color: "black"
                    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                    font.weight: Font.Bold
                    font.pointSize: 10
                    renderType: Text.NativeRendering

                    anchors {
                        verticalCenter: parent.verticalCenter
                        bottom: parent.top
                        bottomMargin: 5
                    }
                }

                Button {
                    id: sessionLever
                    width: 46
                    height: 15
                    z: 3

                    anchors {
                        top: parent.bottom
                        topMargin: 7
                        right: parent.right
                        rightMargin: 7
                    }

                    background: Rectangle {
                        id: sessionLeverBackground
                        color: "#A6A6A6"
                        border.color: "white"
                        border.width: 1
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            sessionList.currentIndex = index
                        }
                    }

                    Button {
                        id: leftblackLever
                        width: 12
                        height: 19

                        anchors {
                            verticalCenter: parent.verticalCenter
                            left: parent.left
                            leftMargin: -2
                        }

                        background: Rectangle {
                            color: "black"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                sessionList.currentIndex = index
                            }
                        }
                    }

                    Button {
                        id: rightblackLever
                        width: 12
                        height: 19
                        visible: false

                        anchors {
                            verticalCenter: parent.verticalCenter
                            right: parent.right
                            rightMargin: -2
                        }

                        background: Rectangle {
                            color: "black"
                        }
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            sessionList.currentIndex = index
                        }
                    }
                }

                Button {
                    width: 50
                    height: 19

                    anchors {
                        top: parent.bottom
                        topMargin: 5
                        right: parent.right
                        rightMargin: 5
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            sessionList.currentIndex = index
                        }
                    }

                    background: Rectangle {
                        id: leverBack
                        color: "#A6A6A6"
                    }
                }
            }

            background: Rectangle {
                id: sessionEntryBackground
                color: "transparent"
            }

            states: [
                State {
                    name: "focused"
                    when: sessionEntry.focus
                    PropertyChanges {
                        target: sessionLeverBackground
                        color: "#0078D5"
                    }
                    PropertyChanges {
                        target: rightblackLever
                        visible: true
                    }
                    PropertyChanges {
                        target: leftblackLever
                        visible: false
                    }
                    PropertyChanges {
                        target: offon
                        text: "On"
                    }
                },

                State {
                    name: "hovered"
                    when: sessionLever.hovered
                    PropertyChanges {
                        target: sessionLeverBackground
                        color: "#B5B5B5"
                    }
                }
            ]
        }
    }

    Button {
        id: sessionButton
        width: 38
        height: 28

        hoverEnabled: true

        background: Image {
            id: sessionButtonBackground
            source: {
                if (sessionButton.pressed) return "../Assets/access-button-active.png"
                if (sessionButton.hovered && sessionButton.focus) return "../Assets/access-button-hover-focus.png"
                if (sessionButton.hovered && !sessionButton.focus) return "../Assets/access-button-hover.png"
                if (!sessionButton.hovered && sessionButton.focus) return "../Assets/access-button-focus.png"
                return "../Assets/access-button.png"
            }
        }

        contentItem: Item {
            anchors.centerIn: parent

            width: 24
            height: 24

            Image {
                anchors.centerIn: parent
                width: 24
                height: 24
                source: "../Assets/12213.png"
                smooth: false
            }
        }


        ToolTip {
            id: sessionButtonTip

            delay: 1000
            timeout: 4800
            leftPadding: 9
            rightPadding: 9
            topPadding: 7
            bottomPadding: 7
            y: sessionButton.height + 5
            z: 2
            visible: sessionButton.hovered

            contentItem: Text {
                text: "Session"
                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                renderType: Text.NativeRendering
                color: "white"
            }

            background: Rectangle {
                color: "#2A2A2A"
                border.width: 1
                border.color: "#1A1A1A"
            }
        }

        onClicked: {
            sessionPopup.visible ? sessionPopup.close() : sessionPopup.open()
            sessionButtonTip.hide()
        }
    }

    Popup {
        id: sessionPopup
        width: 175
        y: Math.round(-sessionButton.height -(sessionPopup.height) + 25)
        z: 3
        topPadding: 5
        bottomPadding: 15
        leftPadding: 15
        rightPadding: 15

        background: Rectangle {
            color: "white"
            border.width: 1
            border.color: "black"

            Button  {
                id: screenKeyboard
                width: parent.width - 2
                height: 41
                x: 1
                y: 1
                z: 3

                visible: false // disabled for now because i have no idea how to add on screen keyboard :3
                enabled: false

                Text {
                    color: "black"
                    text: "On-Screen Keyboard"
                    renderType: Text.NativeRendering
                    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                    font.pointSize: 10
                    anchors {
                        verticalCenter: parent.verticalCenter
                        left: parent.left
                        leftMargin: 20
                    }
                }

                states: [
                    State {
                        name: "hovered"
                        when: screenKeyboard.hovered
                        PropertyChanges {
                            target: screenKeyboardBackground
                            color: "#30000000"
                        }
                    }
                ]

                background: Rectangle {
                    id: screenKeyboardBackground
                    color: "transparent"
                }
            }
        }

        contentItem: ListView {
            id: sessionList
            implicitHeight: contentHeight + 20
            model: sessionWrapper
            currentIndex: sessionModel.lastIndex
            clip: true
            spacing: 25
            interactive: false
        }

        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                easing.type: Easing.OutCirc
            }
        }

        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1
                to: 0
                easing.type: Easing.OutCirc
            }
        }
    }
}
