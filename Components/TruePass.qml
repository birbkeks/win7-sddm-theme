import QtQuick 2.15
import QtQuick.Controls 2.15

Item {

    Button {
        id: trueButton
        x: 1
        y: 1

        Text {
            color: "white"
            font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
            text: "Welcome"
            renderType: Text.NativeRendering
            font.weight: Font.Normal
            font.pointSize: 17
            anchors.centerIn: parent
        }

        background: Rectangle {
            id: falseButtonBackground
            color: "transparent"
        }
    }
}

