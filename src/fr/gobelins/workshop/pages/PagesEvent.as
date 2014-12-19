/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
import starling.events.Event;

public class PagesEvent extends Event {

    public static const HOME_TO_PLAY = "home_to_play";
    public static const HIGHSCORES_TO_HOME:String = "highscores_to_home";
    public static const HOME_TO_HIGHSCORES:String = "home_to_highscores";
    public static const GAME_TO_HIGHSCORES:String = "game_to_highscores";

    public function PagesEvent(type:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
    }
}
}
