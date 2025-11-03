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
        System.println("A key was pressed.");

        switch (keyEvent.getKey()) {
            case WatchUi.KEY_CLOCK:
                System.println("WatchUi.KEY_CLOCK");

            case WatchUi.KEY_DOWN:
                System.println("WatchUi.KEY_DOWN");

            case WatchUi.KEY_DOWN_LEFT:
                System.println("WatchUi.KEY_DOWN_LEFT");

            case WatchUi.KEY_ENTER:
                System.println("WatchUi.KEY_ENTER");

            case WatchUi.KEY_ESC:
                System.println("WatchUi.KEY_ESC");

            case WatchUi.KEY_FIND:
                System.println("WatchUi.KEY_FIND");

            case WatchUi.KEY_LAP:
                System.println("WatchUi.KEY_LAP");

            case WatchUi.KEY_LEFT:
                System.println("WatchUi.KEY_LEFT");
            
            case WatchUi.KEY_LIGHT:
                System.println("WatchUi.KEY_LIGHT");

            case WatchUi.KEY_MENU:
                System.println("WatchUi.KEY_MENU");
                return Application.getApp().onMenu();

            case WatchUi.KEY_MODE:
                System.println("WatchUi.KEY_MODE");

            case WatchUi.KEY_PAGE:
                System.println("WatchUi.KEY_PAGE");

            case WatchUi.KEY_POWER:
                System.println("WatchUi.KEY_POWER");

            case WatchUi.KEY_RESET:
                System.println("WatchUi.KEY_RESET");

            case WatchUi.KEY_RIGHT:
                System.println("WatchUi.KEY_RIGHT");

            case WatchUi.KEY_SPORT:
                System.println("WatchUi.KEY_SPORT");
            
            case WatchUi.KEY_START:
                System.println("WatchUi.KEY_START");
                System.println("Start or Enter key was pressed");
                if (!Application.getApp().isActive) {
                    System.println("Is active start sequence");
                    return Application.getApp().startSequence();
                } else {
                    System.println("is not active stopping sequence");
                    return Application.getApp().stopSequence();
                }

            case WatchUi.KEY_UP:
                System.println("WatchUi.KEY_UP");

            case WatchUi.KEY_UP_LEFT:
                System.println("WatchUi.KEY_UP_LEFT");

            case WatchUi.KEY_UP_RIGHT:
                System.println("WatchUi.KEY_UP_RIGHT");

            case WatchUi.KEY_ZIN:
                System.println("WatchUi.KEY_ZIN");
            
            case WatchUi.KEY_ZOUT:
                System.println("WatchUi.KEY_ZOUT");
            
            default:
                break;
        }
        
        System.println("---onkey has ended");
        return false;
    }
}