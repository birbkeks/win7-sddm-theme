import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordField
    focus: true
    visible: true
    selectByMouse: true
    placeholderText: "Password"
    placeholderTextColor: "#555"

    property alias text: passwordField.text

    echoMode: TextInput.Password
    selectionColor: "#3399FF"

    font.family: Qt.resolvedUrl("../fonts") ? "Segoe UI" : segoeui.name
    font.pointSize: 9.2
    renderType: Text.NativeRendering

    color: "black"

    horizontalAlignment: TextInput.AlignLeft
    width: 223
    height: 23

    background: Image {
        id: passFieldBackground
        source: "../Assets/input.png"
        x: -5
        width: passwordField.width + 10
    }
}
