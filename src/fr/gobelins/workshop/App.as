/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop {
    import flash.filesystem.File;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.net.URLRequest;

import fr.gobelins.workshop.constants.Settings;
    import fr.gobelins.workshop.pages.PageManager;
    import fr.gobelins.workshop.util.ProgressBar;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    public class App extends Sprite {

        private static var _assets:AssetManager;
        private var _pageManager:PageManager;

        [Embed(source="../../../../bin/medias/splashScreen.png")]
        private static const SplashScreen:Class;

        [Embed(source="../../../../bin/medias/fonts/Cubano.ttf", embedAsCFF="false", fontFamily="Cubano")]
        private static const Cubano:Class;

        public function App() {
            super();
        }

        public function init(isHD:int):void {

            var mediasFolder : File;

            //if(isHD == 2) mediasFolder = File.applicationDirectory.resolvePath('medias/hd');
            //else mediasFolder = File.applicationDirectory.resolvePath('medias/sd');

            mediasFolder = File.applicationDirectory.resolvePath('medias');

            _assets = new AssetManager();

            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorNormal.png"));
            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorNormal.xml"));
            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorFly.png"));
            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorFly.xml"));
            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorMoon.png"));
            _assets.enqueue(mediasFolder.resolvePath("raptor/RaptorMoon.xml"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/ElementsGameplay.png"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/ElementsGameplay.xml"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/Backgrounds.png"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/Backgrounds.xml"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/userInterface.png"));
            _assets.enqueue(mediasFolder.resolvePath("spritesheets/userInterface.xml"));


            var splashScreen:Image = new Image(Texture.fromBitmap(new SplashScreen()));
            var ratio = splashScreen.width / splashScreen.height;
            splashScreen.width = Settings.APP_WIDTH;
            splashScreen.height = splashScreen.width / ratio;
            splashScreen.x = 0;
            splashScreen.y = 0;
            addChild(splashScreen);

            var loading:ProgressBar = new ProgressBar(200, 20, 0xFFFFFF, 0x666666);
            addChild(loading);
            loading.alpha = 0.2;
            loading.x = stage.stageWidth / 2 - loading.width / 2;
            loading.y = stage.stageHeight - loading.height - 100;

            _assets.loadQueue(function(ratio:Number):void {
                trace("Loading assets, progress:", ratio);

                loading.percentage = ratio;

                if(ratio >= 1.0) {
                    removeChild(loading, true);
                    removeChild(splashScreen, true);
                    loading = null;
                    splashScreen = null;
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
