import QtQuick
import QtQuick.Layouts
import "../components"
Rectangle{

    color: "#122222"
    anchors.fill:  parent

    Grid {
        anchors.centerIn: parent
        spacing: 20
        rows: 2; columns: 4
        Image {
            id: sourceImage
            width: 80; height: width
            source: "qrc:/images/images/sun.png"
        }
    }
    ShaderEffect {
        id: effect4
        width: 80; height: width
        property variant source: sourceImage
        property real redChannel: 0.3
        NumberAnimation on redChannel {
            from: 0.0; to: 1.0; loops: Animation.Infinite; duration: 4000
        }

        fragmentShader: "red3.frag.qsb"
    }

}
