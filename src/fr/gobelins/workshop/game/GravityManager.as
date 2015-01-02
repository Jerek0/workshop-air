/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game {
import fr.gobelins.workshop.events.CharacterEvent;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.display.Sprite;

public class GravityManager implements IAnimatable{

    private var _entity:Sprite;

    private var _ground:int;
    private var _gravity:int;
    private var _friction:Number;

    private var _velY:Number = 0;

    public function GravityManager(entity:Sprite, ground:int = 50, gravity:int = 2) {

        _entity = entity;

        _ground = ground;
        _gravity = gravity;

        Starling.juggler.add(this);

        _entity.addEventListener(CharacterEvent.JUMP, _onJump);
    }

    private function _onJump(event:CharacterEvent):void {
        if(_entity.y == _ground) _velY = -40;
    }

    public function advanceTime(time:Number):void {
        _entity.y += _velY;

        if(_entity.y < _ground) _velY += _gravity;
        else {
            _velY = 0;
            _entity.y = _ground;
            _entity.dispatchEvent(new CharacterEvent(CharacterEvent.LANDED));
        }
    }
}
}
