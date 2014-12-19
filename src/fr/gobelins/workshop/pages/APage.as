/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
import fr.gobelins.workshop.App;

import starling.display.Sprite;
    import starling.events.Event;
    import starling.utils.AssetManager;

    public class APage extends Sprite {

        public function APage() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
        }

        private function _onRemovedFromStage(event:Event):void {
            removeChildren();
        }

        protected function _onAddedToStage(event:Event):void { }
    }
}
