/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.constants.Settings;

public class LowGravityState implements ICharacterState {
    private var _id:uint = Character.LOW_GRAVITY_STATE;

    public function LowGravityState() {
        Settings.GRAVITY = Settings.LOW_GRAVITY;
        Settings.JUMP_INERTY = Settings.LOW_JUMP_INERTY;
        Settings.CEILING = Settings.LOW_CEILING;

        Settings.CAN_JUMP_IN_THE_AIR = false;
    }

    public function get id():uint {
        return _id;
    }
}
}
