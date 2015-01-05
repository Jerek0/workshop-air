/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.constants {
public class Settings {

    public static const APP_WIDTH:uint = 1280;
    public static const APP_HEIGHT:uint = 768;

    public static const SECOND_PLAN_SPEED:Number = 1.5;
    public static const THIRD_PLAN_SPEED:Number = 6;
    public static const FAREST_PLAN_SPEED:Number = 18;

    public static var GRAVITY:uint = 2600;
    public static var JUMP_INERTY:uint = 600;

    public static var ground:int = 50;
    public static const CEILING:int = 80+76;

    /*public static const TOUCH_MIN_DELTA_TIME:uint = 80;
    public static const TOUCH_MAX_DELTA_TIME:uint = 1200;*/

    public static var show_tutorial:Boolean = true;

    public function Settings() {
    }
}
}
