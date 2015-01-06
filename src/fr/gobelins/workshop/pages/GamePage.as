/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
import feathers.controls.TextInput;

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;

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
import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;
    import starling.text.TextField;

    public class GamePage extends APage {

        private var _tutorial:Tutorial;
        private var _game:Game;

        private var _pause:Popup;
        private var _gameOver:Popup;

        private var _overlay:Quad;

        private var _pseudoInput:TextInput;

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
            _pause = new Popup("", App.assets.getTextureAtlas("Backgrounds").getTexture("BgPauseGameOver"));

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

        private function _onTutorialSkip(event:starling.events.Event):void {
            removeChild(_tutorial, true);
            _tutorial.removeEventListener(TutorialEvent.TUTORIAL_SKIPPED, _onTutorialSkip);
            _tutorial = null;

            Settings.show_tutorial = false;
            _game.play();
        }

        private function _onPause(event:starling.events.Event):void {
            _game.pause();

            _overlay = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            _overlay.alpha = 0.8;
            _overlay.x = 0; _overlay.y = 0;
            addChild(_overlay);

            addChild(_pause);
            _pause.x = (stage.stageWidth / 2) - (_pause.width / 2);
            _pause.y = (stage.stageHeight / 2) - (_pause.height / 2);

            var btnHome : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("home-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("home-btn-active"));
            btnHome.x = _pause.width - btnHome.width - 50;
            btnHome.y = _pause.height - btnHome.height - 50;
            btnHome.addEventListener(starling.events.Event.TRIGGERED, _onHomeTriggered);
            _pause.addChild(btnHome);

            var btnRetry : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("retry-btn"), "",App.assets.getTextureAtlas("userInterface").getTexture("retry-btn-active"));
            btnRetry.x = 50;
            btnRetry.y = _pause.height - btnRetry.height - 50;
            btnRetry.addEventListener(starling.events.Event.TRIGGERED, _onRetryTriggered);
            _pause.addChild(btnRetry);

            var btnResume : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("resume-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("resume-btn-active"));
            btnResume.x = _pause.width / 2 - btnResume.width / 2;
            btnResume.y = 50;
            btnResume.addEventListener(starling.events.Event.TRIGGERED, _onResumeTriggered);
            _pause.addChild(btnResume);

            var scoreLibelle:Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("yourscore"));
            scoreLibelle.x = _pause.width / 2 - scoreLibelle.width / 2;
            scoreLibelle.y = 210;
            _pause.addChild(scoreLibelle);

            var score:TextField = new TextField(_pause.width, 140, ""+_game.score, Settings.FONT);
            score.x = _pause.width / 2 - score.width / 2;
            score.y = 280;
            score.color = 0xFFFFFF;
            score.fontSize = 140;
            _pause.addChild(score);
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

            var title:Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("gameover"));
            _gameOver.addChild(title);
            title.x = _gameOver.width / 2 - _gameOver.width / 4 - title.width / 2;
            title.y = 30;

            var logo : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("logo"));
            var logoRatio:Number = logo.width / logo.height;
            _gameOver.addChild(logo);
            logo.width = (_gameOver.width / 2) - 180;
            logo.height = logo.width / logoRatio;
            logo.y = title.y + title.height;
            logo.x = (_gameOver.width / 2) - (_gameOver.width / 4) - (logo.width / 2);

            var scoreLibelle:Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("yourscore"));
            _gameOver.addChild(scoreLibelle);
            scoreLibelle.x = _gameOver.width / 2 + _gameOver.width / 4 - scoreLibelle.width / 2;
            scoreLibelle.y = 30;

            var score:TextField = new TextField(_gameOver.width / 2, 140, ""+_game.score, Settings.FONT);
            score.x = _gameOver.width / 2;
            score.y = 100;
            score.color = 0xFFFFFF;
            score.fontSize = 140;
            _gameOver.addChild(score);

            var btnRetry : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("retry-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("retry-btn-active"));
            btnRetry.x = 50;
            btnRetry.y = _gameOver.height - btnRetry.height - 50;
            btnRetry.addEventListener(starling.events.Event.TRIGGERED, _onRetryTriggered);
            _gameOver.addChild(btnRetry);

            var btnShare : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("share-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("share-btn-active"));
            btnShare.x = _gameOver.width - btnShare.width - 50;
            btnShare.y = _gameOver.height - btnShare.height - 50;
            btnShare.addEventListener(starling.events.Event.TRIGGERED, _onShareTriggered);
            _gameOver.addChild(btnShare);

            _pseudoInput = new TextInput();
            _pseudoInput.backgroundSkin = new Image(App.assets.getTextureAtlas("Backgrounds").getTexture("FondPseudo"));
            _pseudoInput.text = "Enter your name";
            _pseudoInput.padding = 40;
            _pseudoInput.textEditorProperties.fontFamily = Settings.FONT;
            _pseudoInput.textEditorProperties.fontSize = 32;
            /*input.selectRange( 0, input.text.length );
             input.addEventListener( Event.CHANGE, input_changeHandler );*/
            _gameOver.addChild(_pseudoInput);
            _pseudoInput.x = _gameOver.width - btnShare.width - 50;
            _pseudoInput.y = _gameOver.height - (btnShare.height * 2) - 100;

        }

        private function _onHomeTriggered(event:starling.events.Event):void {
            _game.pause();
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HOME));
        }

        private function _onShareTriggered(event:starling.events.Event):void {
            if(_pseudoInput.text != "Enter your name") {
                _game.pause();

                var urlRequest:URLRequest = new URLRequest("http://www.cordechasse.fr/gobelins/CRM14/scripts/setScore.php");
                var requestVars:URLVariables = new URLVariables();
                requestVars.project_name = "RaptoRun";
                requestVars.user_name = _pseudoInput.text;
                requestVars.score = _game.score;
                urlRequest.data = requestVars;
                urlRequest.method = URLRequestMethod.POST;

                var urlLoader : URLLoader = new URLLoader();
                urlLoader.load(urlRequest);
                urlLoader.addEventListener(flash.events.Event.COMPLETE, function():void {
                    dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HIGHSCORES));
                });
            } else {
                _pseudoInput.setFocus();
            }
        }

        private function _onResumeTriggered(event:starling.events.Event):void {
            removeChild(_pause);
            removeChild(_overlay);
            _pause.removeChildren();

            _game.play();
        }

        private function _onRetryTriggered(event:starling.events.Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.GAME));
        }
    }
}
