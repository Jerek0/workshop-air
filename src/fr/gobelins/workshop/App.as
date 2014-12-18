/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop {

import flash.filesystem.File;

import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.utils.AssetManager;

public class App extends Sprite {

        private var _assets:AssetManager;

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


            var loading:Quad = new Quad(1, stage.stageHeight, 0x333333);
            loading.x = 0; loading.y = 0;
            addChild(loading);

            _assets.loadQueue(function(ratio:Number):void {
                trace("Loading assets, progress:", ratio);

                loading.width = stage.stageWidth*ratio;

                if(ratio == 1.0) {
                    removeChild(loading);
                    _build();
                }
            });
        }

        private function _build():void {
            
            var background : Image = new Image(_assets.getTexture("background"));
            addChild(background);

            var farestPlan : ParallaxBackground = new ParallaxBackground(_assets.getTexture("farestPlan"), 18);
            addChild(farestPlan);

            var thirdPlan : ParallaxBackground = new ParallaxBackground(_assets.getTexture("thirdPlan"),6);
            addChild(thirdPlan);

            var secondPlan : ParallaxBackground = new ParallaxBackground(_assets.getTexture("secondPlan"), 2);
            addChild(secondPlan);

            var logo : Image = new Image(_assets.getTexture("logo"));
            logo.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (logo.width / 2);
            logo.y = 100;
            addChild(logo);
        }
    }
}
