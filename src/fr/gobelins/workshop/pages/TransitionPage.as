/**
 * Created by jerek0 on 19/12/2014.
 */
package fr.gobelins.workshop.pages {
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
import starling.utils.deg2rad;

public class TransitionPage extends Sprite{
        public function TransitionPage() {
            super();

            addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
        }

        private function _onAddedToStage(event:Event):void {
            var quad:Quad = new Quad(stage.stageWidth*4, stage.stageHeight*2, 0xFFFFFF);
            quad.x = 0;
            quad.y = stage.stageHeight;
            quad.rotation = deg2rad(45);
            addChild(quad);


            var tw : Tween = new Tween(quad, 0.5);
            tw.animate("y", -stage.stageHeight*10);
            Starling.juggler.add(tw);
        }
    }
}
