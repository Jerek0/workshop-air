/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
import starling.display.Button;
import starling.events.Event;
import starling.text.TextField;
import starling.utils.AssetManager;

    public class HighScoresPage extends APage {
        public function HighScoresPage(assets:AssetManager) {
            super(assets);
        }

        protected override function _onAddedToStage(event:Event):void {
            var text:TextField = new TextField(stage.stageWidth, 100, "HIGHSCORES PAGE");
            text.y = stage.stageHeight / 2 - text.height / 2;
            text.color = 0xFFFFFF;
            text.fontSize = 48;
            addChild(text);

            var btnHome : Button = new Button(_assets.getTexture("btnHome"));
            btnHome.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHome.width / 2);
            btnHome.y = text.y + text.height + 100;
            btnHome.addEventListener(Event.TRIGGERED, _onHomeTriggered);
            addChild(btnHome);
        }

        private function _onHomeTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.HIGHSCORES_TO_HOME));
        }
    }
}
