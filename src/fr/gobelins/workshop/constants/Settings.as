/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.constants {
public class Settings {

    public static const APP_WIDTH:uint = 1280;
    public static const APP_HEIGHT:uint = 768;

    public static var SECOND_PLAN_SPEED:Number = 1.5;
    public static var THIRD_PLAN_SPEED:Number = 6;
    public static var FAREST_PLAN_SPEED:Number = 18;

    public static const TILE_SIZE:uint = 76;

    public static const NORMAL_GRAVITY:uint = 2600;
    public static const FLY_GRAVITY:uint = 2600;
    public static const LOW_GRAVITY:uint = 600;

    public static const NORMAL_JUMP_INERTY:uint = 600;
    public static const FLY_JUMP_INERTY:uint = 600;
    public static const LOW_JUMP_INERTY:uint = 300;

    public static const NORMAL_CEILING:int = 80+76;
    public static const FLY_CEILING:int = 80;
    public static const LOW_CEILING:int = 10;

    public static var GRAVITY:uint = 2600;
    public static var JUMP_INERTY:uint = 600;

    public static var ground:int = 50;
    public static var CEILING:int = 80+TILE_SIZE;

    public static var CAN_JUMP_IN_THE_AIR:Boolean = false;

    /*public static const TOUCH_MIN_DELTA_TIME:uint = 80;
    public static const TOUCH_MAX_DELTA_TIME:uint = 1200;*/

    public static var show_tutorial:Boolean = true;

    public function Settings() {
    }
}
}
