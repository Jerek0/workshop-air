/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {

    import starling.display.Sprite;
    import starling.events.EventDispatcher;

    public class GameManager extends EventDispatcher {

        public function GameManager(stage:Sprite) {
            super();

            var game = new Game();
            stage.addChildAt(game, 0);

        }
    }
}
