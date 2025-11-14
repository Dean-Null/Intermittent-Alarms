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
                break;

            case WatchUi.KEY_DOWN:
                System.println("WatchUi.KEY_DOWN");
                break;

            case WatchUi.KEY_DOWN_LEFT:
                System.println("WatchUi.KEY_DOWN_LEFT");
                break;

            case WatchUi.KEY_ENTER:
                System.println("WatchUi.KEY_ENTER");
                if (!Application.getApp().isActive) {
                    System.println("Is active start sequence");
                    return Application.getApp().startSequence();
                } else {
                    System.println("is not active stopping sequence");
                    return Application.getApp().stopSequence();
                }

            case WatchUi.KEY_ESC:
                System.println("WatchUi.KEY_ESC");
                break;

            case WatchUi.KEY_FIND:
                System.println("WatchUi.KEY_FIND");
                break;

            case WatchUi.KEY_LAP:
                System.println("WatchUi.KEY_LAP");
                break;

            case WatchUi.KEY_LEFT:
                System.println("WatchUi.KEY_LEFT");
                break;
            
            case WatchUi.KEY_LIGHT:
                System.println("WatchUi.KEY_LIGHT");
                break;

            case WatchUi.KEY_MENU:
                System.println("WatchUi.KEY_MENU");
                return Application.getApp().onMenu();

            case WatchUi.KEY_MODE:
                System.println("WatchUi.KEY_MODE");
                break;

            case WatchUi.KEY_PAGE:
                System.println("WatchUi.KEY_PAGE");
                break;

            case WatchUi.KEY_POWER:
                System.println("WatchUi.KEY_POWER");
                break;

            case WatchUi.KEY_RESET:
                System.println("WatchUi.KEY_RESET");
                break;

            case WatchUi.KEY_RIGHT:
                System.println("WatchUi.KEY_RIGHT");
                break;

            case WatchUi.KEY_SPORT:
                System.println("WatchUi.KEY_SPORT");
                break;
            
            case WatchUi.KEY_START:
                System.println("WatchUi.KEY_START");
                break;

            case WatchUi.KEY_UP:
                System.println("WatchUi.KEY_UP");
                break;

            case WatchUi.KEY_UP_LEFT:
                System.println("WatchUi.KEY_UP_LEFT");
                break;

            case WatchUi.KEY_UP_RIGHT:
                System.println("WatchUi.KEY_UP_RIGHT");
                break;

            case WatchUi.KEY_ZIN:
                System.println("WatchUi.KEY_ZIN");
                break;
            
            case WatchUi.KEY_ZOUT:
                System.println("WatchUi.KEY_ZOUT");
                break;
            
            default:
                break;
        }
        
        System.println("---onkey has ended");
        return false;
    }
    
    // Handle touch events
    function onTap(evt as WatchUi.ClickEvent) as Boolean {
        System.println("Touch event detected");
        
        var app = Application.getApp() as SequenceAlertsApp;
        var view = app.baseView;
        
        if (view != null && view has :getLoopLabelBounds) {
            var bounds = view.getLoopLabelBounds();
            var coords = evt.getCoordinates();
            var x = coords[0];
            var y = coords[1];
            
            // Check if tap is within loop label bounds
            if (x >= bounds.get(:x) && 
                x <= bounds.get(:x) + bounds.get(:width) &&
                y >= bounds.get(:y) && 
                y <= bounds.get(:y) + bounds.get(:height)) {
                
                System.println("Loop label tapped - toggling loop");
                app.toggleLoop();
                return true;
            }
        }
        
        System.println("---touch event not handled");
        return false;
    }
}