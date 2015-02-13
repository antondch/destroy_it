/**
 * Created by Crazy Horse on 05.02.2015.
 */
package isoCore
{
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class IsoUtils
{
    private static const theta:Number = 30 * Math.PI / 180;
    private static const alpha:Number = 45 * Math.PI / 180;
    private static const sinTheta:Number = Math.sin(theta);
    private static const cosTheta:Number = Math.cos(theta);
    private static const sinAlpha:Number = Math.sin(alpha);
    private static const cosAlpha:Number = Math.cos(alpha);
    private static var rect:Sprite = new Sprite();

    public static function isoToScreen(xpp:Number, ypp:Number, zpp:Number):Point
    {
        var yp:Number = ypp;
        var xp:Number = xpp * cosAlpha + zpp * sinAlpha;
        var zp:Number = zpp * cosAlpha - xpp * sinAlpha;
        var x:Number = xp;
        var y:Number = yp * cosTheta - zp * sinTheta;
//        var z:Number = zp * cosTheta + yp * sinTheta;
        return new Point(x, y);
    }


    public static function getScreenBounds(xpp:Number, ypp:Number, zpp:Number, width:Number, length:Number, height:Number):Rectangle
    {
        /*FIXME: It's best way for developing, but must be profiled in optimizing stage.*/
        //In box ABCDEFGH:
//        var pointA:Point = isoToScreen(xpp, ypp, zpp);
        var pointB:Point = isoToScreen(xpp + width, ypp, zpp);
        var pointC:Point = isoToScreen(xpp + width, ypp, zpp - length);
        var pointD:Point = isoToScreen(xpp, ypp, zpp - length);
        var pointE:Point = isoToScreen(xpp, ypp + height, zpp);
        //****************
        var result:Rectangle = new Rectangle(pointD.x, pointE.y, pointB.x - pointD.x, pointC.y - pointE.y);
        return result;
    }

    public static function screenToIso(x:Number, y:Number):IsoPoint
    {
        var isoX:Number = y + x * 0.5;
        var isoY:Number = 0;
        var isoZ:Number = y - x * 0.5;
        return new IsoPoint(isoX, isoY, isoZ);
    }

    public static function drawTile(width:Number, length:Number, color:uint, borderThickness:Number, borderColor:uint):BitmapData
    {

        var pointA:Point = isoToScreen(0, 0, 0);
        var pointB:Point = isoToScreen(width, 0, 0);
        var pointC:Point = isoToScreen(width, 0, -length);
        var pointD:Point = isoToScreen(0, 0, -length);
        rect.graphics.clear();
        rect.graphics.beginFill(color);
        rect.graphics.lineStyle(0, 0, borderThickness);
        rect.graphics.moveTo(pointA.x, pointA.y);
        rect.graphics.lineTo(pointB.x, pointB.y);
        rect.graphics.lineTo(pointC.x, pointC.y);
        rect.graphics.lineTo(pointD.x, pointD.y);
        rect.graphics.lineTo(pointA.x, pointA.y);
        var bounds:Rectangle = rect.getBounds(rect);
        var matrix:Matrix = new Matrix();
        matrix.translate(-bounds.x, -bounds.y);
        var result:BitmapData = new BitmapData(rect.width, rect.height, true,0x000000);

        result.draw(rect, matrix);
        return result;
    }
}
}
