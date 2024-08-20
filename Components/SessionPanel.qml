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
            height: 25
            highlighted: sessionList.currentIndex == index
            contentItem: Text {
                renderType: Text.NativeRendering
                font.weight: Font.Normal
                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                font.pointSize: 10
                verticalAlignment: Text.AlignVCenter
                color: "black"
                text: name

                leftPadding: 20

                Button {
                    id: checkPool
                    width: 13
                    height: 13
                    z: 3

                    hoverEnabled: true

                    anchors {
                        right: parent.left
                        rightMargin: -13
                    }

                    Image {
                        id: cimg

                        source: {
                            if (checkbox.hovered && sessionEntry.focus) return "../Assets/cbox-hover-focus.png"
                            if (checkbox.hovered && !sessionEntry.focus) return "../Assets/cbox-hover.png"
                            if (!checkbox.hovered && sessionEntry.focus) return "../Assets/cbox-focus.png"

                            return "../Assets/cbox.png"
                        }
                    }

                    Button {
                        id: checkbox
                        width: 13
                        height: 13

                        hoverEnabled: true

                        background: Rectangle {
                            color: "transparent"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                sessionList.currentIndex = index
                            }
                        }
                    }
                }
            }

            background: Rectangle {
                id: sessionEntryBackground
                color: "white"
            }
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
            session.visible ? session.visible = false : session.visible = true
            sessionButtonTip.hide()
        }
    }

    Rectangle {
        id: session
        width: 506
        height: 407
        radius: 8
        visible: false

        y: -550

        Image {
            source: "../Assets/sessions.png"
        }

        Control {
            id: sessionPopup
            width: 500
            height: 250
            z: 3

            leftInset: 50
            leftPadding: 50

            rightInset: 50
            rightPadding: 50

            bottomPadding: 5
            bottomInset: 5

            background: Rectangle {
                color: "white"
            }

            contentItem: ListView {
                id: sessionList
                implicitHeight: contentHeight
                model: sessionWrapper
                currentIndex: sessionModel.lastIndex
                clip: true
                spacing: 20
                interactive: sessionList.count > 6 ? true : false
            }

            anchors.top: parent.top
            anchors.topMargin: 91
        }

        Drag.active: dragArea.drag.active
        Drag.hotSpot.x: 10
        Drag.hotSpot.y: 10

        MouseArea {
            id: dragArea
            anchors.fill: parent

            drag.target: parent
        }

        Button {
            id: closebut

            width: 31
            height: 16

            hoverEnabled: true

            anchors.right: parent.right
            anchors.rightMargin: 10

            anchors.top: parent.top
            anchors.topMargin: 10

            Image {
                source: {
                    if (closebut.hovered) return "../Assets/close-hover.png"
                    return "../Assets/close.png"
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    session.visible = false
                }
            }
        }

        Button {
            id: apbut

            width: 73
            height: 20

            hoverEnabled: true

            anchors.right: parent.right
            anchors.rightMargin: 19

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 19

            Image {
                source: {
                    if (apbut.hovered) return "../Assets/apbutton-hover.png"
                    return "../Assets/apbutton.png"
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    session.visible = false
                }
            }
        }

        Button {
            id: canbut

            width: 73
            height: 20

            hoverEnabled: true

            anchors.right: apbut.left
            anchors.rightMargin: 5

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 19

            Image {
                source: {
                    if (canbut.hovered) return "../Assets/canbutton-hover.png"
                    return "../Assets/canbutton.png"
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    session.visible = false
                }
            }
        }

        Button {
            id: okbut

            width: 73
            height: 20

            hoverEnabled: true

            anchors.right: canbut.left
            anchors.rightMargin: 5

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 19

            Image {
                source: {
                    if (okbut.hovered) return "../Assets/okbutton-hover.png"
                    return "../Assets/okbutton.png"
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    session.visible = false
                }
            }
        }
    }
}
