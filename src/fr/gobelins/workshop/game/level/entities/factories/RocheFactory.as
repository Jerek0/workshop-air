/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
import fr.gobelins.workshop.game.level.entities.Roche;

public class RocheFactory {

        private var _roches:Vector.<Roche>;

        public function RocheFactory(quantity:int = 1) {
            _roches = new Vector.<Roche>();

            for(var i:int = 0; i < quantity; i ++)
                _roches.push(new Roche());
        }

        public function getItem():Roche {
            if(_roches.length) return _roches.pop();
            else return new Roche();
        }

        public function storeItem(item:Roche):void {
            item.enabled = true;
            _roches.push(item);
        }
    }
}
