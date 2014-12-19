/**
 * Created by jerek0 on 16/12/2014.
 */
package fr.gobelins.workshop.util.slider {
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;

public class Dot extends Sprite {

    private var _view:Image;

    public function Dot(texture:Texture) {
        super();

        _view = new Image(texture);
        addChild(_view);
    }

    public function get view():Image {
        return _view;
    }
}
}
