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
        System.println("Initializing the App Base View");
        View.initialize();
        System.println("---view has completed initialization");
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        System.println("On Layout method");
        setLayout(Rez.Layouts.StartLayout(dc));
        
        _timerLabel = findDrawableById("LabelTimer");
        _sequenceLabel = findDrawableById("LabelSequence");
        _statusLabel = findDrawableById("LabelStatus");
        
        // Initialize display
        _timerLabel.setText("Ready");
        _statusLabel.setText("Press Start");
        var numberValues = Application.getApp().currentSeq;
        updateSequenceDisplay(numberValues);
        System.println("---method completed");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        System.println("onShow on view is blank");
        System.println("---onshow on view is blank");
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        System.println("onUpdate on view");
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
        System.println("---onupdate onview");
    }
    // Display the sequence to the user

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        System.println("onHide is blank");
        System.println("---onhide is blank");
    }

    function updateSequenceDisplay(sequence as Array) as Void{
        System.println("Updating Sequence Display");
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
        System.println("---sequence Display updated");
    }

    // Update the display with the current countdown
    function updateCountdown(seconds as Number, currentMinutes as Number) as Void {
        System.println("Update Countdown");
        var minutes = seconds / 60;
        var secs = seconds % 60;
        
        _timerLabel.setText(minutes.format("%d") + ":" + secs.format("%02d"));
        _statusLabel.setText("Current: " + currentMinutes + " min");
        WatchUi.requestUpdate();
        System.println("---countdown has been updated");
    }
    
    // Show alert when an interval completes
    function showAlert(completedIndex as Number, totalIntervals as Number) as Void {
        System.println("Show an alert for interval");
        _statusLabel.setText("INTERVAL " + (completedIndex + 1) + "/" + totalIntervals + " COMPLETE!");
        WatchUi.requestUpdate();
        System.println("---an alert was shown for the interval");
    }
    
    // Show info about the next interval
    function showNextInterval(nextMinutes as Number) as Void {
        System.println("Show the next interval");
        _statusLabel.setText("Next: " + nextMinutes + " min");
        WatchUi.requestUpdate();
        System.println("---next interval has been shown");
    }
    
    // Display stopped state
    function showStoppedState() as Void {
        System.println("Show Stopped state");
        _timerLabel.setText("Stopped");
        _statusLabel.setText("Press Start");
        WatchUi.requestUpdate();
        System.println("---stopped state has been shown");
    }
    
    // Display completed state
    function showCompletedState() as Void {
        System.println("show the completed state");
        _timerLabel.setText("Done!");
        _statusLabel.setText("Sequence Complete");
        WatchUi.requestUpdate();
        System.println("---complete state hase been shown");
    }

}