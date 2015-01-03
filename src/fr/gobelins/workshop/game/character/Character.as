/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.character {
import flash.geom.Rectangle;

import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.events.CharacterEvent;
    import fr.gobelins.workshop.game.IGameEntity;

    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
    import starling.events.Event;

    public class Character extends Sprite implements IGameEntity {
        private var _body:MovieClip;
        private var _size:int;
        private var _tween:Tween;

        private var _hitbox:Quad;

        public function Character() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            _body = new MovieClip(App.assets.getTextureAtlas("dino").getTextures("Dinosaure"));
            _size = 1;

            var scope = this;
            _body.addEventListener(Event.ADDED_TO_STAGE, function(event:Event) {
                _hitbox = new Quad(76*1, 76*1, 0xFF0000);
                scope.addChildAt(_hitbox, 0);
                _hitbox.x = 95;
                _hitbox.y = 25;
                _hitbox.alpha = 0.2;
            });

            addChild(_body);
        }

        public function animate():void {
            _tween = new Tween(_body, 0.3);
            _tween.animate("currentFrame", _body.numFrames-1);
            _tween.repeatCount = int.MAX_VALUE;
        }

        public function set size(value:int):void {
            this.scaleX = value;
            this.scaleY = value;
            _size = value;
        }

        public function pause():void {
            Starling.juggler.remove(_tween)
        }

        public function play():void {
            Starling.juggler.add(_tween)
        }

        public function jump(deltaTime:Number):void {
            this.dispatchEvent(new CharacterEvent(CharacterEvent.JUMP, deltaTime));
            addEventListener(CharacterEvent.LANDED, _onLanding);
            trace("jump for " + deltaTime);
        }

        private function _onLanding(event:CharacterEvent):void {
            trace("landing");
            removeEventListener(CharacterEvent.LANDED, _onLanding);
        }

        public function get hitbox():Quad {
            return _hitbox;
        }
    }
}
