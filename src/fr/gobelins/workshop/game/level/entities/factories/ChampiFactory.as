/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
import fr.gobelins.workshop.game.level.entities.Champi;

public class ChampiFactory {

        private var _champis:Vector.<Champi>;

        public function ChampiFactory(quantity:int = 1) {
            _champis = new Vector.<Champi>();

            for(var i:int = 0; i < quantity; i ++)
                _champis.push(new Champi());
        }

        public function getChampi():Champi {
            if(_champis.length) return _champis.pop();
            else return new Champi();
        }

        public function storeChampi(champi:Champi):void {
            _champis.push(champi);
        }
    }
}
