/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
    import fr.gobelins.workshop.game.level.entities.Bonus;

    public class BonusFactory {

        private var _bonus:Vector.<Bonus>;

        public function BonusFactory(quantity:int = 1) {
            _bonus = new Vector.<Bonus>();

            for(var i:int = 0; i < quantity; i ++)
                _bonus.push(new Bonus());
        }

        public function getBonus():Bonus {
            if(_bonus.length) return _bonus.pop();
            else return new Bonus();
        }

        public function storeBonus(bonus:Bonus):void {
            _bonus.push(bonus);
        }
    }
}
