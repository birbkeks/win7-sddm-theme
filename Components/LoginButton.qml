import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: loginButton
    hoverEnabled: true
    width: 30
    height: 29
    x: passwordField.width
    y: -5

    background: Image {
        id: loginbuttonBackground
        width: parent.width
        height: parent.width

        source: {
            if (loginButton.pressed) return "../Assets/go-pressed.png"
            if (loginButton.hovered) return "../Assets/go-hover.png"
            return "../Assets/go.png"
        }
    }


}
