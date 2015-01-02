/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.App;
import fr.gobelins.workshop.events.CharacterEvent;
import fr.gobelins.workshop.game.IGameEntity;

import starling.animation.IAnimatable;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;

public class Character extends Sprite implements IGameEntity {
    private var _body:MovieClip;
    private var _size:int;
    private var _tween:Tween;

    private var _velY:Number = 0;

    public function Character() {
        super();

        addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        _body = new MovieClip(App.assets.getTextureAtlas("dino").getTextures("Dinosaure"));
        _size = 1;
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

    public function jump():void {
        this.dispatchEvent(new CharacterEvent(CharacterEvent.JUMP));
        addEventListener(CharacterEvent.LANDED, _onLanding);
        trace("jump");
    }

    private function _onLanding(event:CharacterEvent):void {
        trace("landing");
        removeEventListener(CharacterEvent.LANDED, _onLanding);
    }
}
}
