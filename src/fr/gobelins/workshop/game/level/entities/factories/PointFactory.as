/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level.entities.factories {
import fr.gobelins.workshop.game.level.entities.Point;

    public class PointFactory {

        private var _points:Vector.<Point>;

        public function PointFactory(quantity:int = 20) {
            _points = new Vector.<Point>();

            for(var i:int = 0; i < quantity; i ++)
                _points.push(new Point());
        }

        public function getPoint():Point {
            if(_points.length) return _points.pop();
            else return new Point();
        }

        public function storePoint(point:Point):void {
            _points.push(point);
        }
    }
}
