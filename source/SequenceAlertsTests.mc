import Toybox.Test;

class SequenceAlertsTests{
    (:test)
    function TheseTwoDontPass() {
        var x = "hello";
        var y = x;

        // Prints an error to the console when x and y are equal
        Test.assertEqual(x, y);
    }
}