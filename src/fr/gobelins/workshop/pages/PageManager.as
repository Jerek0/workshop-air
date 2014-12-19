/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import starling.display.Stage;
    import starling.events.EventDispatcher;
    import starling.utils.AssetManager;

    public class PageManager extends EventDispatcher {

        private var _stage:Stage;

        private var _homePage:APage;
        private var _gamePage:APage;
        private var _highScoresPage:APage;

        public function PageManager(stage:Stage) {
            super();

            _stage = stage;

            // HOME
            _homePage = new HomePage();
            _homePage.addEventListener(PagesEvent.HOME_TO_PLAY, _homeToPlay);
            _homePage.addEventListener(PagesEvent.HOME_TO_HIGHSCORES, _homeToHighScores);

            // GAME
            _gamePage = new GamePage();
            _gamePage.addEventListener(PagesEvent.GAME_TO_HIGHSCORES, _gameToHighScores);

            // HIGHSCORES
            _highScoresPage = new HighScoresPage();
            _highScoresPage.addEventListener(PagesEvent.HIGHSCORES_TO_HOME, _highScoresToHome);

            _stage.addChildAt(_homePage,0);
        }

        private function _gameToHighScores(event:PagesEvent):void {
            _stage.removeChild(_gamePage);
            _stage.addChildAt(_highScoresPage,0);
        }

        private function _homeToHighScores(event:PagesEvent):void {
            _stage.removeChild(_homePage);
            _stage.addChildAt(_highScoresPage,0);
        }

        private function _highScoresToHome(event:PagesEvent):void {
            _stage.removeChild(_highScoresPage);
            _stage.addChildAt(_homePage,0);
        }

        private function _homeToPlay(event:PagesEvent):void {
            _stage.removeChild(_homePage);
            _stage.addChildAt(_gamePage,0);
        }
    }
}
