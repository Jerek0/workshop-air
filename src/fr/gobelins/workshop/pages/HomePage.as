/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {

import fr.gobelins.workshop.util.ParallaxBackground;

import starling.display.Button;

import starling.display.Image;
import starling.events.Event;
import starling.utils.AssetManager;

    public class HomePage extends APage {

        public function HomePage(assets:AssetManager) {
            super(assets);
        }

        protected override function _onAddedToStage(event:Event):void {
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

            var btnPlay : Button = new Button(_assets.getTexture("btnDemarrer"));
            btnPlay.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnPlay.width / 2);
            btnPlay.y = logo.y + logo.height + 100;
            btnPlay.addEventListener(Event.TRIGGERED, _onPlayTriggered);
            addChild(btnPlay);

            var btnHighScores : Button = new Button(_assets.getTexture("btnHighScores"));
            btnHighScores.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHighScores.width / 2);
            btnHighScores.y = btnPlay.y + btnPlay.height + 25;
            btnHighScores.addEventListener(Event.TRIGGERED, _onHighScoresTriggered);
            addChild(btnHighScores);
        }

        private function _onHighScoresTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.HOME_TO_HIGHSCORES));
        }

        private function _onPlayTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.HOME_TO_PLAY));
        }
    }
}
