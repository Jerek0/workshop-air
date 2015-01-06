/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;

    import fr.gobelins.workshop.App;
    import fr.gobelins.workshop.constants.PageID;
    import fr.gobelins.workshop.constants.Settings;
    import fr.gobelins.workshop.events.PagesEvent;
import fr.gobelins.workshop.util.ParallaxBackground;

import starling.display.Button;
import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;
    import starling.text.TextField;

    public class HighScoresPage extends APage {
        private var _urlLoader:URLLoader;
        private var _highScores:Object;
        private var _highScoresBackground:Image;

        public function HighScoresPage() {
            super();

            var urlRequest : URLRequest = new URLRequest("http://www.cordechasse.fr/gobelins/CRM14/scripts/getTopScores.php");
            var requestVars:URLVariables = new URLVariables();
            requestVars.project_name = "RaptoRun";
            requestVars.max_row = "10";
            urlRequest.data = requestVars;
            urlRequest.method = URLRequestMethod.POST;

            _urlLoader = new URLLoader();
            _urlLoader.addEventListener(flash.events.Event.COMPLETE, _onComplete);
            _urlLoader.load(urlRequest);
        }

        private function _onComplete(event:flash.events.Event):void {
            _highScores = JSON.parse(_urlLoader.data).scores;

            var highScoresViews = new Vector.<TextField>();
            var cpt = 0;
            for each(var highScore:Object in _highScores) {
                var name:TextField = new TextField(400, 48, highScore.user_name, Settings.FONT);
                name.color = Settings.PURPLE;
                name.fontSize = 48;
                name.hAlign = "left";
                if(cpt > 0) name.y = highScoresViews[cpt - 1].y + name.height + 5;
                else name.y = _highScoresBackground.y + 80;
                name.x = _highScoresBackground.x + 20;
                highScoresViews.push(name);
                addChild(highScoresViews[cpt]);

                var score:TextField = new TextField(400, 50, highScore.score, Settings.FONT);
                score.color = Settings.GREEN;
                score.fontSize = 48;
                score.hAlign = "right";
                score.y = name.y;
                score.x = _highScoresBackground.x + _highScoresBackground.width - score.width - 20;
                addChild(score);

                cpt++;
            }
        }

        protected override function _init():void {
            // ###### DECOR
            var background : Image = new Image(App.assets.getTextureAtlas("Backgrounds").getTexture("Fond"));
            addChild(background);

            var farestPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanFarest"), 18);
            farestPlan.y = 140;
            addChild(farestPlan);

            var thirdPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanThird"),6);
            thirdPlan.y = 240;
            addChild(thirdPlan);

            var secondPlan : ParallaxBackground = new ParallaxBackground(App.assets.getTextureAtlas("Backgrounds").getTexture("PlanSecond"), 2);
            addChild(secondPlan);
            secondPlan.y = stage.stageHeight - secondPlan.height + 1;

            var overlay:Quad = new Quad(stage.stageWidth, stage.stageHeight, Settings.PURPLE);
            overlay.x = 0; overlay.y = 0;
            overlay.alpha = 0.8;
            addChild(overlay);

            // UI

            var btnHome : Button = new Button(App.assets.getTextureAtlas("userInterface").getTexture("home-btn"), "", App.assets.getTextureAtlas("userInterface").getTexture("home-btn-active"));
            addChild(btnHome);
            btnHome.x = 85;
            btnHome.y = stage.stageHeight - btnHome.height - 70;
            btnHome
            btnHome.addEventListener(starling.events.Event.TRIGGERED, _onHomeTriggered);

            var logo : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("logo"));
            var logoRatio:Number = logo.width / logo.height;
            addChild(logo);
            logo.width = 350;
            logo.height = logo.width / logoRatio;
            logo.y = btnHome.y - logo.height - 180;
            logo.x = 85;

            var title : Image = new Image(App.assets.getTextureAtlas("userInterface").getTexture("top10"));
            addChild(title);
            title.y = logo.y - title.height + 80;
            title.x = 85;

            _highScoresBackground = new Image(App.assets.getTextureAtlas("Backgrounds").getTexture("bg-top10"));
            addChild(_highScoresBackground);
            _highScoresBackground.x = logo.x + logo.width + 50; _highScoresBackground.y = 65;

            var nameCol:TextField = new TextField(100, 50, "Name", Settings.FONT);
            nameCol.x = _highScoresBackground.x + 20;
            nameCol.y = _highScoresBackground.y + 20;
            nameCol.fontSize = 24;
            nameCol.color = Settings.YELLOW;
            nameCol.hAlign = "left";
            addChild(nameCol);

            var scoreCol:TextField = new TextField(100, 50, "Score", Settings.FONT);
            scoreCol.x = _highScoresBackground.x + _highScoresBackground.width - scoreCol.width - 20;
            scoreCol.y = _highScoresBackground.y + 20;
            scoreCol.fontSize = 24;
            scoreCol.color = Settings.YELLOW;
            scoreCol.hAlign = "right";
            addChild(scoreCol);
        }

        private function _onHomeTriggered(event:starling.events.Event):void {
            dispatchEvent(new PagesEvent(PagesEvent.CHANGE, PageID.HOME));
        }
    }
}
