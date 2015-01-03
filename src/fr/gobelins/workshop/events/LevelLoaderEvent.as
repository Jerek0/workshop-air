/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class LevelLoaderEvent extends Event {

    public static const LEVEL_LOADED:String = "level_loaded";

    public var level:Object;

    public function LevelLoaderEvent(type:String, level:Object, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
        this.level = level;
    }
}
}
