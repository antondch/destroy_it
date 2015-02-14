/**
 * Created by Crazy Horse on 23.01.14.
 */
package com.dch.enums
{
import ru.dch.enums.*;

import avmplus.getQualifiedClassName;

import flash.utils.describeType;
import flash.utils.getDefinitionByName;

/**
 * This is abstract class for enumeration types, don't instantiate it.
 */
public class Enumeration
{
    private static var elements:Vector.<Enumeration> = new Vector.<Enumeration>();
    protected var _value:*;

    public function Enumeration()
    {
        testAbstract();
        var clazz: Class= Object(this).constructor;
        elements.push(this);
        var elementsLen:int =getElementsList(clazz).length;
        var constNum: int = XMLList(describeType(clazz)).constant.length();
        if(elementsLen>constNum)
        {
            throw new EnumError(EnumError.INITIALISATION_ERROR_MESSAGE+": "+clazz,EnumError.INITIALISATION_ERROR_CODE);
        }
    }

    private function testAbstract():void
    {
        var className : String = getQualifiedClassName(this);
        if (getDefinitionByName(className) == Enumeration)
        {
            throw new ArgumentError(
                    className + " Class can not be instantiated.");
        }
    }

    public static function getElementsList(enumerationClass:Class):Vector.<Enumeration>
    {
        return elements.filter(checkClass);
        function checkClass(value:Enumeration, index:int, array:Vector.<Enumeration>):Boolean
        {
            return value is (enumerationClass);
        }
    }

    //FIXME:  Values can be is not unique. Return type must be is Vector.<Element>
    public static function getElementByValue(value:*, enumClass:Class):Enumeration
    {
        var currentTypeElements:Vector.<Enumeration> = getElementsList(enumClass);
        var result:Enumeration = null;
        for each(var testingElement:Enumeration in currentTypeElements)
        {
            if(testingElement._value === value)
            {
                result = testingElement;
            }
        }
        return result;
    }
}
}
