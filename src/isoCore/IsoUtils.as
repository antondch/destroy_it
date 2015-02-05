/**
 * Created by Crazy Horse on 09.01.2015.
 */
package isoCore
{
import flash.geom.Point;

public class IsoUtils
{
    public static const Y_CALCULATED:Number = 1; //Math.cos(-Math.PI / 6) * Math.SQRT2;

    public static function isoToScreen(isoPoint:IsoPoint):Point
    {
        var screenX:Number = isoPoint.x - isoPoint.z;
        var screenY:Number = isoPoint.y * Y_CALCULATED + (isoPoint.x + isoPoint.z) * 0.5;
        return new Point(screenX, screenY);
    }

    public static function screenToIso(point:Point):IsoPoint
    {
        var isoX:Number = point.y + point.x * 0.5;
        var isoY:Number = 0;
        var isoZ:Number = point.y - point.x * 0.5;
        return new IsoPoint(isoX, isoY, isoZ);
    }
}
}
