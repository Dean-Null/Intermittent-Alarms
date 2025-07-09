import Toybox.WatchUi;
import Toybox.Lang;

// Input handler for button presses
class SequenceAlertsDelegate extends WatchUi.InputDelegate {
    
    function initialize() {
        System.println("Initialize App Base Delegate");

        InputDelegate.initialize();
        
        System.println("---app based delegate has been initialized");
    }

    // Handle button presses
    function onKey(keyEvent) as Boolean{
        System.println("Broh should this even be started");

        switch (keyEvent.getKey()) {
            case WatchUi.KEY_ENTER:
            case WatchUi.KEY_START:
                System.println("Start or Enter key was pressed");
                if (!Application.getApp().isActive) {
                    System.println("Is active start sequence");
                    return Application.getApp().startSequence();
                } else {
                    System.println("is not active stopping sequence");
                    return Application.getApp().stopSequence();
                }
                case WatchUi.KEY_MENU:
                System.println("Meny key was pressed");
                return Application.getApp().onMenu();
            default:
                break;
        }
        
        System.println("---onkey has ended");
        return false;
    }
}