import QtQuick

FocusScope {
    width: 96
    height: 28
    Rectangle {
        border.width: 1;
        radius:  2;
        anchors.fill: parent
        color: "lightsteelblue"
        border.color: "gray"

    }

    property alias text: input.text
    property alias input: input

    TextInput{
        clip: true
        id: input;
        focus: true
        autoScroll: true;
        anchors.fill: parent;
        anchors.margins: 4
        verticalAlignment: Text.AlignVCenter;
        selectByMouse:true;
    }
}

