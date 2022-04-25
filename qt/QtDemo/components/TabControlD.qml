import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {

    property alias items: repeater.model
    property string initItem: "../views/ComponentsDemo.qml"

    id: root
    anchors.fill: parent
    Rectangle{
        id:rect_header
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width
        height: 40
        color:"red"
        TabBar{
            anchors.fill: parent
            spacing:5
            Repeater{
                id:repeater
                height: parent.height
                model: model
                TabButton {
                    id: button
                    text: "header: "+header
                    onClicked: {
                        loader.source = control
                    }
                }
            }
        }
    }
    Rectangle{
        anchors.top: rect_header.bottom
        anchors.left: parent.left
        anchors.topMargin:10
        height: parent.height-50
        color:"green"
        width: parent.width
        Loader {
            id: loader
            anchors.fill: parent
            source:initItem
            asynchronous: false // 异步加载，默认false
        }
    }

    ListModel
    {
        id: model

        ListElement
        {
            header: "ComponentsDemo"
            control: "../views/ComponentsDemo.qml"
        }
        ListElement
        {
            header: "ComponentsDemo"
            control: "../views/ComponentsDemo.qml"
        }
    }

    function addItem(header, control)
    {
        items.append({ "header":header, "control":control })
    }
}
