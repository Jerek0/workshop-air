/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {

import fr.gobelins.workshop.events.GameEvent;

import starling.display.Sprite;
    import starling.events.EventDispatcher;

    public class GameManager extends EventDispatcher {

        private var _game:Game;

        public function GameManager(holder:Sprite) {
            super();

            _game = new Game();
            holder.addChild(_game);

            _game.addEventListener(GameEvent.GAME_OVER, pause);
        }

        public function pause():void {
           _game.pause();
        }

        public function play():void {
            _game.play();
        }
    }
}
