/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.destroyit.enums
{
public class IntEnumeration extends Enumeration
{
    public function IntEnumeration(value:int)
    {
        this.value = value;
    }

    public function get value():int
    {
        return _value;
    }

    public function set value(value:int):void
    {
        _value = value;
    }
}
}
