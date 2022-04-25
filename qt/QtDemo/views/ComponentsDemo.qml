import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"
Rectangle{
    anchors.top:parent.top
    anchors.left:parent.left
    anchors.topMargin: 10
    anchors.leftMargin: 10
    color: "yellow"
    Column{
        anchors.topMargin: 10
        spacing: 5
        Row{
            spacing: 5
            Button{
                text:"button"
            }
            MyButton{
                text:"MyButton"
            }
        }

        Row{
            spacing: 5
            Text{
                id:txt
                focus: true
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        txt.forceActiveFocus();
                    }
                }
                text:activeFocus?"I have active focus":"I dont have active focus"
            }
            TextEdit {
                text: qsTr("TextEdit")
            }
            MyText{
                width: 100
                text: "xxx"
            }
            Label {
                text: "Hello world"
                font.pixelSize: 22
                font.italic: true
            }

        }
    }
}
