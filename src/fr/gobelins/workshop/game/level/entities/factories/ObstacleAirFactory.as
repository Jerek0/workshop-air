/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {

import fr.gobelins.workshop.game.level.entities.ObstacleAir;

public class ObstacleAirFactory {

        private var _obstacles:Vector.<ObstacleAir>;

        public function ObstacleAirFactory(quantity:int = 1) {
            _obstacles = new Vector.<ObstacleAir>();

            for(var i:int = 0; i < quantity; i ++)
                _obstacles.push(new ObstacleAir());
        }

        public function getObstacle():ObstacleAir {
            if(_obstacles.length) return _obstacles.pop();
            else return new ObstacleAir();
        }

        public function storeObstacle(obstacle:ObstacleAir):void {
            _obstacles.push(obstacle);
        }
    }
}
