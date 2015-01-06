/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
    import flash.geom.Rectangle;

    import fr.gobelins.workshop.constants.Settings;
    import fr.gobelins.workshop.events.CollisionEvent;
    import fr.gobelins.workshop.events.GameEvent;
    import fr.gobelins.workshop.game.IGameEntity;
    import fr.gobelins.workshop.game.character.Character;
    import fr.gobelins.workshop.game.level.entities.AObstacle;
    import fr.gobelins.workshop.game.level.entities.Bonus;
    import fr.gobelins.workshop.game.level.entities.Roche;
    import fr.gobelins.workshop.game.level.entities.Lave;
    import fr.gobelins.workshop.game.level.entities.ObstacleAir;
    import fr.gobelins.workshop.game.level.entities.Point;
    import fr.gobelins.workshop.game.level.entities.factories.BonusFactory;
    import fr.gobelins.workshop.game.level.entities.factories.RocheFactory;
    import fr.gobelins.workshop.game.level.entities.factories.LaveFactory;
    import fr.gobelins.workshop.game.level.entities.factories.ObstacleAirFactory;
    import fr.gobelins.workshop.game.level.entities.factories.PointFactory;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Sprite;

    public class Map extends Sprite implements IAnimatable, IGameEntity {

        // PRIMARY ATTRIBUTES
        private var _level:Object;
        private var _player:Character = null;

        // FACTORIES
        private var _pointFactory:PointFactory;
        private var _bonusFactory:BonusFactory;
        private var _obstacleAirFactory:ObstacleAirFactory;
        private var _laveFactory:LaveFactory;
        private var _rocheFactory:RocheFactory;

        // POOLING COLS
        private var _colsShowed:Array;
        private var _nextColToShow:int = 0;
        private var _nextColToHide:int = 0;
        private var _nextColToCheckCollisions:int = 0;
        private var _lastColToCheckCollisions:int = 0;

        public function Map(level:Object = null) {
            super();
            _level = level;

            // Init the factories
            _pointFactory = new PointFactory(27);
            _bonusFactory = new BonusFactory();
            _obstacleAirFactory = new ObstacleAirFactory(10);
            _laveFactory = new LaveFactory(10);
            _rocheFactory = new RocheFactory(10);
            // TODO Possibilité d'optimisation des factories

            // Init our array of tiles cols showed
            _colsShowed = new Array();
        }

        public function advanceTime(time:Number):void {
            // We move the map by 640 pixels / sec
            this.x -= (Settings.APP_WIDTH / Settings.SECOND_PLAN_SPEED) * time;

            _updateColsToWatch();
            if(_player) _checkCollisions();
        }

        private function _updateColsToWatch():void {
            if(_nextColToShow <= _level.width && this.x + ( _level.tilewidth * _nextColToShow ) < stage.stageWidth + _level.tilewidth) {
                _showColById(_nextColToShow);
                _nextColToShow++;
            }

            if(_nextColToHide <= _level.width && this.x + ( _level.tilewidth * _nextColToHide) < (- _level.tilewidth)) {
                _hideColById(_nextColToHide);
                _nextColToHide++;
            }

            if(this.x < -(_level.width * _level.tilewidth)) {
                dispatchEvent(new GameEvent(GameEvent.COMPLETE));
            }
        }

        private function _showColById(id:int):void {
            //trace("Show col n°"+id);

            var rowCPT:int = 0;

            _colsShowed[id] =  new Array();

            var tile:Tile;

            // AFFICHAGE DE CHAQUE LIGNE DE LA COLONNE "ID"
            for each(var row:int in _level.layers[0].data[id]) {

                tile = _getTile(row);

                if(tile) {
                    _colsShowed[id].push(tile);
                    addChild(tile);
                    tile.x = (id % _level.layers[0].width) * _level.tilewidth;
                    tile.y = (rowCPT % _level.layers[0].height) * _level.tilewidth;
                }

                rowCPT++;
            }
        }

        private function _hideColById(id:int):void {

            var rowCPT:int = 0;
            for each(var row:Tile in _colsShowed[id]) {
                _storeTile(_colsShowed[id].splice(_colsShowed[id].indexOf(row),1)[0]);
                rowCPT++;
            }

            delete _colsShowed[id];
        }

        private function _checkCollisions():void {
            // CHECK UNIQUEMENT LES TILES DANS LA ZONE OU LES COLLISIONS SONT POSSIBLES
            var hitboxPlayer:Rectangle = new Rectangle(_player.x + player.hitbox.x, _player.y + _player.hitbox.y, _player.hitbox.width, _player.hitbox.height);

            if(hitboxPlayer) {
                // ON DETERMINE LA COLONNE A CHECKER LA PLUS A DROITE
                if (this.x + (_nextColToCheckCollisions * _level.tilewidth) <= (hitboxPlayer.x + hitboxPlayer.width)) {
                    _nextColToCheckCollisions++;
                }
                // ON DETERMINE LA COLONNE A CHECKER LA PLUS A GAUCHE
                if (this.x + (_lastColToCheckCollisions * _level.tilewidth) <= (hitboxPlayer.x - hitboxPlayer.width)) {
                    _lastColToCheckCollisions++;
                }

                // ON CHECK LES COLLISIONS DE TOUTES LES TILES ENTRE CES COLONNES
                for (var i:int = _lastColToCheckCollisions; i < _nextColToCheckCollisions; i++) {
                    for each(var row:Tile in _colsShowed[i]) {
                        var hitboxRow:Rectangle = new Rectangle(this.x + row.x, this.y + row.y, row.width, row.height);

                        if (hitboxPlayer.intersects(hitboxRow)) {
                            dispatchEvent(new CollisionEvent(CollisionEvent.COLLISION, row));
                        }
                    }
                }
            }
        }

        private function _getTile(tileID:int):Tile {
            switch(tileID) {
                case 5:
                    return _obstacleAirFactory.getObstacle();
                    break;
                case 4:
                    return _bonusFactory.getBonus();
                    break;
                case 3:
                    return _pointFactory.getPoint();
                    break;
                case 2:
                    return _rocheFactory.getItem();
                    break;
                case 1:
                    return _laveFactory.getItem();
                    break;
                default:
                    // NOTHING BUT AIR
                    return null;
                    break;
            }
        }

        private function _storeTile(tile:Tile):void {
            switch(tile.id) {
                case 5:
                    _obstacleAirFactory.storeObstacle(tile as ObstacleAir);
                    break;
                case 4:
                    _bonusFactory.storeBonus(tile as Bonus);
                    break;
                case 3:
                    _pointFactory.storePoint(tile as Point);
                    break;
                case 2:
                    _rocheFactory.storeItem(tile as Roche);
                    break;
                case 1:
                    _laveFactory.storeItem(tile as Lave);
                    break;
                default:
                    // NOTHING
                    break;
            }

            removeChild(tile, true);
        }

        public function play():void {
            Starling.juggler.add(this);
        }

        public function pause():void {
            Starling.juggler.remove(this);
        }

        public function get player():Character {
            return _player;
        }

        public function set player(value:Character):void {
            _player = value;
        }

        public function set level(value:Object):void {
            _level = value;

            // Quick hack to put a bonus at the beginning of the level
            _level.layers[0].data[20][4] = 4;
        }

        public function get level():Object {
            return _level;
        }
    }
}
