/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.PageID;
    import fr.gobelins.workshop.events.PagesEvent;
    import fr.gobelins.workshop.game.GameManager;
    import fr.gobelins.workshop.util.Tutorial;
    import fr.gobelins.workshop.events.TutorialEvent;

    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.Event;

    public class GamePage extends APage {

        private var _tutorial:Sprite;
        private var _gameManager:GameManager;

        public function GamePage() {
            super();
        }

        protected override function _init():void {
            // GAME
            _gameManager = new GameManager(this);
            _gameManager.pause();

            var btnHighScores : Button = new Button(App.assets.getTexture("btnHighScores"));
            btnHighScores.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHighScores.width / 2);
            btnHighScores.y = stage.stageHeight / 2 + 200;
            btnHighScores.addEventListener(Event.TRIGGERED, _onHighScoresTriggered);
            addChild(btnHighScores);

            // ####### TUTORIAL
            _tutorial = new Tutorial();
            _tutorial.x = 0; _tutorial.y = 0;
            _tutorial.addEventListener(TutorialEvent.TUTORIAL_SKIPPED, _onSkip);
            addChild(_tutorial);

        }

        private function _onSkip(event:Event):void {
            removeChild(_tutorial);
            _gameManager.play();
        }

        private function _onHighScoresTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HIGHSCORES));
        }
    }
}
