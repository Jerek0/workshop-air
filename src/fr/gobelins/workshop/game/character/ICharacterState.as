/**
 * Created by jerek0 on 05/01/2015.
 */
package fr.gobelins.workshop.game.character {
    public interface ICharacterState {
        function get id():uint
        function get atlas():String;
        function get runTextures():String;
        function get upTextures():String;
        function get downTextures():String
    }
}
