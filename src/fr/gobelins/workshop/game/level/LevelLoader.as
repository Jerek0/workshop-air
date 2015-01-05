/**
 * Created by jerek0 on 02/01/2015.
 */
package fr.gobelins.workshop.game.level {
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import fr.gobelins.workshop.events.LevelLoaderEvent;

import starling.events.EventDispatcher;

public class LevelLoader extends EventDispatcher{
    private var _urlLoader:URLLoader;
    private var _data:Object;
    private var _map:Array;

    public function LevelLoader(mapToLoad:String) {
        // TODO Hériter de URLLoader plutot
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

        _data.layers[0].data = _map;
        // TODO Optim _map

        this.dispatchEvent(new LevelLoaderEvent(LevelLoaderEvent.LEVEL_LOADED, _data));
    }
}
}
