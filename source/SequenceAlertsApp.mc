import Toybox.Application;
import Toybox.Attention;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;
import Toybox.Lang;

class SequenceAlertsApp extends Application.AppBase {
    public var sequenceTimer;
    public var sequenceNumbers = [1, 2, 3, 5, 8, 13] as Array;
    public var isTimerActive = false;

    private var _view;
    private var _timeRemaining;
    private var _currentIndex = 0;
    private const _secondsInt = 60;

    function initialize() {
        AppBase.initialize();
        System.println("Welcome to MonkeyC");
        // Example Fibonacci sequence in minutes
        isTimerActive = false;
        sequenceTimer = new Timer.Timer();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        if (isTimerActive) {
            sequenceTimer.stop();
        }
    }

    // Return the initial view of your application
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [new SequenceAlertsView(), new SequenceAlertsDelegate() ];
    }
    
    function getApp() as SequenceAlertsApp {
        return Application.getApp() as SequenceAlertsApp;
    }
    // Handle menu button press - needed for API level compatibility
    function onMenu() as Boolean {
        var menu = new SequenceAlertsSettingsMenu();
        var menuDelegate = new SequenceAlertsMenuDelegate();
        WatchUi.pushView(menu, menuDelegate, WatchUi.SLIDE_UP);
        return true;
    }
    
    // Start the timer sequence
    function startSequence() as Void {
        if (isTimerActive) {
            return;
        }
        
        _currentIndex = 0;
        isTimerActive = true;

        // Convert minutes to seconds
        _timeRemaining = sequenceNumbers[_currentIndex] * _secondsInt; 
        
        // Update the view to show first countdown
        _view.updateCountdown(_timeRemaining, sequenceNumbers[_currentIndex]);
        
        // Start a timer that ticks every second
        sequenceTimer.start(method(:timerCallback), 1000, true);
    }
    
    // Stop the timer sequence
    function stopSequence() as Void {
        if (isTimerActive) {
            sequenceTimer.stop();
            isTimerActive = false;
            _view.showStoppedState();
        }
    }
    
    // Timer callback function that runs every second
    function timerCallback(sequenceNumbers as Array) as Void {
        _timeRemaining--;
        
        // Update the view with the new time
        _view.updateCountdown(_timeRemaining, sequenceNumbers[_currentIndex]);
        
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
            _timeRemaining = sequenceNumbers[_currentIndex] * _secondsInt; // Convert minutes to seconds
        }
    }
    
    // Trigger the alarm with vibration and display alert
    function triggerAlarm() as Void {
        if (Attention has :vibrate) {
            Attention.vibrate([new Attention.VibeProfile(100, 1000)]);
        }
        
        // Show alert on screen
        _view.showAlert(_currentIndex, sequenceNumbers.size());
        
        // If there's another interval, show what's coming next
        if (_currentIndex < sequenceNumbers.size() - 1) {
            var currentIndexValue = sequenceNumbers[_currentIndex];
            _view.showNextInterval(currentIndexValue);
        }
    }
    
    // Allow user to customize the sequence
    function setSequence(newSequence) as Void {
        if (!isTimerActive && newSequence != null && newSequence.size() > 0) {
            sequenceNumbers = newSequence;
            _view.updateSequenceDisplay(sequenceNumbers);
        }
    }
}
