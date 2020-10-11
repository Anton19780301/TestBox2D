import QtQuick 2.12
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Box2DStatic 2.0
import "shared"

Item {
    id: tileSlideId
    objectName: "TileSlide"
    property Body pressedBody: null

    property int imagePieceWidth: 0
    property int imagePieceHeight: 0
    property var xCoordinatesList
    property var yCoordinatesList
    property alias puzzlePieceModel: repeaterId.model
    property alias sourceImage: backgroundId.source

    width: parent.width
    height: parent.height
    visible: true

    MouseJoint {
        id: mouseJoint
        bodyA: anchor
        dampingRatio: 0.8
        maxForce: 100
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onPressed: {
            if (pressedBody != null) {
                mouseJoint.maxForce = pressedBody.getMass() * 500
                mouseJoint.target = Qt.point(mouseX, mouseY)
                mouseJoint.bodyB = pressedBody
                pressedBody.bodyType = Body.Dynamic
            }
        }

        onPositionChanged: {
            mouseJoint.target = Qt.point(mouseX, mouseY)
            if (pressedBody != null)
                pressedBody.bodyType = Body.Dynamic
        }

        onReleased: {
            if (pressedBody != null) {
                pressedBody.bodyType = Body.Static
                isPuzzleSolved()
            }
            mouseJoint.bodyB = null
            pressedBody = null
        }
        function isPuzzleSolved() {
            if (puzzlePieceModel === undefined)
                return
            xCoordinatesList = new Array
            yCoordinatesList = new Array
            for (var index = 0; index < puzzlePieceModel; ++index) {
                var itemAt = repeaterId.itemAt(index)
                xCoordinatesList[index] = itemAt.x
                yCoordinatesList[index] = itemAt.y
                // console.log("isPuzzleSolved  index=" + index + " x=" + itemAt.x + "  y=" + itemAt.y + " width=" + itemAt.height + " width=" + itemAt.height)
            }
            if (GameController.isPuzzleSolved(xCoordinatesList,
                                              yCoordinatesList)) {

                for (var i = 0; i < puzzlePieceModel; ++i) {
                    var item = repeaterId.itemAt(i)
                    item.opacity = 0.0
                    item.scale = 0.1
                    item.data[0].bodyType = Body.Dynamic
                    item.data[0].fixtures[0].density = 0
                    item.data[0].fixtures[0].restitution = 1.0
                    item.data[0].fixtures[0].friction = 0
                    item.data[0].fixtures[0].rotation = Math.random() * 360
                    item.data[0].fixtures[0].x += Math.random() * 10
                    item.data[0].fixtures[0].y += Math.random() * 10
                }
            }
        }
    }

    Image {
        id: backgroundId
        anchors.centerIn: parent
        //  source: "image://puzzleImage"
        opacity: .5
        sourceSize.width: if (GameController !== null)
                              GameController.imageWidth()
        sourceSize.height: if (GameController !== null)
                               GameController.imageHeight()
    }

    World {
        id: physicsWorld
    }

    RectangleBoxBody {
        height: 0
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    RectangleBoxBody {
        width: 0
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    RectangleBoxBody {
        height: 0
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }
    RectangleBoxBody {
        width: 0
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
    }
    Body {
        id: anchor
        world: physicsWorld
    }

    Repeater {
        id: repeaterId

        delegate: Rectangle {
            property alias itemImageSource: imageId.source
            id: rectangle
            x: windowWidth / 2 * Math.random()
            y: windowHeight / 2 * Math.random()
            width: imagePieceWidth
            height: imagePieceHeight
            smooth: true
            Image {
                id: imageId
                // source: "image://puzzleImage/" + index
                fillMode: Image.Pad
                anchors.fill: parent
                sourceSize.width: rectangle.width
                sourceSize.height: rectangle.height
            }

            Body {
                id: rectangleBodyId

                target: rectangle
                world: physicsWorld

                bodyType: Body.Dynamic
                Box {
                    id: boxBodyId
                    width: rectangle.width
                    height: rectangle.height
                    restitution: 0.5
                    friction: 0.55
                }
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    mouse.accepted = false
                    pressedBody = rectangleBodyId
                    pressedBody.bodyType = Body.Dynamic
                }
            }
            Behavior on scale {
                NumberAnimation {
                    duration: 3000
                    easing.type: Easing.InOutBack
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 3000
                }
            }
        }
    }

    Component.onCompleted: {
        GameController.loadNextImage()
        puzzlePieceModel = GameController.puzzlePieceCount()
        sourceImage = "image://puzzleImage"
        imagePieceWidth = GameController.imagePieceWidth()
        imagePieceHeight = GameController.imagePieceHeight()
    }

    Component.onDestruction: console.log(
                                 "Component.onDestruction  $$$$$$$$$$$$$$$$")

    Connections {
        target: GameController
        function onDisplayImage() {
            puzzlePieceModel = GameController.puzzlePieceCount()
            sourceImage = "image://puzzleImage"
            imagePieceWidth = GameController.imagePieceWidth()
            imagePieceHeight = GameController.imagePieceHeight()
            for (var index = 0; index < puzzlePieceModel; ++index) {
                var item = repeaterId.itemAt(index)
                item.itemImageSource = sourceImage + "/" + index
                item.opacity = 1.0
                item.scale = 1.0
            }
        }
    }
}
