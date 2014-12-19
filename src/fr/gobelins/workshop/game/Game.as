/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.game {
    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.util.ParallaxBackground;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    public class Game extends Sprite {

        public function Game() {
            super();

            this.addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {

            // ###### DECOR
            var background : Image = new Image(App.assets.getTexture("background"));
            addChild(background);

            var farestPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTexture("farestPlan"), 18);
            addChild(farestPlan);

            var thirdPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTexture("thirdPlan"),6);
            addChild(thirdPlan);

            var secondPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTexture("secondPlan"), 2);
            addChild(secondPlan);


            // ####### TEMPORARY
            var text:TextField = new TextField(stage.stageWidth, 100, "GAME MANAGER");
            text.y = stage.stageHeight / 2 - text.height / 2;
            text.color = 0xFFFFFF;
            text.fontSize = 48;
            addChild(text);
        }
    }
}
