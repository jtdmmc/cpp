import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../components"
Rectangle {
    anchors.top:parent.top
    anchors.left:parent.left
    anchors.topMargin: 10
    anchors.leftMargin: 10
    color: "#f6f5ec"


    Row{
        id:row
        height: 40
        spacing: 5
        MyText{
            id:txtName
        }
        MyText{
            id:txtAge
        }
        MyText{
            id:txtScore
        }
        Button{
            text: "add"
            onClicked: {

                var name = txtName.text
                var age = Number(txtAge.text)
                var score = Number(txtScore.text)

                theModel.append({"name": name, "age":age,"score":score})

            }
        }
        Button{
            text: "delete"
            onClicked: {
                if(m_listView.currentIndex>0)
                    theModel.remove(m_listView.currentItem)

            }
        }
        Button{
            text: "modify"
            onClicked: {
                if(m_listView.currentIndex>0){
                    var name = txtName.text
                    var age = Number(txtAge.text)
                    var score = Number(txtScore.text)
                    theModel.setProperty(m_listView.currentIndex,"name",name)
                    theModel.setProperty(m_listView.currentIndex,"age",age)
                    theModel.setProperty(m_listView.currentIndex,"score",score)
                }
            }
        }
    }

    Rectangle{
        anchors.top: row.bottom
        anchors.left: parent.left
        width: parent.width
        height: parent.height-50
        color: "#a1a3a6"
        ListView {
            id:m_listView
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            spacing: 5
            model: theModel
            delegate: numberDelegate

            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}

        }

    }

    ListModel {
        id: theModel

        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
        ListElement {name:"wxp";age:123; score: 123 }
    }
    Component {
        id: numberDelegate

        Rectangle {
            property bool isHover: false
            id:rect
            width: ListView.view.width
            height: 40

            color:ListView.isCurrentItem?"green":isHover?"Gray":"lightGray"

            Text {
                anchors.centerIn: parent

                font.pixelSize: 10

                text: "index:"+index+";name:"+name+";age:"+age+";score:"+score
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: isHover=true
                onExited: isHover=false
                onClicked: m_listView.currentIndex = index  //实现item切换

            }
        }
    }
}
