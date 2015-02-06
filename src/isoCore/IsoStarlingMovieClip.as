/**
 * Created by Crazy Horse on 09.01.2015.
 */
package isoCore
{
import flash.events.Event;
import flash.geom.Point;

import starling.display.MovieClip;
import starling.textures.Texture;

public class IsoStarlingMovieClip extends MovieClip
{
    protected var _isoBounds:IsoBounds;

    public function IsoStarlingMovieClip(textures:Vector.<Texture>, fps:int, isoX:Number = 0, isoY:Number = 0, isoZ:Number = 0, isoWidth:Number = 0, isoLength:Number = 0, isoHeight:Number = 0)
    {
        super(textures, fps);
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

//    public function get depth():Number
//    {
//        return (_isoPosition.x + _isoPosition.z) * .866 - _isoPosition.y * .707;
//    }

    public function get isoBounds():IsoBounds
    {
        return _isoBounds;
    }
}
}