import Toybox.Test;
import Toybox.Lang;

    (:test)
    function herethere(logger as Logger) as Void {
        logger.debug("Print");

        var x = "hello";
        var y = "hello";

        // Prints an error to the console when x and y are equal
        Test.assertEqualMessage(x, y, "x and y are equal!");
    }
