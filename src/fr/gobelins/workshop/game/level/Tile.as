/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class Tile extends Sprite {

    private var _enabled:Boolean = true;

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

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set enabled(value:Boolean):void {
        _enabled = value;
        if(value == true) this.alpha = 1;
        else this.alpha = 0;
    }
}
}
