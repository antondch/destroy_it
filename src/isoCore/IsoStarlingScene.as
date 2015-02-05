/**
 * Created by Crazy Horse on 10.01.2015.
 */
package isoCore
{
import starling.display.Sprite;

/**
 * Iso scene. For add object to scene, use add2Scene
 */
public class IsoStarlingScene extends Sprite
{
    private var _objects:Array;
    private var _scene:Sprite;

    public function IsoStarlingScene()
    {
        _scene = new Sprite();
        addChild(_scene);

        _objects = [];
    }

    public function add2Scene(child:IsoStarlingSpriteObject):IsoStarlingSpriteObject
    {
        _scene.addChild(child);
        _objects.push(child);
        sort();
        return child;
    }

    public function sort():void
    {
        _objects.sortOn("depth", Array.NUMERIC);
        for (var i:int = 0; i < _objects.length; i++)
        {
            _scene.setChildIndex(_objects[i], i);
        }
    }

    public function get objects():Array
    {
        return _objects;
    }
}
}
