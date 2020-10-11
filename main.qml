import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

Window {
    id: screenId

    readonly property bool isMobileDevice: Qt.platform.os === "android"
                                           || Qt.platform.os === "ios"
    property int windowHeight: isMobileDevice ? Screen.desktopAvailableHeight : Screen.desktopAvailableHeight * 0.9
    property int windowWidth: isMobileDevice ? Screen.width : Screen.width * 0.75

    onWindowWidthChanged: GameController.setWindowDimenions(windowWidth,
                                                            windowHeight)
    onWindowHeightChanged: GameController.setWindowDimenions(windowWidth,
                                                             windowHeight)
    visible: true
    width: windowWidth
    height: windowHeight

    Rectangle {
        width: parent.width
        height: parent.height
        color: "darkcyan"
    }

    Column {
        spacing: 50
        Button {
            id: buttonId
            z: 10
            text: "New Image"
            padding: 20
            onClicked: {
                console.log("onClicked  &&&&&&&&&&&&&&")
                loaderId.sourceComponent = undefined
                GameController.loadNextImage()
                loaderId.sourceComponent = componentId
            }
        }
    }
    Loader {
        id: loaderId
        sourceComponent: componentId
    }

    Component {
        id: componentId
        TileSlide {
            z: 10
            x: 50
            y: 50
            width: windowWidth - 50
            height: windowHeight - 50
        }
    }
}
