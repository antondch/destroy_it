/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.destroyit.enums
{
public class StringEnumeration extends Enumeration
{
    public function StringEnumeration(value:String)
    {
        this.value = value;
    }

    public function get value():String
    {
        return _value;
    }

    public function set value(value:String):void
    {
        _value = value;
    }
}
}
