import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#f6f5ec"
    TabBar {
        height: 40
        id: headertabBar;
        currentIndex:swipeView.currentIndex
        TabButton {

            text: qsTr("header one");
        }
        TabButton {
            text: qsTr("header two")
        }
        TabButton {
            text: qsTr("header three")
        }
    }
    SwipeView {
        id: swipeView
        anchors.top: headertabBar.bottom
        anchors.left: parent.left
        height: parent.height-40
        width: parent.width
        currentIndex: headertabBar.currentIndex

        Rectangle {
            id: firstPage
            color: "red"
            MyText{
                anchors.centerIn: parent
                width: 100
                text: "xxx"
            }
        }
        Rectangle {
            id: secondPage
            color: "yellow"
            MyText{
                anchors.centerIn: parent
                width: 100
                text: "xxx"
            }
        }
        Rectangle {
            id: thirdPage
            color: "blue"
            MyText{
                anchors.centerIn: parent
                width: 100
                text: "xxx"
            }
        }
    }
}
