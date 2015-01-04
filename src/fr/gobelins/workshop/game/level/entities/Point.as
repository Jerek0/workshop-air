/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level.entities {

import fr.gobelins.workshop.App;
import fr.gobelins.workshop.game.level.Tile;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.MovieClip;

import starling.display.Quad;
import starling.events.Event;

public class Point extends Tile {

    private var _enabled:Boolean = true;

    private var _body:MovieClip;

    public function Point() {
        super();
    }

    protected override function _onAddedToStage(event:Event):void {
        var quad:Quad = new Quad(76,76,0xFFFF00);
        quad.x=0;
        quad.y=0;
        addChild(quad);

        //_body = new MovieClip(App.assets.getTextureAtlas("dino").getTextures("Dinosaure"));
        //addChild(_body);

        //_animate();
    }

    private function _animate():void {
        var _tween :Tween = new Tween(_body, 0.3);
        _tween.animate("currentFrame", _body.numFrames-1);
        _tween.repeatCount = int.MAX_VALUE;
        Starling.juggler.add(_tween)
    }

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set enabled(value:Boolean):void {
        _enabled = value;
        if(value == true) this.alpha = 1;
        else this.alpha = 0;
    }
}
}
