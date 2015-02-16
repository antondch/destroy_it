/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.enums.UintEnumeration;

public class TilesColorEnum extends UintEnumeration
{
    public static const GREEN:TilesColorEnum = new TilesColorEnum(0x5B751A);
    public static const RED:TilesColorEnum = new TilesColorEnum(0x852C2C);

    public function TilesColorEnum(value:uint):void
    {
        super(value);
    }
}
}
