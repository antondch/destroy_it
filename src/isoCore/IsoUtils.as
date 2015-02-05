/**
 * Created by Crazy Horse on 09.01.2015.
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

    private static const theta = 30*Math.PI/180;

    private static const alpha =45*Math.PI/180;

    private static const sinTheta =Math.sin(theta);

    private static const cosTheta =Math.cos(theta);

    private static const sinAlpha =Math.sin(alpha);

    private static const cosAlpha =Math.cos(alpha);

    private static var rect:Sprite = new Sprite();

    public static function isoToScreen(xpp:Number,zpp:Number,ypp:Number):Point
    {
//        var screenX:Number = x - z;
//        var screenY:Number = y * Y_CALCULATED + (x + z) * 0.5;
//        return new Point(screenX, screenY);


        var yp =ypp;

         var xp =xpp*cosAlpha+zpp*sinAlpha;

         var zp =zpp*cosAlpha-xpp*sinAlpha;

         var x =xp;

         var y =yp*cosTheta-zp*sinTheta;

        var z =zp*cosTheta+yp*sinTheta;

         return new Point(x,y);

    }

    public static function screenToIso(x:Number,y:Number):IsoPoint
    {
        var isoX:Number = y + x * 0.5;
        var isoY:Number = 0;
        var isoZ:Number = y - x * 0.5;
        return new IsoPoint(isoX, isoY, isoZ);
    }

    public static function drawTile(width:int, height:int, color:uint, borderThickness:Number, borderColor:uint):BitmapData
    {
        var pointA:Point = isoToScreen(0,0,0);
        var pointB:Point = isoToScreen(width,0,0);
        var pointC:Point = isoToScreen(width,-height,0);
        var pointD:Point = isoToScreen(0,-height,0);
        rect.graphics.clear();
        rect.graphics.beginFill(color);
        rect.graphics.lineStyle(0, 0, borderThickness);
        rect.graphics.moveTo(pointA.x, pointA.y);
        rect.graphics.lineTo(pointB.x,pointB.y);
        rect.graphics.lineTo(pointC.x,pointC.y);
        rect.graphics.lineTo(pointD.x,pointD.y);
        rect.graphics.lineTo(pointA.x,pointA.y);
        var bounds:Rectangle = rect.getBounds(rect);
        var matrix:Matrix = new Matrix();
        matrix.translate(-bounds.x, -bounds.y);
        var result:BitmapData = new BitmapData(rect.width,rect.height);
        result.draw(rect,matrix);
        return result;
    }
}
}
