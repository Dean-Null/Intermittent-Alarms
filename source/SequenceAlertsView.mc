import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;

// Main View class for the application
class SequenceAlertsView extends WatchUi.View {
    private var _timerLabel;
    private var _sequenceLabel;
    private var _centerImage;
    private var _loopLabel;
    private var _loopLabelY as Number = 230;
    private var _loopLabelHeight as Number = 30; // Approximate height for touch detection
    
    function initialize() {
        System.println("Initializing the App Base View");

        View.initialize();

        System.println("---view has completed initialization");
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        System.println("On Layout method");
        setLayout(Rez.Layouts.StartLayout(dc));

        _centerImage = findDrawableById(constVar.strImgCenter);
        _timerLabel = findDrawableById(constVar.strLblTimer);
        _sequenceLabel = findDrawableById(constVar.strLblSeq);
        _loopLabel = findDrawableById(constVar.strLblLoop);
        
        // // Store loop label position for touch detection
        // _loopLabelY = 230; // Matches layout.xml y position
        
        // Initialize display
        _timerLabel.setText(constVar.strTxtReady);
        _loopLabel.setBitmap(Rez.Drawables.LoopInactive);

        updateSequenceDisplay(Application.getApp().currentSeq);
        updateLoopIndicator();
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
        System.println("onUpdate on View");

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        System.println("---onUpdate on View");
    }

    // Display the sequence to the user
    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        System.println("onHide is blank");
        System.println("---onhide is blank");
    }

    // Maps interval index to icon resource ID
    private function getIconResourceId(index as Number) as ResourceId {
        // Array of all available activity icon resources
        var icons = [
            Rez.Drawables.ActivityIconBizarre,
            Rez.Drawables.ActivityIconCleaning,
            Rez.Drawables.ActivityIconDancing,
            Rez.Drawables.ActivityIconEating,
            Rez.Drawables.ActivityIconJournaling,
            Rez.Drawables.ActivityIconListening,
            Rez.Drawables.ActivityIconPlanning,
            Rez.Drawables.ActivityIconReading,
            Rez.Drawables.ActivityIconRecreation,
            Rez.Drawables.ActivityIconSleeping,
            Rez.Drawables.ActivityIconSorry,
            Rez.Drawables.ActivityIconThinking,
            Rez.Drawables.ActivityIconWalking,
            Rez.Drawables.ActivityIconWorking
        ];
        
        // Cycle through icons using modulo
        var iconIndex = index % icons.size();
        return icons[iconIndex];
    }

    // Updates the the sequence display
    function updateSequenceDisplay(sequence as Array) as Void{
        System.println("Updating Sequence Display");

        var seqText = "";
        for (var index = 0; index < sequence.size(); index++) {
            // Is this really needed? Probably not.
            seqText += sequence[index].toString();
            if (index >= sequence.size() - 1) {
                break;
            }
            else if (index < sequence.size()) {
                seqText += ", ";
            }
        }
        _sequenceLabel.setText(seqText);

        // Set the icon based on the current interval index
        var app = Application.getApp() as SequenceAlertsApp;
        var currentIndex = 0;
        if (app.currentIndex != null) {
            currentIndex = app.currentIndex;
        }
        
        if (_centerImage != null) {
            _centerImage.setBitmap(getIconResourceId(currentIndex));
        }

        WatchUi.requestUpdate();
        System.println("---sequence Display updated");
    }

    // Update the display with the current countdown
    function updateCountdown(seconds as Number, currentMinutes as Number) as Void {
        System.println("Update Countdown");

        var minutes = seconds / constVar.secondsInMinutes;
        var secs = seconds % constVar.secondsInMinutes;
        _timerLabel.setText(minutes.format("%d") + ":" + secs.format("%02d"));

        // Update icon to match current interval index
        var app = Application.getApp() as SequenceAlertsApp;
        if (_centerImage != null && app.currentIndex != null) {
            _centerImage.setBitmap(getIconResourceId(app.currentIndex));
        }

        WatchUi.requestUpdate();
        System.println("---countdown has been updated");
    }
    
    // Show alert when an interval completes
    function showAlert(completedIndex as Number, totalIntervals as Number) as Void {
        System.println("Show an alert for interval");
        
        // Update icon to match the completed interval index
        if (_centerImage != null) {
            _centerImage.setBitmap(getIconResourceId(completedIndex));
        }
        
        WatchUi.requestUpdate();
        System.println("---an alert was shown for the interval");
    }
    
    // Show info about the next interval
    function showNextInterval(nextMinutes as Number) as Void {
        System.println("Show the next interval");

        // Update icon to match the next interval index (currentIndex + 1)
        var app = Application.getApp() as SequenceAlertsApp;
        if (_centerImage != null && app.currentIndex != null) {
            var nextIndex = app.currentIndex + 1;
            _centerImage.setBitmap(getIconResourceId(nextIndex));
        }

        WatchUi.requestUpdate();
        System.println("---next interval has been shown");
    }
    
    // Display stopped state
    function showStoppedState() as Void {
        System.println("Show Stopped state");

        _timerLabel.setText(constVar.strTxtStop);

        WatchUi.requestUpdate();
        System.println("---stopped state has been shown");
    }
    
    // Display completed state
    function showCompletedState() as Void {
        System.println("show the completed state");

        _timerLabel.setText(constVar.strTxtDone);

        WatchUi.requestUpdate();
        System.println("---complete state has been shown");
    }
    
    // Update loop indicator display
    function updateLoopIndicator() as Void {
        System.println("Update loop indicator");
        
        if (_loopLabel != null) {
            var app = Application.getApp() as SequenceAlertsApp;
            if (app.isLoopEnabled) {
                _loopLabel.setBitmap(Rez.Drawables.LoopActive);
            } else {
                _loopLabel.setBitmap(Rez.Drawables.LoopInactive);
            }
            WatchUi.requestUpdate();
        }
        
        System.println("---loop indicator updated");
    }
    
    // Get loop label bounds for touch detection
    function getLoopLabelBounds() as Dictionary {
        var screenWidth = System.getDeviceSettings().screenWidth;
        var touchableWidth = 60; // Wider touch area for easier tapping
        
        return {
            :x => (screenWidth / 2) - (touchableWidth / 2), // Centered touchable area
            :y => _loopLabelY - 5, // Extend slightly above and below
            :width => touchableWidth,
            :height => _loopLabelHeight + 10
        };
    }
}