using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

// Settings menu for customizing the sequence
class SequenceTimerSettingsMenu extends WatchUi.Menu2 {
    function initialize() {
        //Menu2.initialize();
        Menu2.setTitle("Settings");
        
        // Add menu items for predefined sequences
        addItem(new WatchUi.MenuItem("Fibonacci", null, "fibonacci", null));
        addItem(new WatchUi.MenuItem("Counting Up", null, "countingUp", null));
        addItem(new WatchUi.MenuItem("Counting Down", null, "countingDown", null));
        addItem(new WatchUi.MenuItem("Custom", null, "custom", null));
    }
}