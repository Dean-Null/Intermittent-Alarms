using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

// Main Application class
class SequenceTimerApp extends Application.AppBase {
    private var _view;
    private var _sequenceTimer;
    private var _sequenceNumbers;
    private var _currentIndex;
    private var _isTimerRunning;
    private var _timeRemaining;

    function initialize() {
        AppBase.initialize();
        _sequenceNumbers = [1, 2, 3, 5, 8, 13]; // Example Fibonacci sequence in minutes
        _currentIndex = 0;
        _isTimerRunning = false;
        _sequenceTimer = new Timer.Timer();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        if (_isTimerRunning) {
            _sequenceTimer.stop();
        }
    }

    // Return the initial view of your application
    function getInitialView() {
        _view = new SequenceTimerView();
        return [_view];
    }
    
    // Start the timer sequence
    function startSequence() {
        if (_isTimerRunning) {
            return;
        }
        
        _currentIndex = 0;
        _isTimerRunning = true;
        _timeRemaining = _sequenceNumbers[_currentIndex] * 60; // Convert minutes to seconds
        
        // Update the view to show first countdown
        _view.updateCountdown(_timeRemaining, _sequenceNumbers[_currentIndex]);
        
        // Start a timer that ticks every second
        _sequenceTimer.start(method(:timerCallback), 1000, true);
    }
    
    // Stop the timer sequence
    function stopSequence() {
        if (_isTimerRunning) {
            _sequenceTimer.stop();
            _isTimerRunning = false;
            _view.showStoppedState();
        }
    }
    
    // Timer callback function that runs every second
    function timerCallback() {
        _timeRemaining--;
        
        // Update the view with the new time
        _view.updateCountdown(_timeRemaining, _sequenceNumbers[_currentIndex]);
        
        // If the timer reaches zero, trigger the alarm and move to next number in sequence
        if (_timeRemaining <= 0) {
            triggerAlarm();
            
            // Move to the next number in the sequence
            _currentIndex++;
            
            // If we've completed the sequence, stop the timer
            if (_currentIndex >= _sequenceNumbers.size()) {
                _sequenceTimer.stop();
                _isTimerRunning = false;
                _view.showCompletedState();
                return;
            }
            
            // Start the next interval
            _timeRemaining = _sequenceNumbers[_currentIndex] * 60; // Convert minutes to seconds
        }
    }
    
    // Trigger the alarm with vibration and display alert
    function triggerAlarm() {
        if (Attention has :vibrate) {
            Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        }
        
        // Show alert on screen
        _view.showAlert(_currentIndex, _sequenceNumbers.size());
        
        // If there's another interval, show what's coming next
        if (_currentIndex < _sequenceNumbers.size() - 1) {
            _view.showNextInterval(_sequenceNumbers[_currentIndex + 1]);
        }
    }
    
    // Allow user to customize the sequence
    function setSequence(newSequence) {
        if (!_isTimerRunning && newSequence != null && newSequence.size() > 0) {
            _sequenceNumbers = newSequence;
            _view.updateSequenceDisplay(_sequenceNumbers);
        }
    }
}

// Main View class for the application
class SequenceTimerView extends WatchUi.View {
    private var _timerLabel;
    private var _sequenceLabel;
    private var _statusLabel;
    
    function initialize() {
        View.initialize();
    }

    // Load resources
    function onLayout(dc) {
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
    
    // Called when the view is shown
    function onShow() {
    }

    // Called when the view is hidden
    function onHide() {
    }
}

// Input handler for button presses
class SequenceTimerInputDelegate extends WatchUi.InputDelegate {
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

// Settings menu for customizing the sequence
class SequenceTimerSettingsMenu extends WatchUi.Menu2 {
    function initialize() {
        Menu2.initialize();
        Menu2.setTitle("Settings");
        
        // Add menu items for predefined sequences
        addItem(new WatchUi.MenuItem("Fibonacci", null, "fibonacci", null));
        addItem(new WatchUi.MenuItem("Counting Up", null, "countingUp", null));
        addItem(new WatchUi.MenuItem("Counting Down", null, "countingDown", null));
        addItem(new WatchUi.MenuItem("Custom", null, "custom", null));
    }
}

// Menu input delegate
class SequenceTimerMenuDelegate extends WatchUi.Menu2InputDelegate {
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    
    function onSelect(item) {
        var id = item.getId();
        
        if (id == "fibonacci") {
            Application.getApp().setSequence([1, 2, 3, 5, 8, 13]);
        } else if (id == "countingUp") {
            Application.getApp().setSequence([1, 2, 3, 4, 5]);
        } else if (id == "countingDown") {
            Application.getApp().setSequence([5, 4, 3, 2, 1]);
        } else if (id == "custom") {
            // Here you would implement logic to accept custom sequence input
            // This is more complex and would require additional UI
        }
        
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
        return true;
    }
}
