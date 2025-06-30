import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;
import Toybox.Attention;

// Settings menu for customizing the sequence
class SequenceAlertsSettingsMenu extends WatchUi.Menu2 {
    function initialize() {
        Menu2.initialize({:title=>"Settings"});
        Menu2.setTitle("Settings");
        
        // Add menu items for predefined sequences
        addItem(new WatchUi.MenuItem("Fibonacci", null, "fibonacci", null));
        addItem(new WatchUi.MenuItem("Counting Up", null, "countingUp", null));
        addItem(new WatchUi.MenuItem("Counting Down", null, "countingDown", null));
        addItem(new WatchUi.MenuItem("Custom", null, "custom", null));
    }
}