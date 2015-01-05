/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.character {
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
        private var _state:ICharacterState = new NormalState();
        private var _isJumping:Boolean = false;

        public function Character() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            _body = new MovieClip(App.assets.getTextureAtlas("RaptorNormal").getTextures("NormalRun"));
            _size = 1;
            addChild(_body);

            _hitbox = new Quad(76*1, 76*1, 0xFF0000);
            addChildAt(_hitbox, 0);
            _hitbox.x = 95;
            _hitbox.y = 25;
            _hitbox.alpha = 0;
        }

        public function animate():void {
            _tween = new Tween(_body, 0.3);
            _tween.animate("currentFrame", _body.numFrames-1);
            if(!_isJumping) _tween.repeatCount = int.MAX_VALUE;
        }

        public function set size(value:int):void {
            this.scaleX = value;
            this.scaleY = value;
            _size = value;
        }

        public function pause():void {
            Starling.juggler.remove(_tween);
        }

        public function play():void {
            Starling.juggler.add(_tween);
        }

        public function jump():void {
            // TODO Passer ça dans le state
            //if(this.y == Settings.ground) {
            if(_isJumping == false){
                _isJumping = true;
                _changeSkin("NormalUp");
            }

            this.dispatchEvent(new CharacterEvent(CharacterEvent.JUMP));
            addEventListener(CharacterEvent.FALLING, _onFalling);
            addEventListener(CharacterEvent.LANDED, _onLanding);
            //}
        }

        public function stopJump():void {
            _onFalling();
            this.dispatchEvent(new CharacterEvent(CharacterEvent.STOP_JUMP));
        }

        private function _onLanding(event:CharacterEvent):void {
            _isJumping = false;
            _changeSkin("NormalRun");
            removeEventListener(CharacterEvent.LANDED, _onLanding);
        }

        private function _onFalling(event:CharacterEvent = null):void {
            _changeSkin("NormalDown");
        }

        public function get hitbox():Quad {
            return _hitbox;
        }

        private function _changeSkin(skin:String):void {
            removeChild(_body);
            _body = new MovieClip(App.assets.getTextureAtlas("RaptorNormal").getTextures(skin));
            addChild(_body);
            pause();
            animate();
            play();
        }
    }
}
