import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class SequenceAlertsMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :item_1) {
            System.println("item 1");
        } else if (item == :item_2) {
            System.println("item 2");
        }
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
        return true;
    }

}