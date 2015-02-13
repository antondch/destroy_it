/**
 * Created by Crazy Horse on 4.01.2015.
 */
package isoCore
{
import flash.events.Event;
import flash.geom.Point;

import starling.display.Sprite;

/**
 * Iso scene. For add object to scene, use add2Scene
 */
public class IsoStarlingScene extends Sprite //implements IIsoDisplayObject
{
    private var _isoBounds:IsoBounds;
    private var homes:Array = [];

    public function IsoStarlingScene(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number)
    {
        _isoBounds = new IsoBounds(isoX, isoY, isoZ, isoWidth, isoLength, 0);
//        _isoBounds.addEventListener(IsoBounds.UPDATED, updateScreenPosition);
//        updateScreenPosition();

    }

//    protected function updateScreenPosition(event:Event = null):void
//    {
//        var screenPos:Point = IsoUtils.isoToScreen(_isoBounds.origin.x, _isoBounds.origin.y, _isoBounds.origin.z);
//        super.x = screenPos.x;
//        super.y = screenPos.y;
//    }

//    public function move(isoX:Number, isoY:Number, isoZ:Number):void
//    {
//        isoBounds.isSilent = true;
//        isoBounds.origin.x = isoX;
//        isoBounds.origin.y = isoY;
//        isoBounds.origin.z = isoZ;
//        isoBounds.isSilent = false;
////        updateScreenPosition();
//    }

    public function add2Scene(child:IsoStarlingSprite):IsoStarlingSprite
    {
        addChild(child);
        homes.push(child);
        return child;
    }

    public function get isoBounds():IsoBounds
    {
        return _isoBounds;
    }
}
}
