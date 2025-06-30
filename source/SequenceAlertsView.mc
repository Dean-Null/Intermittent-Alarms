import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

// Main View class for the application
class SequenceAlertsView extends WatchUi.View {
    private var _timerLabel;
    private var _sequenceLabel;
    private var _statusLabel;
    
    function initialize() {
        View.initialize();
    }

    // Load resources
    function onLayout(dc as Dc) {
        setLayout(Rez.Layouts.StartLayout(dc));
        
        _timerLabel = findDrawableById("LabelTimer");
        _sequenceLabel = findDrawableById("LabelSequence");
        _statusLabel = findDrawableById("LabelStatus");
        
        // Initialize display
        _timerLabel.setText("Ready");
        _statusLabel.setText("Press Start");
        var numberValues = Application.getApp().sequenceNumbers;
        updateSequenceDisplay(numberValues);
    }

    // Display the sequence to the user
    function updateSequenceDisplay(sequence as Array) as Void{
        var seqText = "";
        for (var index = 0; index < sequence.size(); index++) {
            // Is this really needed?
            seqText += sequence[index].toString();
            if (index < sequence.size()) {
                seqText += ", ";
            }   
        }
        _sequenceLabel.setText(seqText);
        WatchUi.requestUpdate();
    }

    // Update the display with the current countdown
    function updateCountdown(seconds, currentMinutes) {
        var minutes = seconds / 60;
        var secs = seconds % 60;
        
        _timerLabel.setText(minutes.format("%d") + ":" + secs.format("%02d"));
        _statusLabel.setText("Current: " + currentMinutes + " min");
        WatchUi.requestUpdate();
    }
    
    // Show alert when an interval completes
    function showAlert(completedIndex, totalIntervals) {
        _statusLabel.setText("INTERVAL " + (completedIndex + 1) + "/" + totalIntervals + " COMPLETE!");
        WatchUi.requestUpdate();
    }
    
    // Show info about the next interval
    function showNextInterval(nextMinutes) {
        _statusLabel.setText("Next: " + nextMinutes + " min");
        WatchUi.requestUpdate();
    }
    
    // Display stopped state
    function showStoppedState() {
        _timerLabel.setText("Stopped");
        _statusLabel.setText("Press Start");
        WatchUi.requestUpdate();
    }
    
    // Display completed state
    function showCompletedState() {
        _timerLabel.setText("Done!");
        _statusLabel.setText("Sequence Complete");
        WatchUi.requestUpdate();
    }
    
    // Called when the view is shown
    function onShow() {
    }

    // Called when the view is hidden
    function onHide() {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
}