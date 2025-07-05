import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

// Menu input delegate
class SequenceAlertsMenuDelegate extends WatchUi.Menu2InputDelegate {
    private const _fibonacci = [1, 2, 3, 5, 8, 13];
    private const _countingUp = [1, 2, 3, 4, 5];
    private const _countingDown = [5, 4, 3, 2, 1];
    private const _generic = [5, 10, 15, 10, 5 ];
    
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function setArray(id) as Void {
        switch (id) {
            case "fibonacci":
                Application.getApp().setSequence(_fibonacci);
                break;
            case "countingUp":
                Application.getApp().setSequence(_countingUp);
                break;
            case "countingDown":
                Application.getApp().setSequence(_countingDown);
                break;
            default:
                Application.getApp().setSequence(_generic);
                break;
        }

        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        // v Had an error because no return is expected
        //return true;
    }
}