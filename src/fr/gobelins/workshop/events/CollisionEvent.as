/**
 * Created by jerek0 on 03/01/2015.
 */
package fr.gobelins.workshop.events {
    import fr.gobelins.workshop.game.level.Tile;

    import starling.events.Event;

    public class CollisionEvent extends Event {

        public static const COLLISION:String = "collision";

        public var tile:Tile;

        public function CollisionEvent(type:String, tile:Tile, bubbles:Boolean = false, data:Object = null) {
            super(type, bubbles, data);

            this.tile = tile;
        }
    }
}
