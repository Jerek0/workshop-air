/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.util {
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    public class ParallaxBackground extends Sprite {

        private var _texture:Texture;
        private var _firstElement:Image;
        private var _speed:Number;
        private var _secondElement:Image;

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

        private function _animate(speed:Number):void {
            var tw : Tween = new Tween(this, speed);
            tw.repeatCount = int.MAX_VALUE;
            tw.animate("x", -stage.stageWidth-1);
            tw.onRepeat = _onRepeat;
            Starling.juggler.add(tw);
        }

        private function _onRepeat():void {
            this.x = -1;
        }
    }
}
