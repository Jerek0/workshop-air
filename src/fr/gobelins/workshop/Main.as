package fr.gobelins.workshop {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.HAlign;
    import starling.utils.RectangleUtil;
    import starling.utils.ScaleMode;
    import starling.utils.VAlign;

    [SWF(frameRate="60", backgroundColor="#000000")]
    public class Main extends Sprite {

        private var _starling:Starling;
        private var _isHD:int;
        private var _stageWidth:int = 1280;

        public function Main() {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            var screenSize:Rectangle = new Rectangle(0,0, stage.fullScreenWidth, stage.fullScreenHeight);
            var viewPort:Rectangle = RectangleUtil.fit(screenSize, screenSize, ScaleMode.SHOW_ALL);
            _isHD = viewPort.width < 480 ? 2 : 1;

            Starling.multitouchEnabled = false;
            Starling.handleLostContext = true;

            _starling = new Starling(App, stage, viewPort);
            _starling.addEventListener(Event.ROOT_CREATED, _onRootCreated);
            _starling.stage.stageWidth = _stageWidth;
            _starling.stage.stageHeight = stage.fullScreenHeight / stage.fullScreenWidth * _stageWidth;
            _starling.showStatsAt(HAlign.LEFT, VAlign.TOP, 2);
            _starling.start();
        }

        private function _onRootCreated(event:Event):void {
            (_starling.root as App).init(_isHD);
        }
    }
}
