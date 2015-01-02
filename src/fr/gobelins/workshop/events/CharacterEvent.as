/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class CharacterEvent extends Event {

    public static const JUMP:String = "jump";
    public static const LANDED:String = "landed";

    public function CharacterEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
