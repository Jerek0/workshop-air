/**
 * Created by jerek0 on 03/01/2015.
 */
package fr.gobelins.workshop.game.level.entities {
import fr.gobelins.workshop.App;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.events.Event;

public class Lave extends AObstacleSol {
    private var _body:MovieClip;

    public function Lave() {
        super();
        _id = 1;
    }

    protected override function _onAddedToStage(event:Event):void {
        var quad:Quad = new Quad(76,76,0xCC0000);
        quad.x=0;
        quad.y=0;
        quad.alpha = 0;
        addChild(quad);

        _body = new MovieClip(App.assets.getTextureAtlas("ElementsGameplay").getTextures("ObstacleLave"), 25);
        _body.x = quad.width / 2 - _body.width / 2;
        _body.y = quad.height / 2 - _body.height / 2;
        _body.loop = true;
        addChild(_body);

        _animate();
    }

    private function _animate():void {
        _body.play();
        Starling.juggler.add(_body);
    }
}
}
