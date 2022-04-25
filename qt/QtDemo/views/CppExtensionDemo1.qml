import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../components"

import UserModule 1.0
Rectangle {
    anchors.top:parent.top
    anchors.left:parent.left
    anchors.topMargin: 10
    anchors.leftMargin: 10
    color: "#f6f5ec"
    Rectangle{
        id:header
        height: 100
        width: parent.width
        color: "#afb4db"

        Column{
            spacing: 10
            Row{
                spacing: 10
                height: 40
                Text{
                    text:"currentUser对象操作*****"
                }
                Text {
                    text: "currentUser.age"
                }
                Text {
                    text: userModel.currentUser.age
                }
                Text {
                    text: "currentUser.name"
                }
                Text {
                    text: userModel.currentUser.name
                }

                Button{
                    text: "修改对象属性"
                    onClicked: {

                        var age = Number(ageInput.text)
                        var name = nameInput.text
                        tempUser.age = age
                        tempUser.name = name
                        userModel.modifyCurrentUser(tempUser)
                    }
                }

                Text{
                    text:"修改name："
                }
                TextInput{
                    width: 100
                    text: "xx"
                    id:nameInput
                }
                Text{
                    text:"修改age："
                }
                TextInput{
                    width: 100
                    text: "55"
                    id:ageInput
                }

            }

            Row{
                spacing: 10
                height: 40

                Text{
                    text:"users集合操作*****"
                }
                Text {
                    text: "集合元素数量count："
                }
                Text {
                    text: userModel.count
                }
                Text{
                    text:"操作元素index："
                }
                TextInput{
                    id:userIndex
                    text:"2"
                }
                Text{
                    text:"操作元素name："
                }
                TextInput{
                    id:userName
                    text:"gg"
                }
                Text{
                    text:"操作元素age："
                }
                TextInput{
                    id:userAge
                    text:"23"
                }

                Button{
                    text: "添加user"
                    onClicked: {
                        var age = Number(userAge.text)
                        var name = userName.text
                        tempUser.age = age
                        tempUser.name = name
                        userModel.addUser(tempUser)
                        //userModel.users.append(tempUser)
                    }
                }


                Button{
                    text: "根据索引删除user"
                    onClicked: {

                        var index = Number(userIndex.text)
                        userModel.deleteUserByIndex(index)
                    }
                }


                Button{
                    text: "根据name删除user"
                    onClicked: {
                        var name = userName.text
                        userModel.deleteUsersByName(name)
                    }
                }
                Button{
                    text: "修改当前选中项"
                    onClicked: {
                        var age = Number(userAge.text)
                        var name = userName.text
                        tempUser.age = age
                        tempUser.name = name
                        userModel.modifyUserByIndex(m_listView.currentIndex ,tempUser)
                    }
                }
            }
        }
    }

    Rectangle{
        color: "#a1a3a6"
        anchors.top: header.bottom
        width: parent.width
        height: parent.height-100
        ListView {
            id:m_listView
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            spacing: 5
            model: userModel.users
            delegate: userDelegate

            flickableDirection: Flickable.VerticalFlick
            boundsBehavior: Flickable.StopAtBounds
            ScrollBar.vertical: ScrollBar {}
        }
    }


    Component {
        id: userDelegate

        Rectangle {
            property bool isHover: false
            id:rect
            width: ListView.view.width
            height: 40

            color:ListView.isCurrentItem?"green":isHover?"Gray":"lightGray"

            Row
            {
                anchors.fill: parent
                spacing: 5
                Text {
                    font.pixelSize: 10
                    text: name
                }
                Text {
                    font.pixelSize: 10
                    text: age
                }
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

    UserData{
        id:tempUser
        name:"xxx"
        age:99
    }
    UserModel{
        id:userModel

    }
}
