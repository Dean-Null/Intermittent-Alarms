using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

class InputDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
    }

    // Handle button presses
    function onKey(keyEvent) {
        var key = keyEvent.getKey();
        
        if (key == WatchUi.KEY_ENTER || key == WatchUi.KEY_START) {
            // Start/Stop button
            if (!Application.getApp()._isTimerRunning) {
                Application.getApp().startSequence();
            } else {
                Application.getApp().stopSequence();
            }
            return true;
        }
        
        return false;
    }
}