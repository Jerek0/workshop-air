/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.events {
import starling.events.Event;

public class PagesEvent extends Event {

    public static const CHANGE:String = "change";

    public var idPage:String;

    public function PagesEvent(type:String, idPage:String, bubbles:Boolean = false, data:Object = null) {
        super(type, bubbles, data);
        this.idPage = idPage;
    }
}
}
