import Toybox.Application;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.System;
import Toybox.Timer;
import Toybox.WatchUi;

class SequenceAlertsApp extends Application.AppBase {
    var currentTimer as Timer.Timer?;
    var isActive as Boolean = false;
    var isLoopEnabled as Boolean = false;
    var currentSeq as Array?;
    var inSeconds as Number?;
    var currentIndex as Number?;
    var secSum as Number?;
    
    var baseView;

    // This is the constructor for the class
    function initialize() {
        System.println("Initializing App Class");

        AppBase.initialize();
        
        System.println("---initialization complete");
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // Example Fibonacci sequence in minutes
        System.println("Starting App - setting class fields");
        
        currentIndex = 0;
        currentSeq = constVar.generic;
        inSeconds = constVar.secondsInMinutes;
        secSum = 0;
        currentTimer = new Timer.Timer();

        System.println("---start complete");
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        System.println("Closing App");

        if (isActive) {
            System.println("Stopping timer");
            currentTimer.stop();
        }

        System.println("--- closed app");
    }

    // Return the initial view of your application
    function getInitialView() as [Views] or [Views, InputDelegates] {
        System.println("---Return App Base View");
        
        baseView = new SequenceAlertsView();

        return [ baseView, new SequenceAlertsDelegate() ];
    }
    
    function getApp() as SequenceAlertsApp {
        System.println("---Return Application Base");

        return Application.getApp() as SequenceAlertsApp;
    }
    
    // Handle menu button press - needed for API level compatibility
    function onMenu() as Boolean {
        System.println("On Menu when the Menu button is pressed.");
        
        var menu = new SequenceAlertsSettingsMenu();
        var menuDelegate = new SequenceAlertsMenuDelegate();
        
        WatchUi.pushView(menu, menuDelegate, WatchUi.SLIDE_UP);
        System.println("---pushing the menu for app base");
        return true;
    }
    
    // Start the timer sequence
    function startSequence() as Boolean {
        System.println("Starting Timer Sequence");
        
        if (isActive) {
            return false;
        }
        
        currentIndex = 0;
        isActive = true;

        // Convert minutes to seconds
        secSum = currentSeq[currentIndex] * inSeconds; 
        
        // Update the view to show first countdown
        baseView.updateCountdown( secSum, currentSeq[currentIndex]);
        
        // Start a timer that ticks every second
        currentTimer.start(method(:timerCallback), 1000, true);

        System.println("---timer sequence has started");
        return true;
    }
    
    // Stop the timer sequence
    function stopSequence() as Boolean {
        System.println("Stop timer sequence");
        if (isActive) {
            currentTimer.stop();
            isActive = false;
            baseView.showStoppedState();
            return true;
        }
        System.println("---timer sequence has stopped");
        return false;
    }
    
    // Timer callback function that runs every second
    function timerCallback() as Void {
        System.println("Callback to timer");
        
        secSum--;
        
        // Update the view with the new time
        baseView.updateCountdown(secSum, currentSeq[currentIndex]);
        
        // If the timer reaches zero, trigger the alarm and move to next number in sequence
        if (secSum <= 0) {
            triggerAlarm();
            
            // Move to the next number in the sequence
            currentIndex++;
            
            // If we've completed the sequence, check if loop is enabled
            if (currentIndex >= currentSeq.size()) {
                // If loop is enabled, restart the sequence
                if (isLoopEnabled) {
                    currentIndex = 0;
                    secSum = currentSeq[currentIndex] * inSeconds;
                    baseView.updateCountdown(secSum, currentSeq[currentIndex]);
                    return;
                } else {
                    // Otherwise, stop the timer
                    currentTimer.stop();
                    isActive = false;
                    baseView.showCompletedState();
                    return;
                }
            }
            
            // Start the next interval
            secSum = currentSeq[currentIndex] * inSeconds; // Convert minutes to seconds
        }

        System.println("---timercallback complete");
    }
    
    // Trigger the alarm with vibration and display alert
    function triggerAlarm() as Void {
        System.println("Trigger and alarm based on the device");
        
        if (Attention has :vibrate) {
            System.println("Vibrate is an option");
            Attention.vibrate([new Attention.VibeProfile(50, 1000)]);
        }
        
        // Show alert on screen
        baseView.showAlert(currentIndex, currentSeq.size());
        
        // If there's another interval, show what's coming next
        if (currentIndex < currentSeq.size() - 1) {
            System.println("Updating index on current seq");
            var currentIndexValue = currentSeq[currentIndex];
            baseView.showNextInterval(currentIndexValue);
        }
        System.println("---alarm has been triggered");
    }
    
    // Allow user to customize the sequence
    function setSequence(newSequence as Array) as Void {
        System.println("Set Sequence for the next alarms");
        
        if (!isActive && newSequence != null && newSequence.size() > 0) {
            currentSeq = newSequence;
            baseView.updateSequenceDisplay(currentSeq);
        }

        System.println("---sequence has been set");
    }
    
    // Toggle loop state
    function toggleLoop() as Void {
        System.println("Toggle loop state");
        
        isLoopEnabled = !isLoopEnabled;
        baseView.updateLoopIndicator();
        
        System.println("---loop state toggled: " + isLoopEnabled);
    }
}