/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class TutorialEvent extends Event {

    public static const TUTORIAL_SKIPPED:String = "tutorial_skipped";

    public function TutorialEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
