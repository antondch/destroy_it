/**
 * Created by Crazy Horse on 10.01.2015.
 */
package isoCore
{
public class IsoTile extends IsoStarlingSpriteObject
{
    protected var _height:Number;
    protected var _color:uint;

    public function IsoTile(size:Number, color:uint, height:Number = 0)
    {
        super(size);
        _color = color;
        _height = height;
        draw();
    }


    protected function draw():void
    {
        graphics.clear();
        graphics.beginFill(_color);
        graphics.lineStyle(0, 0, 0.5);
        graphics.moveTo(-size, 0);
        graphics.lineTo(0, -size * 0.5);
        graphics.lineTo(size, 0);
        graphics.lineTo(0, size * 0.5);
        graphics.lineTo(-size, 0);
    }

    public function set isoHeight(value:Number):void
    {
        _height = value;
        draw();
    }

    public function get isoHeight():Number
    {
        return _height;
    }

    public function set color(value:uint):void
    {
        _color = value;
        draw();
    }

    public function get color():uint
    {
        return _color;
    }
}
}
