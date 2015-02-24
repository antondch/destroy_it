/**
 * Created by Crazy Horse on 14.02.2015.
 */
package com.dch.destroyit.config
{
public class CeilTypes
{
    public static const EMPTY:uint = 0;
    public static const EXPLODE_1X1:uint = 1;

    public static const SIZE_2X2_MASC:uint = 1<<31;
    public static const CEIL_AREA_MASC:uint = 1<<30;

    public static const EXPLODE_2X2:uint = 2+SIZE_2X2_MASC;
    public static const GARBAGE_1X1:uint = 3+SIZE_2X2_MASC;


}
}
