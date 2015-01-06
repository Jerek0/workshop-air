/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
import fr.gobelins.workshop.App;
import fr.gobelins.workshop.constants.Settings;

import starling.textures.Texture;

public class NormalState implements ICharacterState {
        private var _id:uint = Character.NORMAL_STATE;
        private var _atlas:String = "RaptorNormal";
        private var _runTextures:String = "NormalRun";
        private var _upTextures:String = "NormalUp";
        private var _downTextures:String = "NormalDown";

        public function NormalState() {
            Settings.GRAVITY = Settings.NORMAL_GRAVITY;
            Settings.JUMP_INERTY = Settings.NORMAL_JUMP_INERTY;
            Settings.CEILING = Settings.NORMAL_CEILING;

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
