import QtQuick 2.15

Rectangle {
    id: bottomBar
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height / 12
    property color mainAppColor: "#6fda9c"
    property color mainBackgroundColor: "#191919"
    property color mainTextColor: "white"
    color: mainBackgroundColor
//    gradient: Gradient {
//        GradientStop {
//            position: 0.00;
//            color: "#000000";
//        }
//        GradientStop {
//            position: 1.00;
//            color: "#ffffff";
//        }
//    }
}
