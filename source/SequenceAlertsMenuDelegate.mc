import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

// Menu input delegate
class SequenceAlertsMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        System.println("Initializing Menu Delegate");

        Menu2InputDelegate.initialize();

        System.println("---menu delegate initialized");
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        System.println("Menu item selected");

        var id = item.getId();
        setArray(id);

        System.println("---menu item selection handled");
    }

    function setArray(id) as Void {
        System.println("Set Sequence Array");

        switch (id) {
            case constVar.strFib:
                Application.getApp().setSequence(constVar.fibonacci);
                break;

            case constVar.strCountUp:
                Application.getApp().setSequence(constVar.countingUp);
                break;

            case constVar.strCountDown:
                Application.getApp().setSequence(constVar.countingDown);
                break;

            case constVar.strGeneric:
                Application.getApp().setSequence(constVar.generic);
                break;
        }
        
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        System.println("---sequence array has been set");
    }
}