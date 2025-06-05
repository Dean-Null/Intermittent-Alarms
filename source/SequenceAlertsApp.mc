using Toybox.Application;
using Toybox.Attention;
using Toybox.System;
using Toybox.Timer;
using Toybox.WatchUi;

class SequenceAlertsApp extends Application.AppBase {
    public var sequenceTimer;
    public var sequenceNumbers;
    public var isTimerActive;

    private var _view;
    private var _timeRemaining;
    private var _delegate;
    private var _currentIndex;
    private var _secondsInt=60;

    function initialize() {
        AppBase.initialize();
        // Example Fibonacci sequence in minutes
        sequenceNumbers = [1, 2, 3, 5, 8, 13];
        _currentIndex = 0;
        isTimerActive = false;
        sequenceTimer = new Timer.Timer();
    }

    // onStart() is called on application start up
    function onStart(state) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state) as Void {
        if (isTimerActive) {
            sequenceTimer.stop();
        }
    }

    // Return the initial view of your application
    function getInitialView() {
        _view = new SequenceAlertsView();
        _delegate = new SequenceAlertsInputDelegate();
        return [_view, _delegate];
    }
    
    // Handle menu button press - needed for API level compatibility
    function onMenu() {
        var menu = new SequenceAlertsSettingsMenu();
        var menuDelegate = new SequenceAlertsMenuDelegate();
        WatchUi.pushView(menu, menuDelegate, WatchUi.SLIDE_UP);
        return true;
    }
    
    // Start the timer sequence
    function startSequence() {
        if (isTimerActive) {
            return;
        }
        
        _currentIndex = 0;
        isTimerActive = true;
        var variable = sequenceNumbers.indexOf(_currentIndex);
        _timeRemaining = variable * _secondsInt; // Convert minutes to seconds
        
        // Update the view to show first countdown
        _view.updateCountdown(_timeRemaining, sequenceNumbers.indexOf(_currentIndex));
        
        // Start a timer that ticks every second
        sequenceTimer.start(method(:timerCallback), 1000, true);
    }
    
    // Stop the timer sequence
    function stopSequence() {
        if (isTimerActive) {
            sequenceTimer.stop();
            isTimerActive = false;
            _view.showStoppedState();
        }
    }
    
    // Timer callback function that runs every second
    function timerCallback() {
        _timeRemaining--;
        
        // Update the view with the new time
        _view.updateCountdown(_timeRemaining, sequenceNumbers.indexOf(_currentIndex));
        
        // If the timer reaches zero, trigger the alarm and move to next number in sequence
        if (_timeRemaining <= 0) {
            triggerAlarm();
            
            // Move to the next number in the sequence
            _currentIndex++;
            
            // If we've completed the sequence, stop the timer
            if (_currentIndex >= sequenceNumbers.size()) {
                sequenceTimer.stop();
                isTimerActive = false;
                _view.showCompletedState();
                return;
            }
            
            // Start the next interval
            _timeRemaining = sequenceNumbers.indexOf(_currentIndex) * _secondsInt; // Convert minutes to seconds
        }
    }
    
    // Trigger the alarm with vibration and display alert
    function triggerAlarm() {
        if (Attention has :vibrate) {
            Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        }
        
        // Show alert on screen
        _view.showAlert(_currentIndex, sequenceNumbers.size());
        
        // If there's another interval, show what's coming next
        if (_currentIndex < sequenceNumbers.size() - 1) {
            _view.showNextInterval(sequenceNumbers.indexOf(_currentIndex + 1));
        }
    }
    
    // Allow user to customize the sequence
    function setSequence(newSequence) {
        if (!isTimerActive && newSequence != null && newSequence.size() > 0) {
            sequenceNumbers = newSequence;
            _view.updateSequenceDisplay(sequenceNumbers);
        }
    }
}
