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
            _assets.enqueue(mediasFolder.resolvePath("btnDemarrer.png"));
            _assets.enqueue(mediasFolder.resolvePath("btnDemarrerDown.png"));
            _assets.enqueue(mediasFolder.resolvePath("btnHighScores.png"));
            _assets.enqueue(mediasFolder.resolvePath("btnHighScoresDown.png"));
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
            _assets.enqueue(mediasFolder.resolvePath("bkgWindowCasino.png"));
            _assets.enqueue(mediasFolder.resolvePath("bkgLauncherCasino.png"));
            _assets.enqueue(mediasFolder.resolvePath("tireuseUp.png"));
            _assets.enqueue(mediasFolder.resolvePath("tireuseDown.png"));
            _assets.enqueue(mediasFolder.resolvePath("normal.png"));
            _assets.enqueue(mediasFolder.resolvePath("redBull.png"));
            _assets.enqueue(mediasFolder.resolvePath("astro.png"));

            _assets.enqueue(mediasFolder.resolvePath("RaptorNormal.png"));
            _assets.enqueue(mediasFolder.resolvePath("RaptorNormal.xml"));
            _assets.enqueue(mediasFolder.resolvePath("pieces.png"));
            _assets.enqueue(mediasFolder.resolvePath("pieces.xml"));


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
