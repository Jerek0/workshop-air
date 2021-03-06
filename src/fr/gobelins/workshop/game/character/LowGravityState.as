/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.constants.Settings;

public class LowGravityState implements ICharacterState {
    private var _id:uint = Character.LOW_GRAVITY_STATE;
    private var _atlas:String = "RaptorMoon";
    private var _runTextures:String = "MoonRun";
    private var _upTextures:String = "MoonUp";
    private var _downTextures:String = "MoonDown";

    public function LowGravityState() {
        Settings.GRAVITY = Settings.LOW_GRAVITY;
        Settings.JUMP_INERTY = Settings.LOW_JUMP_INERTY;
        Settings.CEILING = Settings.LOW_CEILING;

        Settings.CAN_JUMP_IN_THE_AIR = false;
    }

    public function get id():uint {
        return _id;
    }

    public function get atlas():String {
        return _atlas;
    }

    public function get runTextures():String {
        return _runTextures;
    }

    public function get upTextures():String {
        return _upTextures;
    }

    public function get downTextures():String {
        return _downTextures;
    }
}
}
