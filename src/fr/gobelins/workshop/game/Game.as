/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {
    import fr.gobelins.workshop.App;
import fr.gobelins.workshop.game.character.Character;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.game.level.Map;
import fr.gobelins.workshop.util.ParallaxBackground;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;

    public class Game extends Sprite implements IGameEntity{

        private var _scene:Vector.<ParallaxBackground>;
        private var _character:Character;
        private var _characterGravity:GravityManager;

        public function Game() {
            super();

            _scene = new Vector.<ParallaxBackground>();

            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {

            // ###### DECOR
            var background : Image = new Image(App.assets.getTexture("background"));
            addChild(background);

            _scene.push(new ParallaxBackground(App.assets.getTexture("farestPlan"), 18));
            _scene.push(new ParallaxBackground(App.assets.getTexture("thirdPlan"),6));
            _scene.push(new ParallaxBackground(App.assets.getTexture("secondPlan"), 2));

            for each(var parallax:ParallaxBackground in _scene)
                addChild(parallax);

            // MAP

            var map:Map = new Map("medias/map_2.json");
            addChild(map);
            map.y = 80;
            map.x = 0;

            // CHARACTER
            _character = new Character();
            addChild(_character);
            _character.animate();
            _character.y = stage.stageHeight - _character.height - 80;
            _character.x = 80;
            _characterGravity = new GravityManager(_character, _character.y);

            this.addEventListener(TouchEvent.TOUCH, _onTouch);
        }

        private function _onTouch(event:TouchEvent):void {
            var touchBegins : Touch = event.getTouch(this, TouchPhase.BEGAN);
            if(touchBegins) {
                _character.jump();
            }
        }

        public function get scene():Vector.<ParallaxBackground> {
            return _scene;
        }

        public function set scene(value:Vector.<ParallaxBackground>):void {
            _scene = value;
        }

        public function play():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.play();

            _character.play();
        }

        public function pause():void {
            for each(var parallax:ParallaxBackground in scene)
                parallax.pause();

            _character.pause();
        }
    }
}
