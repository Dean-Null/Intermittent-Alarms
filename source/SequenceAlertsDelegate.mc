import Toybox.WatchUi;
import Toybox.Lang;

// Input handler for button presses
class SequenceAlertsDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    // Handle button presses
    function onKey(keyEvent) as Boolean{
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            // Start/Stop button
            if (!Application.getApp().isTimerActive) {
                Application.getApp().startSequence();
            } else {
                Application.getApp().stopSequence();
            }
            return true;
        } else if (key == WatchUi.KEY_MENU) {
            // Explicitly handle menu button for older API levels
            // Menu button is a long press on the lower right button
            return Application.getApp().onMenu();
        }
        
        return false;
    }
    
    // Add explicit menu event handler for API compatibility
    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new SequenceAlertsMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }
}