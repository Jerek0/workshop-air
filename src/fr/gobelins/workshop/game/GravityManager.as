/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game {
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.CharacterEvent;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Sprite;

public class GravityManager implements IAnimatable, IGameEntity{

    private var _entity:Sprite;

    private var _ground:int;
    private var _gravity:int;

    private var _velY:Number = 0;

    public function GravityManager(entity:Sprite, ground:int = 50) {

        _entity = entity;

        _ground = ground;
        _gravity = Settings.GRAVITY;

        _entity.addEventListener(CharacterEvent.JUMP, _onJump);
    }

    private function _onJump(event:CharacterEvent):void {
        if(_entity.y == _ground) {
            if(event.deltaTime) {
                var percentage:Number = ((event.deltaTime - Settings.TOUCH_MIN_DELTA_TIME) / Settings.TOUCH_MAX_DELTA_TIME);
                if(percentage<0) percentage = 0;
                else if (percentage > 1) percentage = 1;

                _velY -= Settings.JUMP_MIN_INERTY + ((Settings.JUMP_MAX_INERTY - Settings.JUMP_MIN_INERTY) * percentage);

                _gravity = Settings.GRAVITY - (Settings.GRAVITY_REDUCER_MAX * percentage);
            } else {
                _velY -= Settings.JUMP_MAX_INERTY;
            }
        }
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
