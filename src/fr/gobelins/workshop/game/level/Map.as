/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game.level {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.display.Sprite;
import starling.events.Event;

public class Map extends Sprite {
    private var _urlLoader:URLLoader;
    private var _data:Object;

    private var _map:Array;

        public function Map(mapToLoad:String) {
            super();

            var urlRequest : URLRequest = new URLRequest(mapToLoad);
            _urlLoader = new URLLoader();
            _urlLoader.addEventListener(flash.events.Event.COMPLETE, _onComplete);
            _urlLoader.load(urlRequest);
        }

        private function _onComplete(event:flash.events.Event):void {
            _data = JSON.parse(_urlLoader.data);

            // INITIALISATION DU TABLEAU
            _map = new Array(_data.layers[0].width);
            for(var i:int = 0; i < _map.length; i++)
                _map[i] = new Array();

            // REMPLISSAGE DU TABLEAU
            var col:int = 0;
            for(var i:int = 0; i < _data.layers[0].data.length; i++) {
                col = i % _data.layers[0].width;
                _map[col].push(_data.layers[0].data[i]);
            }

            _show();
        }

    private function _show():void {
        var colCPT = 0;
        var rowCPT = 0;
        for each(var col:Array in _map) {
            for each(var id:int in col) {
                var tile = new Tile(id);
                addChild(tile);
                tile.x = (colCPT % _data.layers[0].width) * _data.tilewidth;
                tile.y = (rowCPT % _data.layers[0].height) * _data.tilewidth;
                rowCPT++;
            }
            rowCPT = 0;
            colCPT++;
            if(colCPT > 18) break;
        }
    }
    }
}
