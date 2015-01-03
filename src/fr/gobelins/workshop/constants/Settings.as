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

    public static var GRAVITY:uint = 4500;
    public static const GRAVITY_REDUCER_MAX:uint = 2000;

    public static const TOUCH_MIN_DELTA_TIME:uint = 80;
    public static const TOUCH_MAX_DELTA_TIME:uint = 320;

    public static const JUMP_MIN_INERTY:uint = 1200;
    public static const JUMP_MAX_INERTY:uint = 1600;

    public function Settings() {
    }
}
}
