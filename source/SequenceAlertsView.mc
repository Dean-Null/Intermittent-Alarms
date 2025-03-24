import Toybox.Graphics;
import Toybox.WatchUi;

class SequenceAlertsView extends WatchUi.View {
    private var _timerLabel;
    private var _sequenceLabel;
    private var _statusLabel;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _timerLabel = findDrawableById("TimerLabel");
        _sequenceLabel = findDrawableById("SequenceLabel");
        _statusLabel = findDrawableById("StatusLabel");
        
        // Initialize display
        _timerLabel.setText("Ready");
        _statusLabel.setText("Press Start");
        updateSequenceDisplay(Application.getApp()._sequenceNumbers);
    }

    // Update the display with the current countdown
    function updateCountdown(seconds, currentMinutes) {
        var minutes = seconds / 60;
        var secs = seconds % 60;
        
        _timerLabel.setText(minutes.format("%d") + ":" + secs.format("%02d"));
        _statusLabel.setText("Current: " + currentMinutes + " min");
        WatchUi.requestUpdate();
    }
    
    // Display the sequence to the user
    function updateSequenceDisplay(sequence) {
        var seqText = "";
        for (var i = 0; i < sequence.size(); i++) {
            seqText += sequence[i].toString();
            if (i < sequence.size() - 1) {
                seqText += ", ";
            }
        }
        _sequenceLabel.setText(seqText);
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
