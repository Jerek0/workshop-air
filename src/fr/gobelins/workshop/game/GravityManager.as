/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game {
import fr.gobelins.workshop.events.CharacterEvent;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Sprite;

public class GravityManager implements IAnimatable, IGameEntity{

    private var _entity:Sprite;

    private var _ground:int;
    private var _gravity:int;

    private var _velY:Number = 0;

    public function GravityManager(entity:Sprite, ground:int = 50, gravity:int = 6000) {

        _entity = entity;

        _ground = ground;
        _gravity = gravity;

        _entity.addEventListener(CharacterEvent.JUMP, _onJump);
    }

    private function _onJump(event:CharacterEvent):void {
        if(_entity.y == _ground) _velY = -2000;
    }

    public function advanceTime(time:Number):void {
        _entity.y += _velY * time;

        if(_entity.y < _ground) _velY += _gravity * time;
        else {
            _velY = 0;
            _entity.y = _ground;
            _entity.dispatchEvent(new CharacterEvent(CharacterEvent.LANDED));
        }

        //trace(time);
    }

    public function play():void {
        Starling.juggler.add(this);
    }

    public function pause():void {
        Starling.juggler.remove(this);
    }
}
}
