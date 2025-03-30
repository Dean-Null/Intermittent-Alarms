using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

// Menu input delegate
class SequenceAlertsMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    
    function onSelect(item) {
        var id = item.getId();
        
        if (id == "fibonacci") {
            Application.getApp().setSequence([1, 2, 3, 5, 8, 13]);
        } else if (id == "countingUp") {
            Application.getApp().setSequence([1, 2, 3, 4, 5]);
        } else if (id == "countingDown") {
            Application.getApp().setSequence([5, 4, 3, 2, 1]);
        } else if (id == "custom") {
            // Here you would implement logic to accept custom sequence input
            // This is more complex and would require additional UI
        }
        
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        // v Had an error because no return is expected
        //return true;
    }
}