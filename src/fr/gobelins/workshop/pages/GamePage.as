/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.PageID;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.GameEvent;
    import fr.gobelins.workshop.events.PagesEvent;
    import fr.gobelins.workshop.game.Game;
    import fr.gobelins.workshop.util.Popup;
    import fr.gobelins.workshop.util.Tutorial;
    import fr.gobelins.workshop.events.TutorialEvent;

    import starling.display.Button;
import starling.display.Quad;
import starling.events.Event;
    import starling.text.TextField;

    public class GamePage extends APage {

        private var _tutorial:Tutorial;
        private var _game:Game;

        private var _pause:Popup;
        private var _gameOver:Popup;

        private var _overlay:Quad;

        public function GamePage() {
            super();
        }

        protected override function _init():void {
            // GAME
            _game = new Game();
            addChild(_game);
            _game.play();

            // TODO OPTIM PAUSE GAMEOVER TUTO
            // ####### TUTORIAL
            if(Settings.show_tutorial) _showTutorial();

            // ####### MENU PAUSE
            _pause = new Popup("Pause", App.assets.getTextureAtlas("Backgrounds").getTexture("BgPauseGameOver"));

            // ###### GAME OVER
            _gameOver = new Popup("", App.assets.getTextureAtlas("Backgrounds").getTexture("BgPauseGameOver"));
            _game.addEventListener(GameEvent.GAME_OVER, _onGameOver);
            _game.addEventListener(GameEvent.COMPLETE, _onGameOver);
            _game.addEventListener(GameEvent.PAUSE, _onPause);
        }

        private function _showTutorial():void {
            _tutorial = new Tutorial();
            _tutorial.x = 0; _tutorial.y = 0;
            _game.pause();
            addChild(_tutorial);
            _tutorial.addEventListener(TutorialEvent.TUTORIAL_SKIPPED, _onTutorialSkip);
        }

        private function _onTutorialSkip(event:Event):void {
            removeChild(_tutorial, true);
            _tutorial.removeEventListener(TutorialEvent.TUTORIAL_SKIPPED, _onTutorialSkip);
            _tutorial = null;

            Settings.show_tutorial = false;
            _game.play();
        }

        private function _onPause(event:Event):void {
            _game.pause();

            _overlay = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            _overlay.alpha = 0.8;
            _overlay.x = 0; _overlay.y = 0;
            addChild(_overlay);

            addChild(_pause);
            _pause.x = (stage.stageWidth / 2) - (_pause.width / 2);
            _pause.y = (stage.stageHeight / 2) - (_pause.height / 2);

            var btnHome : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("home-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("home-btn-active"));
            btnHome.x = _pause.width - btnHome.width - 20;
            btnHome.y = _pause.height - btnHome.height - 20;
            btnHome.addEventListener(Event.TRIGGERED, _onHomeTriggered);
            _pause.addChild(btnHome);

            var btnRetry : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("retry-btn"), "",App.assets.getTextureAtlas("userInterface").getTexture("retry-btn-active"));
            btnRetry.x = 20;
            btnRetry.y = _pause.height - btnRetry.height - 20;
            btnRetry.addEventListener(Event.TRIGGERED, _onRetryTriggered);
            _pause.addChild(btnRetry);

            var btnResume : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("resume-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("resume-btn-active"));
            btnResume.x = _pause.width / 2 - btnResume.width / 2;
            btnResume.y = 100;
            btnResume.addEventListener(Event.TRIGGERED, _onResumeTriggered);
            _pause.addChild(btnResume);
        }

        private function _onGameOver(event:GameEvent):void {
            _game.pause();

            _overlay = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            _overlay.alpha = 0.8;
            _overlay.x = 0; _overlay.y = 0;
            addChild(_overlay);

            addChild(_gameOver);
            _gameOver.x = (stage.stageWidth / 2) - (_gameOver.width / 2);
            _gameOver.y = (stage.stageHeight / 2) - (_gameOver.height / 2);

            var score:TextField = new TextField(_gameOver.width, 100, ""+_game.score, Settings.FONT);
            score.x = _gameOver.width / 2 - score.width / 2;
            score.y = 100;
            score.color = 0xFFFFFF;
            score.fontSize = 96;
            _gameOver.addChild(score);

            var btnRetry : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("retry-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("retry-btn-active"));
            btnRetry.x = 20;
            btnRetry.y = _gameOver.height - btnRetry.height - 20;
            btnRetry.addEventListener(Event.TRIGGERED, _onRetryTriggered);
            _gameOver.addChild(btnRetry);

            var btnHighScores : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("highscore-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("highscore-btn-active"));
            btnHighScores.x = _gameOver.width - btnHighScores.width - 20;
            btnHighScores.y = _gameOver.height - btnHighScores.height - 20;
            btnHighScores.addEventListener(Event.TRIGGERED, _onHighScoresTriggered);
            _gameOver.addChild(btnHighScores);

        }

        private function _onHomeTriggered(event:Event):void {
            _game.pause();
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HOME));
        }

        private function _onHighScoresTriggered(event:Event):void {
            _game.pause();
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HIGHSCORES));
        }

        private function _onResumeTriggered(event:Event):void {
            removeChild(_pause);
            removeChild(_overlay);
            _pause.removeChildren();

            _game.play();
        }

        private function _onRetryTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.GAME));
        }
    }
}
