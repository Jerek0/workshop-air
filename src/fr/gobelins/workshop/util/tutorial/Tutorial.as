/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.util.tutorial {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.util.slider.DotsContainer;
    import fr.gobelins.workshop.util.slider.Slider;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;

    public class Tutorial extends Sprite {
        public function Tutorial() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            var overlay = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
            overlay.alpha = 0.8;
            overlay.x = 0; overlay.y = 0;
            addChildAt(overlay, 0);

            var tutoriel = new Slider(stage.stageWidth);
            tutoriel.addSlide(new Image(App.assets.getTexture("slide001")));
            tutoriel.addSlide(new Image(App.assets.getTexture("slide002")));
            tutoriel.addSlide(new Image(App.assets.getTexture("slide003")));
            tutoriel.x = 0;
            tutoriel.y = stage.stageHeight / 2 - tutoriel.height / 2;
            addChild(tutoriel);

            var dots = new DotsContainer(tutoriel, App.assets.getTexture("dotActive"),App.assets.getTexture("dotInactive"));
            dots.x = (stage.stageWidth / 2) - (dots.width / 2);
            dots.y = stage.stageHeight - dots.height - 100;
            addChild(dots);

            var btnSkip:Button = new Button(App.assets.getTexture("btnSkip"));
            btnSkip.x = stage.stageWidth - btnSkip.width - 40;
            btnSkip.y = stage.stageHeight - btnSkip.height - 40;
            btnSkip.addEventListener(Event.TRIGGERED, _onSkip);
            addChild(btnSkip);
        }

        private function _onSkip(event:Event):void {
            dispatchEvent(new TutorialEvent(TutorialEvent.TUTORIAL_SKIPPED));
        }
    }
}
