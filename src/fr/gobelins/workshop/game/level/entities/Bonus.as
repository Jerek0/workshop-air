/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level.entities {
    import fr.gobelins.workshop.game.level.Tile;

    import starling.display.Quad;
    import starling.events.Event;

    public class Bonus extends Tile {
        public function Bonus() {
            super();
        }

        protected override function _onAddedToStage(event:Event):void {
            var quad:Quad = new Quad(76,76,0xCC00CC);
            quad.x=0;
            quad.y=0;
            addChild(quad);
        }
    }
}
