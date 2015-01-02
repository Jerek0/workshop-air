/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {

    import starling.display.Sprite;
    import starling.events.EventDispatcher;

    public class GameManager extends EventDispatcher {

        private var _game:Game;

        public function GameManager(holder:Sprite) {
            super();

            _game = new Game();
            holder.addChild(_game);
        }

        public function pause():void {
           _game.pause();
        }

        public function play():void {
            _game.play();
        }
    }
}
