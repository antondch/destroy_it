/**
 * Created by Crazy Horse on 05.02.2015.
 */
package com.dch.destroyit.isoCore
{
import flash.geom.Point;
import flash.geom.Rectangle;

public class IsoUtils
{
//    private static const theta:Number = 30 * Math.PI / 180;
//    private static const alpha:Number = 45 * Math.PI / 180;
//    private static const sinTheta:Number = Math.sin(theta);
//    private static const cosTheta:Number = Math.cos(theta);
//    private static const sinAlpha:Number = Math.sin(alpha);
//    private static const cosAlpha:Number = Math.cos(alpha);
//
//
//    public static function isoToScreen(xpp:Number, ypp:Number, zpp:Number):Point
//    {
//        var yp:Number = ypp;
//        var xp:Number = xpp * cosAlpha + zpp * sinAlpha;
//        var zp:Number = zpp * cosAlpha - xpp * sinAlpha;
//        var x:Number = xp;
//        var y:Number = yp * cosTheta - zp * sinTheta;
//        var z:Number = zp * cosTheta + yp * sinTheta;
//        return new Point(x, y);
//    }
    private static const RATIO:Number = 2;
    public static const axialProjection:Number = 1// Math.cos(Math.atan(0.5));

    private static var cosTheta:Number = Math.cos(30 * Math.PI / 180);
    private static var sinTheta:Number = Math.sin(30 * Math.PI / 180);

    public static function isoToScreen(xpp:Number, ypp:Number, zpp:Number):Point
    {
        var screenX:Number = (xpp - zpp) * cosTheta;
        var screenY:Number =  (xpp + zpp) * sinTheta - ypp;
        return new Point(screenX, screenY);
    }

    public static function screenToIso(x:Number, y:Number):IsoPoint
    {
        var isoX:Number = x / (2 * cosTheta) + y;
        var isoZ:Number = y - x / (2 * cosTheta);
        var isoY:Number = 0;
        return new IsoPoint(isoX, isoY, isoZ);
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




}
}
