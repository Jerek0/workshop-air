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
    private var _gravity:int;

    private var _velY:Number = 0;

    private var _jumpBegin:Number = 0;

    public function GravityManager(entity:Sprite, ground:int = 50) {

        _entity = entity;

        _ground = ground;
        _gravity = Settings.GRAVITY;

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
        // TODO Gerer le saut au touch
        /*if(_entity.y == _ground) {
            if(event.deltaTime) {
                var percentage:Number = ((event.deltaTime - Settings.TOUCH_MIN_DELTA_TIME) / Settings.TOUCH_MAX_DELTA_TIME);
                if(percentage<0) percentage = 0;
                else if (percentage > 1) percentage = 1;

                _velY -= Settings.JUMP_MIN_INERTY + ((Settings.JUMP_INERTY - Settings.JUMP_MIN_INERTY) * percentage);

                _gravity = Settings.GRAVITY - (Settings.GRAVITY_REDUCER_MAX * percentage);
            } else {
                _velY -= Settings.JUMP_INERTY;
            }
        }*/

        if((_jumpBegin == 0 && _entity.y == _ground) || (_jumpBegin > 0 && _velY <= 0)){
            if(_jumpBegin == 0) _jumpBegin = new Date().time;

            /*var currentTime:Number = new Date().time;
            var deltaTime:Number = currentTime - _jumpBegin;

            var percentageTime = (Settings.TOUCH_MAX_DELTA_TIME - deltaTime) / Settings.TOUCH_MAX_DELTA_TIME;
            if(percentageTime>1) percentageTime = 1;
            else if(percentageTime < 0.2) percentageTime = 0;

            var maxDelta = Settings.ground - Settings.CEILING;
            var currentDelta = _entity.y - Settings.CEILING;
            var percentageHeight = currentDelta / maxDelta;
            if(percentageHeight>1) percentageHeight = 1;
            else if(percentageHeight < 0.2) percentageHeight = 0;*/

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
            if(_jumpBegin == 0) _velY += _gravity * time;
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
