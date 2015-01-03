/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
import fr.gobelins.workshop.events.GameEvent;
import fr.gobelins.workshop.game.IGameEntity;
import fr.gobelins.workshop.game.level.entities.Point;
    import fr.gobelins.workshop.game.level.entities.factories.PointFactory;

import starling.animation.IAnimatable;
import starling.core.Starling;

import starling.display.Sprite;
    import starling.events.Event;

    public class Map extends Sprite implements IAnimatable, IGameEntity {

        private var _level:Object;

        private var _pointFactory:PointFactory;
        private var _pointsUsed:Vector.<Point>;

        private var _colsShowed:Array;

        private var _nextColToShow:int = 0;
        private var _nextColToHide:int = 0;

        public function Map(level:Object) {
            super();
            _level = level;

            _pointFactory = new PointFactory(27);
            _pointsUsed = new Vector.<Point>();

            _colsShowed = new Array();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            var colCPT = 0;
            var rowCPT = 0;

            /*var pointFactory:PointFactory = new PointFactory(20);
            var pointsUsed:Vector.<Point> = new Vector.<Point>();

            for each(var col:Array in _level.layers[0].data) {
                for each(var id:int in col) {
                    if(id == 3) {
                        var tile = pointFactory.getPoint();
                        pointsUsed.push(tile);
                    }
                    else {
                        var tile:Tile = new Tile();
                    }

                    addChild(tile);
                    tile.x = (colCPT % _level.layers[0].width) * _level.tilewidth;
                    tile.y = (rowCPT % _level.layers[0].height) * _level.tilewidth;

                    rowCPT++;
                }
                rowCPT = 0;
                colCPT++;
                if(colCPT > 18) break;
            }*/
        }

        public function advanceTime(time:Number):void {
            this.x -= 640 * time;

            _update();
        }

        private function _update():void {
            if(_nextColToShow <= _level.width && this.x + ( 76 * _nextColToShow ) < stage.stageWidth + 76) {
                _showColById(_nextColToShow);
                _nextColToShow++;
            }

            if(_nextColToHide <= _level.width && this.x + ( 76 * _nextColToHide) < (-76)) {
                _hideColById(_nextColToHide);
                _nextColToHide++;
            }

            if(this.x < -(_level.width * 76)) {
                dispatchEvent(new GameEvent(GameEvent.COMPLETE));
            }
        }

        private function _showColById(id:int):void {
            //trace("Show col n°"+id);

            var rowCPT:int = 0;

            _colsShowed[id] =  new Array();

            // AFFICHAGE DE CHAQUE LIGNE DE LA COLONNE "ID"
            for each(var row:int in _level.layers[0].data[id]) {
                if(row == 3) {
                    var tile = _pointFactory.getPoint();
                    _colsShowed[id].push(tile);
                }
                else if(row != 0) {
                    //var tile:Tile = new Tile();
                }

                if(tile) {
                    addChild(tile);
                    tile.x = (id % _level.layers[0].width) * _level.tilewidth;
                    tile.y = (rowCPT % _level.layers[0].height) * _level.tilewidth;
                }

                rowCPT++;
            }
        }

        private function _hideColById(id:int):void {
            //trace("Hide col n°"+id);

            var rowCPT = 0;
            for each(var row:Tile in _colsShowed[id]) {
                if(row is Point) {
                    _pointFactory.storePoint(_colsShowed[id][rowCPT]);
                    _colsShowed[id].splice(rowCPT, 1);
                }

                rowCPT++;
            }
        }

        public function play():void {
            Starling.juggler.add(this);
        }

        public function pause():void {
            Starling.juggler.remove(this);
        }
    }
}
