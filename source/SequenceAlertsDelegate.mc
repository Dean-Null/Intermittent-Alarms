import Toybox.Lang;
import Toybox.WatchUi;

class SequenceAlertsDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SequenceAlertsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}