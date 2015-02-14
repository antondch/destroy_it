/**
 * Created by Crazy Horse on 09.01.2015.
 */
package com.dch.isoCore
{
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import starling.display.Quad;

public class IsoStarlingQuad extends Quad implements IIsoDisplayObject
{
    private var _isoBounds:IsoBounds;

    public function IsoStarlingQuad(color:uint, premultipliedAlpha:Number, isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number, isoHeight:Number)
    {
        _isoBounds = new IsoBounds(isoX, isoY, isoZ, isoWidth, isoLength, isoHeight);
        _isoBounds.addEventListener(IsoBounds.UPDATED, updateScreenPosition);
        var screenBounds:Rectangle = IsoUtils.getScreenBounds(isoX, isoY, isoZ, isoWidth, isoLength, isoHeight);
        super(screenBounds.width, screenBounds.height, color, premultipliedAlpha);
        updateScreenPosition();
    }

    protected function updateScreenPosition(event:Event = null):void
    {
        var screenPos:Point = IsoUtils.isoToScreen(_isoBounds.origin.x, _isoBounds.origin.y, _isoBounds.origin.z);
        super.x = screenPos.x;
        super.y = screenPos.y;
    }

    public function move(isoX:Number, isoY:Number, isoZ:Number):void
    {
        isoBounds.isSilent = true;
        isoBounds.origin.x = isoX;
        isoBounds.origin.y = isoY;
        isoBounds.origin.z = isoZ;
        isoBounds.isSilent = false;
        updateScreenPosition();
    }

    public function get isoBounds():IsoBounds
    {
        return _isoBounds;
    }
}
}
