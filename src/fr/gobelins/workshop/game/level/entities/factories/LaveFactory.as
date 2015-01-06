/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
import fr.gobelins.workshop.game.level.entities.Lave;

public class LaveFactory {

        private var _laves:Vector.<Lave>;

        public function LaveFactory(quantity:int = 1) {
            _laves = new Vector.<Lave>();

            for(var i:int = 0; i < quantity; i ++)
                _laves.push(new Lave());
        }

        public function getItem():Lave {
            if(_laves.length) return _laves.pop();
            else return new Lave();
        }

        public function storeItem(item:Lave):void {
            item.enabled = true;
            _laves.push(item);
        }
    }
}
