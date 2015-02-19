/**
 * Created by Crazy Horse on 09.01.2015.
 */
package com.dch.destroyit.isoCore
{
import flash.events.Event;
import flash.geom.Point;

import starling.display.Sprite;

public class IsoStarlingSprite extends Sprite implements IIsoDisplayObject
{
    private var _isoBounds:IsoBounds;

    public function IsoStarlingSprite(isoX:Number, isoY:Number, isoZ:Number, isoWidth:Number, isoLength:Number, isoHeight:Number)
    {
        _isoBounds = new IsoBounds(isoX, isoY, isoZ, isoWidth, isoLength, isoHeight);
        _isoBounds.addEventListener(IsoBounds.UPDATED, updateScreenPosition);
        setPivotToOrigin();
        updateScreenPosition();
    }

    protected function setPivotToOrigin():void
    {
        pivotX = IsoUtils.isoToScreen(isoBounds.size.length, 0, 0).x;
    }

    protected function updateScreenPosition(event:Event = null):void
    {
        var screenPos:Point = IsoUtils.isoToScreen(_isoBounds.origin.x, _isoBounds.origin.y, _isoBounds.origin.z);
        setPivotToOrigin();
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
