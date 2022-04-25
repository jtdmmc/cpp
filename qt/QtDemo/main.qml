import QtQuick
import QtQuick.Layouts
import "components"

Window {
    width: 840
    height: 580
    visible: true
    title: qsTr("Hello World")

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
            header: "TabControlSDemo"
            control: "../views/TabControlSDemo.qml"
        }
        ListElement
        {
            header: "MvdDemo"
            control: "../views/MvdDemo.qml"
        }
        ListElement
        {
            header: "CppExtensionDemo1"
            control: "../views/CppExtensionDemo1.qml"
        }
        ListElement
        {
            header: "CppExtensionDemo2"
            control: "../views/CppExtensionDemo2.qml"
        }
        ListElement
        {
            header: "ShaderDemo"
            control: "../views/ShaderDemo.qml"
        }
        ListElement
        {
            header: "3DDemo"
            control: "../views/3DDemo.qml"
        }
    }
    TabControlD{
        items:model
        initItem: "../views/ComponentsDemo.qml"
    }
}
