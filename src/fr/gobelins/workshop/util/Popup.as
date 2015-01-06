/**
 * Created by jerek0 on 03/01/2015.
 */
package fr.gobelins.workshop.util {
import fr.gobelins.workshop.constants.Settings;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class Popup extends Sprite {
    private var _backgroundTexture:Texture;
    private var _title:String;

    public function Popup(title:String, background:Texture) {
        super();

        _title = title;
        _backgroundTexture = background;

        addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
    }

    private function _onAddedToStage(event:Event):void {
        var background:Image = new Image(_backgroundTexture);
        addChild(background);

        var title:TextField = new TextField(background.width, 80, _title, Settings.FONT);
        title.color = 0xFFFFFF;
        title.fontSize = 70;
        addChild(title);
        title.x = (background.width / 2) - (title.width / 2);
        title.y = 10;
    }
}
}
