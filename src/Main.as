/**
 * Created by Crazy Horse on 04.02.2015.
 */
package
{

import flash.display.Sprite;

import starling.core.Starling;

[SWF(width = 1000,height=1000,frameRate=60)]
public class Main extends Sprite
{
    private var starling:Starling;

    public function Main():void
    {
        startStarling();
    }

    private function startStarling():void
    {
        starling = new Starling(Game, stage);
        starling.start();
    }
}
}
