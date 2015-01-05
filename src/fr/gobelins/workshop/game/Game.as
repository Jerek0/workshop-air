/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.Settings;
    import fr.gobelins.workshop.events.GameEvent;
    import fr.gobelins.workshop.events.LevelLoaderEvent;
    import fr.gobelins.workshop.game.character.Character;
    import fr.gobelins.workshop.game.level.LevelLoader;
    import fr.gobelins.workshop.game.level.Map;
    import fr.gobelins.workshop.util.ParallaxBackground;
    import fr.gobelins.workshop.util.ProgressBar;

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
        private var _jumpProgressBar:ProgressBar;

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

                _map.addEventListener(GameEvent.POINT, _onPointGain);
                _map.addEventListener(GameEvent.COMPLETE, _onMapComplete);
                _map.addEventListener(GameEvent.GAME_OVER, _onGameOver);
            });

            // UI
            _scoreView = new TextField(200, 50, ""+_score);
            addChild(_scoreView);
            _scoreView.color = 0xFFFFFF;
            _scoreView.fontSize = 24;
            _scoreView.x = stage.stageWidth - _scoreView.width;
            _scoreView.y = _scoreView.height;

            /*_jumpProgressBar = new ProgressBar(200, 20, 0xFFFFFF, 0x666666);
            addChild(_jumpProgressBar);
            _jumpProgressBar.x = stage.stageWidth / 2 - _jumpProgressBar.width / 2;
            _jumpProgressBar.y = stage.stageHeight - _jumpProgressBar.height - 20;
            _jumpProgressBar.alpha = 0.2;*/


            this.addEventListener(TouchEvent.TOUCH, _onTouch);
        }

        // EVENT LISTENER FUNCTIONS

        private function _onTouch(event:TouchEvent):void {
            /*var touchBegins : Touch = event.getTouch(this, TouchPhase.BEGAN);
            if(touchBegins) {
                _touchBegin = new Date().time;
            }

            var touchEnded : Touch = event.getTouch(this, TouchPhase.ENDED);
            if(touchEnded) {
                var currentTime = new Date().time;
                var deltaTime:Number = currentTime - _touchBegin;

                _character.jump(deltaTime);
                if(_jumpProgressBar) _jumpProgressBar.percentage = 0;

                _touchBegin = 0;
            }*/

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

        private function _onPointGain(event:GameEvent):void {
            _score++;
            _scoreView.text = ""+_score;
        }

        private function _onMapComplete(event:GameEvent):void {
            dispatchEvent(event);
        }

        private function _onGameOver(event:GameEvent):void {
            dispatchEvent(event);
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
        }

        public function pause():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.pause();

            _character.pause();
            _characterGravity.pause();
            if(_map) _map.pause();
        }

        // GETTERS / SETTERS

        public function get score():int {
            return _score;
        }

        public function get scene():Vector.<ParallaxBackground> {
            return _scene;
        }

        public function advanceTime(time:Number):void {
            /*if(_touchBegin > 0) {
                var currentTime = new Date().time;
                var deltaTime:Number = currentTime - _touchBegin;

                _character.jump();

                if(deltaTime && deltaTime > Settings.TOUCH_MIN_DELTA_TIME) {
                    if(deltaTime < (Settings.TOUCH_MAX_DELTA_TIME + Settings.TOUCH_MIN_DELTA_TIME)) {
                        _jumpProgressBar.percentage = (deltaTime) / (Settings.TOUCH_MAX_DELTA_TIME + Settings.TOUCH_MIN_DELTA_TIME);
                    } else {
                        _jumpProgressBar.percentage = 1;
                    }
                }
            }*/
        }
    }
}
