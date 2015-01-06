/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import fr.gobelins.workshop.App;
import fr.gobelins.workshop.constants.PageID;
import fr.gobelins.workshop.constants.Settings;
import fr.gobelins.workshop.events.PagesEvent;

import starling.display.Button;
    import starling.events.Event;
    import starling.text.TextField;

    public class HighScoresPage extends APage {
        public function HighScoresPage() {
            super();
        }

        protected override function _init():void {
            // ##### TEMPORARY
            var text:TextField = new TextField(stage.stageWidth, 100, "HIGHSCORES PAGE", Settings.FONT);
            text.y = stage.stageHeight / 2 - text.height / 2;
            text.color = 0xFFFFFF;
            text.fontSize = 48;
            addChild(text);

            var btnHome : Button = new Button(App.assets.getTexture("btnHome"));
            btnHome.x = (stage.stageWidth / 4) + (stage.stageWidth/2) - (btnHome.width / 2);
            btnHome.y = text.y + text.height + 100;
            btnHome.addEventListener(Event.TRIGGERED, _onHomeTriggered);
            addChild(btnHome);
        }

        private function _onHomeTriggered(event:Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HOME));
        }
    }
}
