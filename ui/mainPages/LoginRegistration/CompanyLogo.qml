import QtQuick 2.15

Image {
    source: "icons/provodnikGreen.png"
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    anchors.topMargin: 10
    property int imageSize: Math.min(parent.width / 3, parent.height / 3)

    width: imageSize
    height: imageSize
}
