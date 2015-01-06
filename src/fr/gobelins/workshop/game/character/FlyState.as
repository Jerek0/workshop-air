/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.constants.Settings;

public class FlyState implements ICharacterState {
    private var _id:uint = Character.FLY_STATE;
    private var _atlas:String = "RaptorFly";
    private var _runTextures:String = "FlyRun";
    private var _upTextures:String = "";
    private var _downTextures:String = "";

    public function FlyState() {
        Settings.GRAVITY = Settings.FLY_GRAVITY;
        Settings.JUMP_INERTY = Settings.FLY_JUMP_INERTY;
        Settings.CEILING = Settings.FLY_CEILING;

        Settings.CAN_JUMP_IN_THE_AIR = true;
    }

    public function get id():uint {
        return _id;
    }

    public function get upTextures():String {
        return _upTextures;
    }

    public function get runTextures():String {
        return _runTextures;
    }

    public function get atlas():String {
        return _atlas;
    }

    public function get downTextures():String {
        return _downTextures;
    }
}
}
