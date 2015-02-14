/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.landscape
{
public class Home
{
    private var _matrix:Vector.<Vector.<uint>>;
    private var _width:int;
    private var _length:int;
    private var _x:int;
    private var _z:int;

    public function Home(x:int, z:int, width:int, length:int):void
    {
        _x = x;
        _z = z;
        _width = width;
        _length = length;
        fillMatrix(width, length);
    }

    private function fillMatrix(width:int, length:int):void
    {
        _matrix = new Vector.<Vector.<uint>>(width, true);
        for (var i:int = 0; i < width; i++)
        {
            _matrix[i] = new Vector.<uint>(length, true);
        }
    }

    public function get width():int
    {
        return _width;
    }

    public function get length():int
    {
        return _length;
    }

    public function get x():int
    {
        return _x;
    }

    public function set x(value:int):void
    {
        _x = value;
    }

    public function get z():int
    {
        return _z;
    }

    public function set z(value:int):void
    {
        _z = value;
    }

    public function get matrix():Vector.<Vector.<uint>>
    {
        return _matrix;
    }
}
}
