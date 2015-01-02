/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class Tile extends Sprite {
    private var _id:int;

    public function Tile(id:int) {
        super();

        _id = id;

        addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        var text:TextField = new TextField(50,50, ""+_id);
        this.addChild(text);
    }
}
}
