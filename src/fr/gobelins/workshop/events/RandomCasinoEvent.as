/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class RandomCasinoEvent extends Event {

    public static const WINNER:String = "winner";

    public var winner:int;

    public function RandomCasinoEvent(type:String, winner:int, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);

        this.winner = winner;
    }
}
}
