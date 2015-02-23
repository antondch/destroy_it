/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.destroyit.config
{
import com.dch.destroyit.assets.Color;

public class LandscapeConfig
{


    public static const CEIL_SIZE:int = 25;
    public static const BUILDINGS_COUNT:int = 1;


    public static const LANDSCAPE_WIDTH_IN_CEIL:int = 90;
    public static const LANDSCAPE_LENGTH_IN_CEIL:int = 90;

    public static const LANDSCAPE_START_POINT_X:Number = 300;
    public static const LANDSCAPE_START_POINT_Y:Number = 0;
    public static const LANDSCAPE_START_POINT_Z:Number = 300;

    public static const FREE_DISTANCE_IN_CEIL:int = 1;
    public static const BUILDING_SIDE_MAX_SIZE_IN_CEIL:int = 8;
    public static const BUILDING_SIDE_MIN_SIZE_IN_CEIL:int = 8;
    public static const BUILDING_SIDE_SIZE_DIFFERENCE_IN_CEIL:int = 2;

    public static const BUILDING_BORDER_COLOR:uint = Color.BLACK;
    public static const BUILDING_BORDER_THICKNESS:Number = 2.0;
    public static const BUILDING_INNER_COLOR:uint = Color.GREEN;
}
}
