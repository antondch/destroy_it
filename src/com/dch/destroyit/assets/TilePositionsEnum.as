/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.enums.StringEnumeration;

public class TilePositionsEnum extends StringEnumeration
{
    public static const INNER:TilePositionsEnum = new TilePositionsEnum("inner");
    public static const TOP:TilePositionsEnum = new TilePositionsEnum("top");
    public static const BOTTOM:TilePositionsEnum = new TilePositionsEnum("bottom");
    public static const LEFT:TilePositionsEnum = new TilePositionsEnum("left");
    public static const RIGHT:TilePositionsEnum = new TilePositionsEnum("right");
    public static const TOP_LEFT:TilePositionsEnum = new TilePositionsEnum("top_left");
    public static const TOP_RIGHT:TilePositionsEnum = new TilePositionsEnum("top_right");
    public static const BOTTOM_LEFT:TilePositionsEnum = new TilePositionsEnum("bottom_left");
    public static const BOTTOM_RIGHT:TilePositionsEnum = new TilePositionsEnum("bottom_right");

    public function TilePositionsEnum(value:String):void
    {
        super(value);
    }
}
}
