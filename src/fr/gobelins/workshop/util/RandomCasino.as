/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.util {
    import fr.gobelins.workshop.events.RandomCasinoEvent;

import starling.animation.IAnimatable;

import starling.core.Starling;

import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    public class RandomCasino extends Sprite implements IAnimatable {

        private var _values:Array;

        private var _launcher:Button;
        private var _window:Image;
        private var _backgroundLauncher:Image;

        private var _imagesShowed:Vector.<Image>;
        private var _nextToShow:uint;
        private var _lastTimeShowed:Number = 0;

        public function RandomCasino(window:Texture, launcherUp:Texture, launcherDown:Texture, backgroundLauncher:Texture) {
            super();

            _values = new Array();

            _launcher = new Button(launcherUp, "", launcherDown);
            _launcher.scaleWhenDown = 1;
            _backgroundLauncher = new Image(backgroundLauncher);
            _window = new Image(window);

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            addChild(_window);
            addChild(_backgroundLauncher);
            addChild(_launcher);

            _backgroundLauncher.x = _window.x + _window.width + 40;
            _backgroundLauncher.y = _window.y + (_window.height / 2) - (_backgroundLauncher.height / 2);

            _launcher.x = _backgroundLauncher.x + (_backgroundLauncher.width / 2) - (_launcher.width / 2);
            _launcher.y = _backgroundLauncher.y + (_backgroundLauncher.height / 2) - (_launcher.height / 2);

            _launcher.addEventListener(Event.TRIGGERED, _onLaunch);

            _imagesShowed = new Vector.<Image>();
            for each(var value:Array in _values) {
                _imagesShowed.push(new Image(value[1]));
            }

            Starling.juggler.add(this);
        }

        private function _onLaunch(event:Event):void {
            _launcher.removeEventListener(Event.TRIGGERED, _onLaunch);

            Starling.juggler.remove(this);
            var id = (_nextToShow == 0 ? (_imagesShowed.length - 1) : _nextToShow - 1) % _imagesShowed.length;
            var winner:int = _values[id][0];

            Starling.juggler.delayCall(function():void {
                dispatchEvent(new RandomCasinoEvent(RandomCasinoEvent.WINNER, winner));
            }, 0.5);
        }

        public function addValue(id:uint, texture:Texture) {
            _values.push(new Array(id,texture));
        }

        public function advanceTime(time:Number):void {
            if(_lastTimeShowed == 0 || (new Date().time - _lastTimeShowed) > 500) {
                var currentImage:uint = _nextToShow % _imagesShowed.length;

                for each(var image:Image in _imagesShowed)
                    removeChild(image, true);

                addChild(_imagesShowed[currentImage]);
                _imagesShowed[currentImage].x = _window.x + (_window.width / 2) - (_imagesShowed[currentImage].width / 2);
                _imagesShowed[currentImage].y = _window.y + (_window.height / 2) - (_imagesShowed[currentImage].height / 2);

                _nextToShow = (currentImage + 1) % _imagesShowed.length;
            }
        }
    }
}
