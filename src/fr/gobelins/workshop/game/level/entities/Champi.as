/**
 * Created by jerek0 on 03/01/2015.
 */
package fr.gobelins.workshop.game.level.entities {
import starling.display.Quad;
import starling.events.Event;

public class Champi extends AObstacleSol {
    public function Champi() {
        super();
    }

    protected override function _onAddedToStage(event:Event):void {
        var quad:Quad = new Quad(76,76,0xCC0000);
        quad.x=0;
        quad.y=0;
        addChild(quad);
    }
}
}