/**
 * Created by jerek0 on 04/01/2015.
 */
package fr.gobelins.workshop.util {
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;

    public class ProgressBar extends Sprite {

        private var _percentage:Number = 0;

        private var _width:int;
        private var _height:int;

        private var _colorBackground:int;
        private var _colorBar:int;
        private var _padding:int;

        private var _background:Quad;
        private var _bar:Quad;

        public function ProgressBar(width:int, height:int, colorBar:int = 0xFF0000, colorBackground:int = 0xFFFFFF, padding:int = 1) {
            super();

            _width = width;
            _height = height;

            _colorBar = colorBar;
            _colorBackground = colorBackground;

            _padding = padding;

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            _background = new Quad(_width, _height, _colorBackground);
            addChild(_background);

            _bar = new Quad(1, _height - (_padding * 2), _colorBar);
            _bar.x = _padding;
            _bar.y = _padding;
            _bar.alpha = 0;
            addChild(_bar);
        }

        private function _updateBar():void {
            if(percentage == 0) _bar.alpha = 0;
            else _bar.alpha = 1;
            _bar.width = 1 + (((_width - 1) - (_padding * 2 )) * _percentage);
        }

        public function get percentage():Number {
            return _percentage;
        }

        public function set percentage(value:Number):void {
            if(value < 0) value = 0;
            else if (value > 1) value = 1;

            _percentage = value;
            _updateBar();
        }
    }
}
