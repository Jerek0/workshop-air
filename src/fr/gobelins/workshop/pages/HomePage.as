/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {

import fr.gobelins.workshop.App;
import fr.gobelins.workshop.constants.PageID;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.PagesEvent;
import fr.gobelins.workshop.game.character.Character;
import fr.gobelins.workshop.util.ParallaxBackground;

import starling.display.Button;

import starling.display.Image;
import starling.events.Event;

    public class HomePage extends APage {

        public function HomePage() {
            super();
        }

        protected override function _init():void {

            // When we go on the home page, we want the next time the player plays to toggle tutorial
            Settings.show_tutorial = true;

            // ###### DECORS
            var background : Image = new Image(App.assets.getTextureAtlas("Backgrounds").getTexture("Fond"));
            addChild(background);

            var farestPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanFarest"), 18);
            farestPlan.y = 140;
            addChild(farestPlan);

            var thirdPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanThird"),6);
            thirdPlan.y = 240;
            addChild(thirdPlan);

            var secondPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanSecond"), 2);
            addChild(secondPlan);
            secondPlan.y = stage.stageHeight - secondPlan.height + 1;

            var character : Character = new Character();
            character.x = 200;
            addChild(character);
            character.size = 2.5;
            character.y = stage.stageHeight - character.height - 100;

            // ###### UI
            var logo : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("logo"));
            var ratio:Number = logo.width / logo.height;
            logo.width = 600;
            logo.height = logo.width / ratio;
            logo.x = (stage.stageWidth / 3) - (logo.width / 2);
            logo.y = 50;
            addChild(logo);

            var btnPlay : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("play-btn"),'',App.assets.getTexture("play-btn-active"));
            btnPlay.scaleWhenDown = 1;
            btnPlay.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnPlay.width / 2);
            btnPlay.y = 300;
            btnPlay.addEventListener(Event.TRIGGERED, _onPlayTriggered);
            addChild(btnPlay);

            var btnHighScores : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("highscore-btn"), '', App.assets.getTextureAtlas("userInterface").getTexture("highscore-btn-active"));
            btnHighScores.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHighScores.width / 2);
            btnHighScores.y = btnPlay.y + btnPlay.height + 25;
            btnHighScores.addEventListener(Event.TRIGGERED, _onHighScoresTriggered);
            addChild(btnHighScores);
        }

        private function _onHighScoresTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HIGHSCORES));
        }

        private function _onPlayTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.GAME));
        }
    }
}
