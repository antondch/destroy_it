/**
 * Created by Crazy Horse on 13.02.2015.
 */
package isoCore
{
public interface IIsoDisplayObject
{
    function move(isoX:Number, isoY:Number, isoZ:Number):void;

    function get isoBounds():IsoBounds;
}
}
