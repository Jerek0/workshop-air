/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level.entities {
import fr.gobelins.workshop.game.level.Tile;

import starling.display.Quad;

import starling.events.Event;

public class Point extends Tile {

    private var _enabled:Boolean = true;

    public function Point() {
        super();
    }

    protected override function _onAddedToStage(event:Event):void {
        var quad:Quad = new Quad(76,76,0xFFFF00);
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
