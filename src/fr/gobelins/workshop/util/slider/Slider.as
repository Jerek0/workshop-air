/**
 * Created by jminie on 16/12/2014.
 */
package fr.gobelins.workshop.util.slider {
    import flash.geom.Point;

import starling.animation.Transitions;

import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

public class Slider extends Sprite {

        private var _slides:Vector.<DisplayObject>;
        private var _slideWidth:int;

        private var _dots:Vector.<Sprite>;

        private var _touchBeginLocal:Point;
        private var _touchBeginGlobal:Point;
        private var _currentSlide:Number;

        public function Slider(width:int) {
            super();
            _slideWidth = width;
            _slides = new Vector.<DisplayObject>();
            _currentSlide = 0;

            _dots = new Vector.<Sprite>();

            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        // Adds a slide (DisplayObject) to the slider
        public function addSlide(d:DisplayObject):void {
            d.x = (_slides.length*_slideWidth) + (_slideWidth/2 - d.width/2);
            _slides.push(d);
            addChild(d);
        }

        // Go to the next slide if it is possible
        public function goToNext():void {
            // If there's a next slide, go to it
            if(_currentSlide+1 < _slides.length) {
                // Init animation
                var tween:Tween = new Tween(this, 0.25, Transitions.EASE_OUT);

                // Animation itself
                tween.animate("x", -(_currentSlide+1) * _slideWidth);
                _currentSlide++;
                this.dispatchEvent(new Event("change"));

                // Toggle Animation;
                Starling.juggler.add(tween);
            }
            else // Else, stay on the one we already are
                stayOnCurrent();
        }

        // Go to the previous slide if it is possible
        public function goToPrev():void {
            // If there's a prev slide, go to it
            if (_currentSlide > 0) {
                // Init animation
                var tween:Tween = new Tween(this, 0.25, Transitions.EASE_OUT);

                // Animation itself;
                tween.animate("x", -(_currentSlide - 1) * _slideWidth);
                _currentSlide--;
                this.dispatchEvent(new Event("change"));

                // Toggle Animation;
                Starling.juggler.add(tween);
            }
            else // Else, stay on the first slide;
                stayOnCurrent();
        }

        // Stay on the current slide
        public function stayOnCurrent():void {
            var tween:Tween = new Tween(this, 0.25, Transitions.EASE_OUT);
            tween.animate("x", -(_currentSlide*_slideWidth));
            Starling.juggler.add(tween);
        }

        // Toggles touch
        private function _onAddedToStage(event:Event):void {
            this.addEventListener(TouchEvent.TOUCH, _onTouch);
        }

        // ON TOUCH
        private function _onTouch(event:TouchEvent):void {

            // TOUCH BEGINNING
            var touchBegins : Touch = event.getTouch(this, TouchPhase.BEGAN);
            if(touchBegins) {
                // We store the begin of the touch, relatively to the slider AND to the stage, also, we set the current slide
                _touchBeginLocal = touchBegins.getLocation(this);
                _touchBeginGlobal = touchBegins.getLocation(stage);
            }

            // TOUCH MOVING
            var touchMoves : Touch = event.getTouch(this, TouchPhase.MOVED);
            if(touchMoves) {
                var amorti : uint = 1;
                if(this.x > 0 || this.x <= -(_slideWidth*(_slides.length-1))) {
                    amorti = 12;
                }
                this.x += (touchMoves.getLocation(this).x - touchMoves.getPreviousLocation(this).x) / amorti;
            }

            // TOUCH ENDS
            var touchEnds : Touch = event.getTouch(this, TouchPhase.ENDED);
            if(touchEnds) {
                // Here we use the global position (because the local one will always be the same, because of the touchmoving processing)
                var globalPos:Point = touchEnds.getLocation(stage);
                var offsetX : Number = globalPos.x - _touchBeginGlobal.x; // This tells us if the offset is left or right

                if(offsetX < -(_slideWidth*0.2)) {
                    goToNext();
                } else if(offsetX > _slideWidth*0.2) {
                    goToPrev();
                } else {
                    stayOnCurrent();
                }
            }
        }

    public function get slides():Vector.<DisplayObject> {
        return _slides;
    }

    public function get currentSlide():Number {
        return _currentSlide;
    }
}
}
