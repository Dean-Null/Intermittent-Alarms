import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Attention;

// Settings menu for customizing the sequence
class SequenceAlertsSettingsMenu extends WatchUi.Menu2 {
    function initialize() {
        System.println("Initializing Settings Menu2");
        Menu2.initialize({:title=>"Settings"});
        Menu2.setTitle("Settings");
        
        // Add menu items for predefined sequences
        addItem(new WatchUi.MenuItem("Fibonacci", null, constVar.strFib, null));
        addItem(new WatchUi.MenuItem("Counting Up", null, constVar.strCup, null));
        addItem(new WatchUi.MenuItem("Counting Down", null, constVar.strCdown, null));
        addItem(new WatchUi.MenuItem("Generic", null, constVar.strGen, null));
        System.println("---settings menu2 initialized");
    }
}