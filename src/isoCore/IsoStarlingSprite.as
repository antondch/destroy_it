/**
 * Created by Crazy Horse on 09.01.2015.
 */
package isoCore
{
import flash.events.Event;
import flash.geom.Point;

import starling.display.Sprite;

public class IsoStarlingSprite extends Sprite
{
    private var _isoBounds:IsoBounds;

    public function IsoStarlingSprite(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number, isoHeight:Number)
    {
        _isoBounds = new IsoBounds(isoX, isoY, isoZ, isoWidth, isoLength, isoHeight);
        _isoBounds.addEventListener(IsoBounds.UPDATED, updateScreenPosition);
        updateScreenPosition();
    }

    protected function updateScreenPosition(event:Event = null):void
    {
        var screenPos:Point = IsoUtils.isoToScreen(_isoBounds.origin.x, _isoBounds.origin.y, _isoBounds.origin.z);
        super.x = screenPos.x;
        super.y = screenPos.y;
    }

    public function get depth():Number
    {
        return (isoBounds.origin.x + isoBounds.origin.z) * .866 - isoBounds.origin.y * .707;
    }

    public function get isoBounds():IsoBounds
    {
        return _isoBounds;
    }
}
}
