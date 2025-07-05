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

    // Load your resources here
    function onLayout(dc as Dc) as Void {
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
    function updateCountdown(seconds as Number, currentMinutes as Number) as Void {
        var minutes = seconds / 60;
        var secs = seconds % 60;
        
        _timerLabel.setText(minutes.format("%d") + ":" + secs.format("%02d"));
        _statusLabel.setText("Current: " + currentMinutes + " min");
        WatchUi.requestUpdate();
    }
    
    // Show alert when an interval completes
    function showAlert(completedIndex as Number, totalIntervals as Number) as Void {
        _statusLabel.setText("INTERVAL " + (completedIndex + 1) + "/" + totalIntervals + " COMPLETE!");
        WatchUi.requestUpdate();
    }
    
    // Show info about the next interval
    function showNextInterval(nextMinutes as Number) as Void {
        _statusLabel.setText("Next: " + nextMinutes + " min");
        WatchUi.requestUpdate();
    }
    
    // Display stopped state
    function showStoppedState() as Void {
        _timerLabel.setText("Stopped");
        _statusLabel.setText("Press Start");
        WatchUi.requestUpdate();
    }
    
    // Display completed state
    function showCompletedState() as Void {
        _timerLabel.setText("Done!");
        _statusLabel.setText("Sequence Complete");
        WatchUi.requestUpdate();
    }
    
    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }
}