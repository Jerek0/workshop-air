/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import starling.display.Sprite;
    import starling.events.Event;
import starling.utils.AssetManager;

    public class APage extends Sprite {

        protected var _assets:AssetManager;

        public function APage(assets:AssetManager) {
            super();

            _assets = assets;
            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, _onRemovedFromStage);
        }

        private function _onRemovedFromStage(event:Event):void {
            removeChildren();
        }

        protected function _onAddedToStage(event:Event):void { }
    }
}
