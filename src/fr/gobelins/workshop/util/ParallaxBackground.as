/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.util {
import fr.gobelins.workshop.game.IGameEntity;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    public class ParallaxBackground extends Sprite implements IGameEntity{

        private var _texture:Texture;
        private var _firstElement:Image;
        private var _speed:Number;
        private var _secondElement:Image;
        private var _tween:Tween;;

        public function ParallaxBackground(texture, speed) {
            super();

            _texture = texture;
            _speed = speed;

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            _firstElement = new Image(_texture);
            addChild(_firstElement);
            
            _secondElement = new Image(_texture);
            _secondElement.x = _firstElement.width-1;
            addChild(_secondElement);
            
            _animate(_speed);
        }

        public function _animate(speed:Number):void {
            _tween = new Tween(this, speed);
            _tween.repeatCount = int.MAX_VALUE;
            _tween.animate("x", -stage.stageWidth-1);
            play();
        }

        public function pause():void {
            Starling.juggler.remove(_tween)
        }

        public function play():void {
            Starling.juggler.add(_tween)
        }
    }
}
