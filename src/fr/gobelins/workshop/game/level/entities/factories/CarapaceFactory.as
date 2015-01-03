/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
import fr.gobelins.workshop.game.level.entities.Carapace;

public class CarapaceFactory {

        private var _carapaces:Vector.<Carapace>;

        public function CarapaceFactory(quantity:int = 1) {
            _carapaces = new Vector.<Carapace>();

            for(var i:int = 0; i < quantity; i ++)
                _carapaces.push(new Carapace());
        }

        public function getCarapace():Carapace {
            if(_carapaces.length) return _carapaces.pop();
            else return new Carapace();
        }

        public function storeCarapace(carapace:Carapace):void {
            _carapaces.push(carapace);
        }
    }
}
