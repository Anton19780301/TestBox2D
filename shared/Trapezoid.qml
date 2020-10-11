import QtQuick 2.0
import Box2DStatic 2.0

PhysicsItem {
    property alias imageSource: imageId.source

    world: physicsWorld
    sleepingAllowed: false
    bodyType: Body.Dynamic

    width: 100
    height: 80
    Rectangle {
        anchors.fill: parent
        // color: randomColor()
        Image {
            id: imageId
            fillMode: Image.Tile
            anchors.fill: parent
            sourceSize.width: 100
            sourceSize.height: 80
        }
    }
    fixtures: Polygon {

        //        density: 1
        //        friction: 0.3
        //        restitution: 0.5
        vertices: [Qt.point(0, 0), Qt.point(0,
                                            80), Qt.point(100,
                                                          80), Qt.point(100, 0)]
    }

    function randomColor() {
        return Qt.rgba(Math.random(), Math.random(), 1, 1)
    }
}
