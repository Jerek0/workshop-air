/**
 * Created by jerek0 on 16/12/2014.
 */
package fr.gobelins.workshop.slider {

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.display.DisplayObject;

public class DotsContainer extends Sprite {

    private var _slider:Slider;
    private var _dots:Vector.<Dot>;
    private var _dotActiveTexture:Texture;
    private var _dotInactiveTexture:Texture;

    public function DotsContainer(slider:Slider, dotActiveTexture:Texture, dotInactiveTexture:Texture) {
        super();

        _slider = slider;
        _dotActiveTexture = dotActiveTexture;
        _dotInactiveTexture = dotInactiveTexture;
        _dots = new Vector.<Dot>();

        this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        for each(var slide:DisplayObject in _slider.slides) {
            var dot:Dot = new Dot(_dotInactiveTexture);
            dot.y = 0;
            dot.x = (dot.width + 5)*_dots.length;
            _dots.push(dot);
            addChild(dot);
        }

        _updateActiveDot();
        _slider.addEventListener(Event.CHANGE, _updateActiveDot);
    }

    private function _updateActiveDot(event: Event = null):void {
        for each(var dot:Dot in _dots) {
            dot.view.texture = _dotInactiveTexture;
        }
        _dots[_slider.currentSlide].view.texture = _dotActiveTexture;
    }
}
}
