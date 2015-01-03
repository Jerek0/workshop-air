/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop {

import flash.filesystem.File;

import fr.gobelins.workshop.pages.PageManager;

import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class App extends Sprite {

        private static var _assets:AssetManager;
        private var _pageManager:PageManager;

        public function App() {
            super();
        }

        public function init(isHD:int):void {

            var mediasFolder : File;

            //if(isHD == 2) mediasFolder = File.applicationDirectory.resolvePath('medias/hd');
            //else mediasFolder = File.applicationDirectory.resolvePath('medias/sd');

            mediasFolder = File.applicationDirectory.resolvePath('medias');

            _assets = new AssetManager();

            _assets.enqueue(mediasFolder.resolvePath("background.png"));
            _assets.enqueue(mediasFolder.resolvePath("secondPlan.png"));
            _assets.enqueue(mediasFolder.resolvePath("thirdPlan.png"));
            _assets.enqueue(mediasFolder.resolvePath("farestPlan.png"));
            _assets.enqueue(mediasFolder.resolvePath("logo.png"));
            _assets.enqueue(mediasFolder.resolvePath("btnDemarrer.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnHighScores.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnPause.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnHome.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnSkip.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnRetry.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("btnResume.jpg"));
            _assets.enqueue(mediasFolder.resolvePath("slide001.png"));
            _assets.enqueue(mediasFolder.resolvePath("slide002.png"));
            _assets.enqueue(mediasFolder.resolvePath("slide003.png"));
            _assets.enqueue(mediasFolder.resolvePath("dotInactive.png"));
            _assets.enqueue(mediasFolder.resolvePath("dotActive.png"));
            _assets.enqueue(mediasFolder.resolvePath("bkgPopup.png"));

            _assets.enqueue(mediasFolder.resolvePath("dino.png"));
            _assets.enqueue(mediasFolder.resolvePath("dino.xml"));


            var loading:Quad = new Quad(1, stage.stageHeight, 0x333333);
            loading.x = 0; loading.y = 0;
            addChild(loading);

            _assets.loadQueue(function(ratio:Number):void {
                trace("Loading assets, progress:", ratio);

                loading.width = stage.stageWidth*ratio;

                if(ratio >= 1.0) {
                    removeChild(loading, true);
                    loading = null;
                    _build();
                }
            });
        }

        private function _build():void {
            _pageManager = new PageManager(this);
        }

    public static function get assets():AssetManager {
        return _assets;
    }
}
}
