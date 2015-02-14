/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.destroyit.enums
{
public class UintEnumeration extends Enumeration
{
    public function UintEnumeration(value:uint)
    {
        this.value = value;
    }

    public function get value():uint
    {
        return _value;
    }

    public function set value(uint:*):void
    {
        _value = value;
    }
}
}
