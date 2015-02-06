/**
 * Created by Crazy Horse on 09.01.2015.
 */
package isoCore
{
public class IsoPoint
{
    private var _x:Number;
    private var _y:Number;
    private var _z:Number;
    private var onUpdated:Function;

    public function IsoPoint(x:Number = 0, y:Number = 0, z:Number = 0, onUpdated:Function=null)
    {
        _x = x;
        _y = y;
        _z = z;
    }

    public function get x():Number
    {
        return _x;
    }

    public function set x(value:Number):void
    {
        _x = value;
        onUpdated();
    }

    public function get y():Number
    {
        return _y;
    }

    public function set y(value:Number):void
    {
        _y = value;
        onUpdated();
    }

    public function get z():Number
    {
        return _z;
    }

    public function set z(value:Number):void
    {
        _z = value;
        onUpdated();
    }
}
}
