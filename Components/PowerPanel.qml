import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    Item {
        id: powerButton
        width: 62
        height: 28

        Button {
            id: shutdownButton

            anchors.bottom: parent.bottom
            anchors.left: parent.left

            width: 38
            height: 28

            background: Image {
                source: {
                    if (shutdownButton.pressed) return "../Assets/power-active.png"
                    if (shutdownButton.hovered && shutdownButton.focus) return "../Assets/power-hover-focus.png"
                    if (shutdownButton.hovered && !shutdownButton.focus) return "../Assets/power-hover.png"
                    if (!shutdownButton.hovered && shutdownButton.focus) return "../Assets/power-focus.png"
                    return "../Assets/power.png"
                }
            }

            ToolTip {
                id: shutdownButtonTip

                delay: 1000
                timeout: 4800
                leftPadding: 9
                rightPadding: 9
                topPadding: 7
                bottomPadding: 7
                y: shutdownButton.height + 5
                z: 2
                visible: shutdownButton.hovered

                contentItem: Text {
                    text: "Shut down"
                    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                    renderType: Text.NativeRendering
                    color: "dimgray"
                }

                background: Rectangle {
                    color: "white"
                    border.width: 1
                    border.color: "dimgray"
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
                    source: "../Assets/power-glyph.png"
                    smooth: false
                }
            }

            onClicked: {
                sddm.powerOff()
                shutdownButtonTip.hide()
            }
        }

        Button {
            id: expandButton

            anchors.bottom: parent.bottom
            anchors.left: shutdownButton.right

            width: 20
            height: 28

            background: Image {
                source: {
                    if (expandButton.pressed) return "../Assets/expand-active.png"
                    if (expandButton.hovered && expandButton.focus) return "../Assets/expand-hover-focus.png"
                    if (expandButton.hovered && !expandButton.focus) return "../Assets/expand-hover.png"
                    if (!expandButton.hovered && expandButton.focus) return "../Assets/expand-focus.png"
                    return "../Assets/expand.png"
                }
            }

            ToolTip {
                id: expandButtonTip

                delay: 1000
                timeout: 4800
                leftPadding: 9
                rightPadding: 9
                topPadding: 7
                bottomPadding: 7
                y: expandButton.height + 5
                z: 2
                visible: expandButton.hovered

                contentItem: Text {
                    text: "Shut down options"
                    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                    renderType: Text.NativeRendering
                    color: "dimgray"
                }

                background: Rectangle {
                    color: "white"
                    border.width: 1
                    border.color: "dimgray"
                }
            }

            contentItem: Item {
                anchors.centerIn: parent

                width: 9
                height: 6

                Image {
                    anchors.centerIn: parent
                    width: 9
                    height: 6
                    source: "../Assets/expand-glyph-arrow.png"
                    smooth: false
                }
            }

            onClicked: {
                powerPopup.visible ? powerPopup.close() : powerPopup.open()
                powerPopup.visible === powerPopup.open ; powerButton.state = "selection"
                expandButtonTip.hide()
            }
        }
    }

    Popup {
        id: powerPopup
        width: 148
        height: rebootButton.height + sleepButton.height + poweroffButton.height + 6
        x: Math.round((powerButton.width - width) / 2) - 15
        y: -80
        z: 3
        topPadding: 3
        leftPadding: 1
        rightPadding: 2
        background: Rectangle {
            color: "white"
            border.width: 1
            border.color: "#555"
        }

        Button {
            id: rebootButton
            width: 141
            height: 22
            hoverEnabled: true

            x: 3

            background: Rectangle {
                id: rebootButtonBackground
                color: "transparent"
                border.width: 0
                border.color: "transparent"
                radius: 4
            }

            Text {
                text: "Restart"
                color: "black"

                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                font.pointSize: 9.5
                leftPadding: 10
                renderType: Text.NativeRendering

                anchors {
                    verticalCenter: rebootButton.verticalCenter
                }
            }

            states: [
                State {
                    name: "hovered"
                    when: rebootButton.hovered
                    PropertyChanges {
                        target: rebootButtonBackground
                        color: "#253399FF"
                        border.color: "#503399FF"
                        border.width: 1
                    }
                }
            ]

            onClicked: sddm.reboot()
        }

        Button {
            id: sleepButton
            width: 141
            height: 22
            hoverEnabled: true

            anchors {
                horizontalCenter: rebootButton.horizontalCenter
                top: rebootButton.bottom
            }

            background: Rectangle {
                id: sleepButtonBackground
                color: "transparent"
                border.width: 0
                border.color: "transparent"
                radius: 4
            }

            Text {
                text: "Sleep"
                color: "black"

                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                font.pointSize: 9.5
                leftPadding: 10
                renderType: Text.NativeRendering

                anchors {
                    verticalCenter: sleepButton.verticalCenter
                }
            }

            states: [
                State {
                name: "hovered"
                when: sleepButton.hovered
                    PropertyChanges {
                        target: sleepButtonBackground
                        color: "#253399FF"
                        border.color: "#503399FF"
                        border.width: 1
                    }
                }
            ]

            onClicked: sddm.suspend()
        }

        Button {
            id: poweroffButton
            width: 141
            height: 22
            hoverEnabled: true

            anchors {
                horizontalCenter: sleepButton.horizontalCenter
                top: sleepButton.bottom
            }

            background: Rectangle {
                id: poweroffButtonBackground
                color: "transparent"
                border.width: 0
                border.color: "transparent"
                radius: 4
            }

            Text {
                text: "Shut down"
                color: "black"

                font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
                font.pointSize: 9.5
                leftPadding: 10
                renderType: Text.NativeRendering

                anchors {
                    verticalCenter: poweroffButton.verticalCenter
                }
            }

            states: [
                State {
                name: "hovered"
                when: poweroffButton.hovered
                    PropertyChanges {
                        target: poweroffButtonBackground
                        color: "#253399FF"
                        border.color: "#503399FF"
                        border.width: 1
                    }
                }
            ]

            onClicked: sddm.powerOff()
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
