/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.CollisionEvent;
import fr.gobelins.workshop.events.GameEvent;
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
import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
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
        private var _overlay:DisplayObject;
        private var _btnPause:Button;

        private var _touchZone:Quad;

        public function Game() {
            super();

            _scene = new Vector.<ParallaxBackground>();

            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            Starling.juggler.add(this);
        }

        // VIEW

        private function _onAddedToStage(event:Event):void {

            // ###### DECOR
            var background : Image = new Image(App.assets.getTextureAtlas("Backgrounds").getTexture("Fond"));
            addChild(background);

            _scene.push(new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanFarest"), Settings.FAREST_PLAN_SPEED));
            _scene.push(new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanThird"), Settings.THIRD_PLAN_SPEED));
            _scene.push(new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanSecond"), Settings.SECOND_PLAN_SPEED));

            for each(var parallax:ParallaxBackground in _scene)
                addChild(parallax);

            _scene[0].y = 140;
            _scene[1].y = 240;
            _scene[2].y = stage.stageHeight - _scene[2].height + 1;

            // CHARACTER
            _character = new Character();
            addChild(_character);
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
            _scoreView = new TextField(100, 50, ""+_score, Settings.FONT);
            addChild(_scoreView);
            _scoreView.hAlign = "right";
            _scoreView.color = 0xFFFFFF;
            _scoreView.fontSize = 50;
            _scoreView.x = stage.stageWidth - _scoreView.width - 100;
            _scoreView.y = 33;

            _touchZone = new Quad(stage.stageWidth, stage.stageHeight, 0xFFFFFFF);
            _touchZone.x = 0; _touchZone.y = 0;
            _touchZone.alpha = 0;
            addChild(_touchZone);

            _btnPause = new Button(App.assets.getTextureAtlas("userInterface").getTexture("Pause0000"));
            _btnPause.addEventListener(Event.TRIGGERED, _onPause);
            addChild(_btnPause);
            _btnPause.x = stage.stageWidth - _btnPause.width - 40;
            _btnPause.y = 40;
        }

        private function _onPause(event:Event):void {
            dispatchEvent(new GameEvent(GameEvent.PAUSE));
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

            _overlay = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            _overlay.alpha = 0.8;
            _overlay.x = 0; _overlay.y = 0;
            addChild(_overlay);

            _popup = new Popup("", App.assets.getTextureAtlas("userInterface").getTexture("bg-roulette"));
            addChild(_popup);
            _popup.x = stage.stageWidth / 2 - _popup.width / 2;
            _popup.y = stage.stageHeight / 2 - _popup.height / 2;

            var title:TextField = new TextField(stage.stageWidth, 80, "Win a bonus !", Settings.FONT);
            title.color = 0xFFFFFF;
            title.fontSize = 70;
            _popup.addChild(title);
            title.x = _popup.width / 3 - title.width / 2;
            title.y = 30;

            var randomMachine : RandomCasino = new RandomCasino(App.assets.getTextureAtlas("userInterface").getTexture("case"), App.assets.getTextureAtlas("userInterface").getTexture("tireuse-1"), App.assets.getTextureAtlas("userInterface").getTexture("tireuse-2"), App.assets.getTextureAtlas("userInterface").getTexture("tireuse"));
            randomMachine.addValue(Character.NORMAL_STATE, App.assets.getTextureAtlas("userInterface").getTexture("tireuse-raptor"));
            randomMachine.addValue(Character.FLY_STATE, App.assets.getTextureAtlas("userInterface").getTexture("tireuse-redbull"));
            randomMachine.addValue(Character.LOW_GRAVITY_STATE, App.assets.getTextureAtlas("userInterface").getTexture("tireuse-astro"));
            _popup.addChild(randomMachine);
            randomMachine.y = 150;
            randomMachine.x = 70;
            randomMachine.addEventListener(RandomCasinoEvent.WINNER, _onBonusFound);

            var winnerBottom : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("gagnant"));
            randomMachine.addChildAt(winnerBottom, 0);
            winnerBottom.x = randomMachine.width - winnerBottom.width - 60;
            winnerBottom.y = randomMachine.height - winnerBottom.height - 60;

            var winnerTop : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("gagnant"));
            randomMachine.addChildAt(winnerTop, 0);
            winnerTop.x = randomMachine.width - winnerTop.width - 60;
            winnerTop.y = 0;

            var pull : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("tirez"));
            _popup.addChild(pull);
            pull.x = randomMachine.x + randomMachine.width - pull.width;
            pull.y = 20;
        }

        private function _onBonusFound(event:RandomCasinoEvent):void {
            _popup.removeChildren();
            removeChild(_overlay, true);
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
            _touchZone.addEventListener(TouchEvent.TOUCH, _onTouch);
        }

        public function pause():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.pause();

            _character.pause();
            _characterGravity.pause();
            if(_map) _map.pause();

            _touchBegin = 0;
            _touchZone.removeEventListener(TouchEvent.TOUCH, _onTouch);
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
