/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.enums.StringEnumeration;

public class TileTypesEnum extends StringEnumeration
{
    public static const CLEAR_TYLE:TileTypesEnum = new TileTypesEnum("clear_tile");

    public function TileTypesEnum(value:String):void
    {
        super(value);
    }
}
}
