/**
 * Created by jerek0 on 03/01/2015.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class GameEvent extends Event {

    public static const COMPLETE:String = "complete";
    public static const GAME_OVER:String = "game_over";
    public static const POINT:String = "point";
    public static const BONUS:String = "bonus";

    public function GameEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
