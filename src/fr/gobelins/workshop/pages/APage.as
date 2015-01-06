/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import starling.display.Sprite;
    import starling.events.Event;

    public class APage extends Sprite {

        private var _isInitialised:Boolean;

        public function APage() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:starling.events.Event):void {
            if(!_isInitialised) {
                _init();
                _isInitialised = true;
            }
        }

        protected function _init():void {
            trace("Init APage");
        }
    }
}
