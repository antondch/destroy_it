/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.isoCore
{
import flash.events.Event;
import flash.events.EventDispatcher;

public class IsoBounds extends EventDispatcher
{
    private var _origin:IsoPoint;
    private var _size:Size;
    private var _isSilent:Boolean;
    public static const UPDATED:String = "updated";

    public function IsoBounds(x:Number, y:Number, z:Number, width:Number, length:Number, height:Number, isSilent:Boolean = false)
    {
        _origin = new IsoPoint(x, y, z, tellUpdated);
        _size = new Size(width, length, height, tellUpdated);
    }

    private function tellUpdated():void
    {
        if (!_isSilent)
        {
            dispatchEvent(new Event(UPDATED));
        }
    }

    public function get origin():IsoPoint
    {
        return _origin;
    }

    public function get size():Size
    {
        return _size;
    }

    public function get isSilent():Boolean
    {
        return _isSilent;
    }

    public function set isSilent(value:Boolean):void
    {
        _isSilent = value;
    }
}
}
