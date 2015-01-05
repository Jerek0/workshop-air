/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.constants.Settings;

public class NormalState implements ICharacterState {
        public function NormalState() {
            Settings.GRAVITY = Settings.NORMAL_GRAVITY;
            Settings.JUMP_INERTY = Settings.NORMAL_JUMP_INERTY;
            Settings.CEILING = Settings.NORMAL_CEILING;

            Settings.CAN_JUMP_IN_THE_AIR = false;
        }
    }
}
