/**
 * Created by Crazy Horse on 06.02.2015.
 */
package com.dch.mvc
{
import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;

public interface IViewController
{
    function showOnView(rootView:DisplayObjectContainer):DisplayObject;

    function removeView():void;
}
}
