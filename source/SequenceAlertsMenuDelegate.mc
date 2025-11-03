import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

// Menu input delegate
class SequenceAlertsMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        System.println("Intializing Menu Delegate");

        Menu2InputDelegate.initialize();

        System.println("---menu delegate initialized");
    }

    function setArray(id) as Void {
        System.println("Set Sequence Array");

        switch (id) {
            case constVar.strFib:
                Application.getApp().setSequence(constVar.fibonacci);
                break;

            case constVar.strCup:
                Application.getApp().setSequence(constVar.countingUp);
                break;

            case constVar.strCdown:
                Application.getApp().setSequence(constVar.countingDown);
                break;

            case constVar.strGen:
                Application.getApp().setSequence(constVar.generic);
                break;
        }
        
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        System.println("---sequence array has been set");
    }
}