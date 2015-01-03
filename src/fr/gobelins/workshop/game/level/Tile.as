/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class Tile extends Sprite {

    public function Tile() {
        super();

        addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    protected function _onAddedToStage(event:Event):void {
        var quad:Quad = new Quad(76,76,0xFF0000);
        quad.x=0;
        quad.y=0;
        addChild(quad);
    }
}
}
