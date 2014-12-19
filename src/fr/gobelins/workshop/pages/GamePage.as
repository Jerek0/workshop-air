/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
import fr.gobelins.workshop.slider.DotsContainer;
import fr.gobelins.workshop.slider.Slider;

import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Quad;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

    public class GamePage extends APage {

        private var _tutoriel:Slider;
        private var _dots:DotsContainer;

        public function GamePage(assets:AssetManager) {
            super(assets);
        }

        protected override function _onAddedToStage(event:Event):void {
            var text:TextField = new TextField(stage.stageWidth, 100, "GAME PAGE");
            text.y = stage.stageHeight / 2 - text.height / 2;
            text.color = 0xFFFFFF;
            text.fontSize = 48;
            addChild(text);

            var btnHighScores : Button = new Button(_assets.getTexture("btnHighScores"));
            btnHighScores.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHighScores.width / 2);
            btnHighScores.y = text.y + text.height + 100;
            btnHighScores.addEventListener(Event.TRIGGERED, _onHighScoresTriggered);
            addChild(btnHighScores);

            _tutoriel = new Slider(stage.stageWidth);
                _tutoriel.addSlide(new Image(_assets.getTexture("slide001")));
                _tutoriel.addSlide(new Image(_assets.getTexture("slide002")));
                _tutoriel.addSlide(new Image(_assets.getTexture("slide003")));
                _tutoriel.x = 0;
                _tutoriel.y = stage.stageHeight / 2 - _tutoriel.height / 2;

                var overlay:Quad = new Quad(_tutoriel.width+200, stage.stageHeight, 0x000000);
                overlay.alpha = 0.8;
                overlay.x = 0; overlay.y = 0;
                _tutoriel.addChildAt(overlay, 0);
            addChild(_tutoriel);

            _dots = new DotsContainer(_tutoriel, _assets.getTexture("dotActive"),_assets.getTexture("dotInactive"));
            _dots.x = (stage.stageWidth / 2) - (_dots.width / 2);
            _dots.y = stage.stageHeight - _dots.height - 100;
            addChild(_dots);

            var btnSkip:Button = new Button(_assets.getTexture("btnSkip"));
            btnSkip.x = stage.stageWidth - btnSkip.width - 40;
            btnSkip.y = stage.stageHeight - btnSkip.height - 40;
            btnSkip.addEventListener(Event.TRIGGERED, _onSkip);
            addChild(btnSkip);
        }

        private function _onSkip(event:Event):void {
            removeChild(_tutoriel);
            removeChild(_dots);
            removeChild(event.currentTarget as DisplayObject);
        }

        private function _onHighScoresTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.GAME_TO_HIGHSCORES));
        }
    }
}
