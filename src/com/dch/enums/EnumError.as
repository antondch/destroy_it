/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.enums
{
public class EnumError extends Error
{
    public static const INITIALISATION_ERROR_MESSAGE:String = "Initialisation error, value must be init only as static const in value type class";
    public static const INITIALISATION_ERROR_CODE:int = 0;

    public function EnumError(message:* = "", id:* = 0)
    {
        super(message, id);
    }
}
}
