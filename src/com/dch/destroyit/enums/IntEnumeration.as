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

    protected function get value():int
    {
        return _value;
    }

    protected function set value(value:int):void
    {
        _value = value;
    }
}
}
