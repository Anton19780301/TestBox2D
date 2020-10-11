//import Box2D 2.0
import Box2DStatic 2.0


/*
  This body places 32-pixel wide invisible static bodies around the screen,
  to avoid stuff getting out.
*/
Body {

    property int bodyWidth: 1000
    property int bodyHeight: 800
    property int bodyMeasure: 40

    world: physicsWorld

    Box {
        y: bodyHeight
        width: bodyWidth
        height: bodyMeasure
    }
    Box {
        y: -1 * bodyMeasure
        height: bodyMeasure
        width: bodyWidth
    }
    Box {
        x: -1 * bodyMeasure
        width: bodyMeasure
        height: bodyHeight
    }
    Box {
        x: bodyWidth
        width: bodyMeasure
        height: bodyHeight
    }
}
