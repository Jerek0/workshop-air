/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game {
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.CharacterEvent;

import starling.animation.IAnimatable;
import starling.animation.Transitions;
import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;

public class GravityManager implements IAnimatable, IGameEntity{

    private var _entity:Sprite;

    private var _ground:int;

    private var _velY:Number = 0;

    private var _jumpBegin:Number = 0;

    public function GravityManager(entity:Sprite, ground:int = 50) {

        _entity = entity;

        _ground = ground;

        _entity.addEventListener(CharacterEvent.JUMP, _onJump);
        _entity.addEventListener(CharacterEvent.STOP_JUMP, _onStopJump);
    }

    private function _onStopJump(event:CharacterEvent):void {
        _stopJump();
    }

    private function _stopJump():void {
        _jumpBegin = 0;
        _entity.dispatchEvent(new CharacterEvent(CharacterEvent.FALLING));
    }

    private function _onJump(event:CharacterEvent):void {
        if(Settings.CAN_JUMP_IN_THE_AIR || ((_jumpBegin == 0 && _entity.y == _ground) || (_jumpBegin > 0 && _velY <= 0))){
            if(_jumpBegin == 0) _jumpBegin = new Date().time;

            if(_entity.y > (Settings.CEILING + 76))
                _velY = -(Settings.JUMP_INERTY);
            else {
                _stopJump();
            }
        }
    }

    public function advanceTime(time:Number):void {
        _entity.y += _velY * time;

        if(_entity.y < _ground) {
            if(_jumpBegin == 0) _velY += Settings.GRAVITY * time;
        }
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
