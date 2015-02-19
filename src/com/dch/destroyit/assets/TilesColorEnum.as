/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.assets
{
import com.dch.destroyit.enums.UintEnumeration;

public class TilesColorEnum extends UintEnumeration
{
    public static const GREEN:TilesColorEnum = new TilesColorEnum(Color.GREEN);
    public static const RED:TilesColorEnum = new TilesColorEnum(Color.RED);

    public function TilesColorEnum(value:uint):void
    {
        super(value);
    }
}
}
