/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.util {
import fr.gobelins.workshop.App;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.TutorialEvent;
import fr.gobelins.workshop.util.slider.DotsContainer;
    import fr.gobelins.workshop.util.slider.Slider;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
import starling.text.TextField;

public class Tutorial extends Sprite {
        public function Tutorial() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            var overlay:Quad = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            overlay.alpha = 0.8;
            overlay.x = 0; overlay.y = 0;
            addChildAt(overlay, 0);

            var tutoriel:Slider = new Slider(stage.stageWidth);
            tutoriel.addSlide(new Image(App.assets.getTextureAtlas("userInterface").getTexture("StepOne")));
            tutoriel.addSlide(new Image(App.assets.getTextureAtlas("userInterface").getTexture("StepTwo")));
            tutoriel.addSlide(new Image(App.assets.getTextureAtlas("userInterface").getTexture("StepThree")));
            tutoriel.x = 0;
            tutoriel.y = stage.stageHeight / 2 - tutoriel.height / 2;
            addChild(tutoriel);

            var dots:DotsContainer = new DotsContainer(tutoriel, App.assets.getTextureAtlas("userInterface").getTexture("menu-active"),App.assets.getTextureAtlas("userInterface").getTexture("menu"));
            addChild(dots);
            dots.x = (stage.stageWidth / 2) - (dots.width / 2);
            dots.y = stage.stageHeight - dots.height - 40;

            var btnSkip:Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("go-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("go-btn-active"));
            btnSkip.x = stage.stageWidth - btnSkip.width - 40;
            btnSkip.y = stage.stageHeight - btnSkip.height - 40;
            btnSkip.addEventListener(Event.TRIGGERED, _onSkip);
            addChild(btnSkip);

            var title:TextField = new TextField(stage.stageWidth, 80, "How to play ?!", Settings.FONT);
            title.color = 0xFFFFFF;
            title.fontSize = 70;
            addChild(title);
            title.x = 0;
            title.y = 50;
        }

        private function _onSkip(event:Event):void {
            dispatchEvent(new TutorialEvent(TutorialEvent.TUTORIAL_SKIPPED));
        }
    }
}
