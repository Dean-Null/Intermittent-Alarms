using Toybox.Application;
using Toybox.Attention;
using Toybox.System;
using Toybox.Timer;
using Toybox.WatchUi;

// Input handler for button presses
class SequenceAlertsInputDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    // Handle button presses
    function onKey(keyEvent) {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            // Start/Stop button
            if (!Application.getApp().isTimerActive) {
                Application.getApp().startSequence();
            } else {
                Application.getApp().stopSequence();
            }
            return true;
        } else if (key == WatchUi.KEY_MENU) {
            // Explicitly handle menu button for older API levels
            return Application.getApp().onMenu();
        }
        
        return false;
    }
    
    // Add explicit menu event handler for API compatibility
    function onMenu() {
        return Application.getApp().onMenu();
    }
}