/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.enums
{
public class StringEnumeration extends Enumeration
{
    public function StringEnumeration(value:String)
    {
        this.value = value;
    }

    protected function get value():String
    {
        return _value;
    }

    protected function set value(value:String):void
    {
        _value = value;
    }
}
}
