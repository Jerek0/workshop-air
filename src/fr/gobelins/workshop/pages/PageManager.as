/**
 * Created by jerek0 on 18/12/2014.
 */
package fr.gobelins.workshop.pages {
    import fr.gobelins.workshop.constants.PageID;
    import fr.gobelins.workshop.events.PagesEvent;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.EventDispatcher;

    public class PageManager extends EventDispatcher {

        private var _holder:Sprite;

        private var _currentPage:APage;

        public function PageManager(holder:Sprite) {
            super();

            _holder = holder;

            // HOME par défault
            _addPage(PageID.HOME);
        }

        /*
        When a request for a new page is done,
        this function removes the current one and load the one which is asked instead
         */
        private function _onChangePage(event:PagesEvent):void {
            var transitionPage : TransitionPage = new TransitionPage();
            _holder.addChild(transitionPage);

            Starling.juggler.delayCall(function():void {
                _removePage();
                _addPage(event.idPage);
            }, 0.1);

            Starling.juggler.delayCall(function():void {
                _holder.removeChild(transitionPage, true);
                transitionPage = null;
            }, 0.5);
        }

        // Load a page with a given ID
        private function _addPage(idPage:String):void {
            switch(idPage) {
                case PageID.HOME:
                    _currentPage = new HomePage();
                    break;
                case PageID.GAME:
                    _currentPage = new GamePage();
                    break;
                case PageID.HIGHSCORES:
                    _currentPage = new HighScoresPage();
                    break;
            }
            _holder.addChildAt(_currentPage, 0);
            _currentPage.addEventListener(PagesEvent.CHANGE, _onChangePage);
        }

        // Remove the current page
        private function _removePage():void {
            _currentPage.removeEventListener(PagesEvent.CHANGE, _onChangePage);
            _holder.removeChild(_currentPage,true);
        }
    }
}
