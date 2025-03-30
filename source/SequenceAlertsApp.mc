using Toybox.Application;
using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;
using Toybox.Attention;

class SequenceAlertsApp extends Application.AppBase {
    private var _view;
    public var _sequenceTimer;
    public var _sequenceNumbers;
    private var _currentIndex;
    public var _isTimerRunning;
    private var _timeRemaining;
    private var _delegate;

    function initialize() {
        AppBase.initialize();
        _sequenceNumbers = [1, 2, 3, 5, 8, 13]; // Example Fibonacci sequence in minutes
        _currentIndex = 0;
        _isTimerRunning = false;
        _sequenceTimer = new Timer.Timer();
    }

    // onStart() is called on application start up
    function onStart(state) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state) as Void {
        if (_isTimerRunning) {
            _sequenceTimer.stop();
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
