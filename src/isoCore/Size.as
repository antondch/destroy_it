/**
 * Created by Crazy Horse on 06.02.2015.
 */
package isoCore
{
public class Size
{
    private var _width:Number;
    private var _height:Number;
    private var _length:Number;
    private var _onUpdated:Function;

    public function Size(width:Number,length:Number,height:Number, onUpdated:Function=null)
    {
        _width = width;
        _length = length;
        _height = height;
    }

    public function get width():Number
    {
        return _width;
    }

    public function set width(value:Number):void
    {
        _width = value;
        _onUpdated();
    }

    public function get height():Number
    {
        return _height;
    }

    public function set height(value:Number):void
    {
        _height = value;
        _onUpdated();
    }

    public function get length():Number
    {
        return _length;
    }

    public function set length(value:Number):void
    {
        _length = value;
        _onUpdated();
    }
}
}
