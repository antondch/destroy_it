/**
 * Created by Crazy Horse on 06.02.2015.
 */
package config
{
import flash.geom.Point;

public class Config
{
    public static const TILE_SIZE:int = 50;
    public static const HOMES_COUNT:int = 100;
    public static const LANDSCAPE_WIDTH:int = TILE_SIZE*90;
    public static const LANDSCAPE_LENGTH:int = TILE_SIZE*90;

    public static const LANDSCAPE_START_POINT:Point = new Point(300, 300);

    public static const HOME_MAX_FACE_SIZE:int = 8;
    public static const HOME_MIN_FACE_SIZE:int = 2;
}
}
