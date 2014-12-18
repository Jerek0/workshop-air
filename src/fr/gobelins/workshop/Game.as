/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop {

import starling.display.Quad;
import starling.display.Sprite;

    public class Game extends Sprite {
        public function Game() {
            super();
        }

        public function init(isHD:int):void {
            var quad:Quad = new Quad(50,50,0xFF0000);
            quad.x = 100;
            quad.y = 100;
            addChild(quad);
        }
    }
}
