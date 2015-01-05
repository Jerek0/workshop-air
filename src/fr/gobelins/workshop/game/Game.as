/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.CollisionEvent;
import fr.gobelins.workshop.events.GameEvent;
    import fr.gobelins.workshop.events.LevelLoaderEvent;
import fr.gobelins.workshop.events.RandomCasinoEvent;
import fr.gobelins.workshop.game.character.Character;
    import fr.gobelins.workshop.game.level.LevelLoader;
    import fr.gobelins.workshop.game.level.Map;
import fr.gobelins.workshop.game.level.entities.AObstacle;
import fr.gobelins.workshop.game.level.entities.Bonus;
import fr.gobelins.workshop.game.level.entities.Point;
import fr.gobelins.workshop.util.ParallaxBackground;
import fr.gobelins.workshop.util.Popup;
import fr.gobelins.workshop.util.ProgressBar;
import fr.gobelins.workshop.util.RandomCasino;

import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;

    public class Game extends Sprite implements IGameEntity, IAnimatable{

        private var _scene:Vector.<ParallaxBackground>;
        private var _character:Character;
        private var _characterGravity:GravityManager;
        private var _map:Map;

        private var _score:int = 0;
        private var _scoreView:TextField;

        private var _touchBegin:Number;
        private var _popup:Popup;

        public function Game() {
            super();

            _scene = new Vector.<ParallaxBackground>();

            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            Starling.juggler.add(this);
        }

        // VIEW

        private function _onAddedToStage(event:Event):void {

            // ###### DECOR
            var background : Image = new Image(App.assets.getTexture("background"));
            addChild(background);

            _scene.push(new ParallaxBackground(App.assets.getTexture("farestPlan"), Settings.FAREST_PLAN_SPEED));
            _scene.push(new ParallaxBackground(App.assets.getTexture("thirdPlan"), Settings.THIRD_PLAN_SPEED));
            _scene.push(new ParallaxBackground(App.assets.getTexture("secondPlan"), Settings.SECOND_PLAN_SPEED));

            for each(var parallax:ParallaxBackground in _scene)
                addChild(parallax);

            // CHARACTER
            _character = new Character();
            addChild(_character);
            _character.animate();
            _character.y = stage.stageHeight - _character.height - 80;
            _character.x = 80;
            Settings.ground = _character.y;
            _characterGravity = new GravityManager(_character, Settings.ground);

            // MAP
            _map = new Map();
            var levelLoader:LevelLoader = new LevelLoader("medias/map_2.json");
            levelLoader.addEventListener(LevelLoaderEvent.LEVEL_LOADED, function(event:LevelLoaderEvent) {
                _map.level = event.level;
                addChildAt(_map, 4);
                _map.y = 80;
                _map.x = stage.stageWidth+200;
                _map.player = _character;
                _map.addEventListener(CollisionEvent.COLLISION, _onCollision);
                _map.addEventListener(GameEvent.COMPLETE, _onComplete);

                addEventListener(GameEvent.POINT, _onPointGain);
                addEventListener(GameEvent.BONUS, _onBonus);
            });

            // UI
            _scoreView = new TextField(200, 50, ""+_score);
            addChild(_scoreView);
            _scoreView.color = 0xFFFFFF;
            _scoreView.fontSize = 24;
            _scoreView.x = stage.stageWidth - _scoreView.width;
            _scoreView.y = _scoreView.height;
        }

        // EVENT LISTENER FUNCTIONS

        private function _onComplete(event:GameEvent):void {
            dispatchEvent(event);
        }

        private function _onTouch(event:TouchEvent):void {

            var touchBegins : Touch = event.getTouch(this, TouchPhase.BEGAN);
            if(touchBegins) {
                _touchBegin = new Date().time;
                _character.jump();
            }

            var touchEnded : Touch = event.getTouch(this, TouchPhase.ENDED);
            if(touchEnded) {
                _touchBegin = 0;
                _character.stopJump();
            }
        }

        private function _onCollision(event:CollisionEvent):void {
            if(event.tile is Point && event.tile.enabled) {
                event.tile.enabled = false;
                dispatchEvent(new GameEvent(GameEvent.POINT));
            }
            else if(event.tile is AObstacle) {
                dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
            }
            else if(event.tile is Bonus && event.tile.enabled) {
                event.tile.enabled = false;
                dispatchEvent(new GameEvent(GameEvent.BONUS));
            }
        }

        private function _onPointGain(event:GameEvent):void {
            _score++;
            _scoreView.text = ""+_score;
        }

        private function _onBonus(event:GameEvent):void {
            pause();

            _popup = new Popup("Game bonus !", App.assets.getTexture("bkgPopup"));
            addChild(_popup);
            _popup.x = stage.stageWidth / 2 - _popup.width / 2;
            _popup.y = stage.stageHeight / 2 - _popup.height / 2;

            var randomMachine : RandomCasino = new RandomCasino(App.assets.getTexture("bkgWindowCasino"), App.assets.getTexture("tireuseUp"), App.assets.getTexture("tireuseDown"), App.assets.getTexture("bkgLauncherCasino"));
            randomMachine.addValue(Character.NORMAL_STATE, App.assets.getTexture("normal"));
            randomMachine.addValue(Character.FLY_STATE, App.assets.getTexture("redBull"));
            randomMachine.addValue(Character.LOW_GRAVITY_STATE, App.assets.getTexture("astro"));
            _popup.addChild(randomMachine);
            randomMachine.addEventListener(RandomCasinoEvent.WINNER, _onBonusFound);

            /*var newState:Number = _character.getState() ;
            while(newState == _character.getState()){
                newState = Math.floor(Math.random()*3+1);
            }
            _character.changeState(newState);
            trace(newState);*/
        }

        private function _onBonusFound(event:RandomCasinoEvent):void {
            _popup.removeChildren();
            removeChild(_popup, true);
            _popup = null;

            play();
            _character.changeState(event.winner);
            trace(event.winner);

            _touchBegin = 0;
            _character.stopJump();
        }

        // INTERFACES FUNCTIONS

        public function play():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.play();

            _character.play();
            _characterGravity.play();
            if(_map) _map.play();
            else if(!Settings.show_tutorial) {
                _map.addEventListener(Event.ADDED_TO_STAGE, function(event:Event) {
                    _map.play();
                });
            }
            addEventListener(TouchEvent.TOUCH, _onTouch);
        }

        public function pause():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.pause();

            _character.pause();
            _characterGravity.pause();
            if(_map) _map.pause();

            removeEventListener(TouchEvent.TOUCH, _onTouch);
        }

        // GETTERS / SETTERS

        public function get score():int {
            return _score;
        }

        public function get scene():Vector.<ParallaxBackground> {
            return _scene;
        }

        public function advanceTime(time:Number):void {
            if(_touchBegin > 0) {
                _character.jump();
            }
        }
    }
}
