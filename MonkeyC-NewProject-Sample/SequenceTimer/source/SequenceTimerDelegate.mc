import Toybox.Lang;
import Toybox.WatchUi;

class SequenceTimerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SequenceTimerMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}