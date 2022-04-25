import QtQuick

FocusScope
{
    id:item_Button
    width: close_Text.contentWidth+30
    height: 30
    state: "nomal"

    property color nomalColor  : "#777777"
    property color hoverColor  : "red"
    property color pressColor  : "blue"
    property color borderColor  : "transparent"	//transparent:透明
    property real borderWidth  : 2

    property alias backColor  : rect.color
    property alias text  : close_Text.text
    Rectangle{
        id:rect
        anchors.fill: parent
        color: nomalColor
        border.color:  Qt.lighter(color)
        border.width: borderWidth
        radius: 2
    }
    Text {
        id: close_Text
        focus: true
        anchors.centerIn: parent
        text: qsTr("X")
    }
    MouseArea
    {
        id:close_MouseArea
        hoverEnabled: true

        anchors.fill: parent
        onClicked: {
            console.log("MyButton is pressed")
            close_Text.forceActiveFocus()
        }
        onPressed: {
            item_Button.state="press"

        }
        onReleased: (mouse)=>{

                        if(containsMouse)
                        item_Button.state="hover"
                        else
                        item_Button.state="nomal"

                    }
        onEntered: item_Button.state="hover"
        onExited: item_Button.state="nomal"
    }

    states: [
        State
        {
            name: "nomal"
            PropertyChanges
            {
                target: item_Button
                backColor:nomalColor
            }
        },
        State
        {
            name: "hover"
            PropertyChanges
            {
                target: item_Button
                backColor:hoverColor
            }
        },
        State
        {
            name: "press"
            PropertyChanges
            {
                target: item_Button
                backColor:pressColor
            }
        }
    ]

    transitions:[
        Transition
        {
            from: "nomal"
            to: "hover"

            ColorAnimation
            {
                target: item_Button
                duration: 100
            }
        },
        Transition
        {
            from: "hover"
            to: "press"

            ColorAnimation
            {
                target: item_Button
                duration: 100
            }
        },
        Transition
        {
            from: "press"
            to: "nomal"

            ColorAnimation
            {
                target: item_Button
                duration: 100
            }
        }
    ]

}
