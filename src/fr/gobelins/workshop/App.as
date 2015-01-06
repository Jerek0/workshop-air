/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop {
    import flash.filesystem.File;

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

            // UI LOADING
            var splashScreen:Image = new Image(Texture.fromBitmap(new SplashScreen()));
            var ratio:Number = splashScreen.width / splashScreen.height;
            splashScreen.width = Settings.APP_WIDTH;
            splashScreen.height = splashScreen.width / ratio;
            splashScreen.x = 0;
            splashScreen.y = 0;
            addChild(splashScreen);

            var loading:ProgressBar = new ProgressBar(600, 10, 0xFFFFFF, 0x666666);
            addChild(loading);
            loading.alpha = 0.2;
            loading.x = stage.stageWidth / 2 - loading.width / 2;
            loading.y = stage.stageHeight - loading.height - 130;

            // ASSETS MANAGEMENT
            var mediasFolder : File;
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
            _assets.loadQueue(function(ratio:Number):void {
                trace("Loading assets, progress:", ratio);

                // Update the progress bar
                loading.percentage = ratio;

                // When loading done
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
