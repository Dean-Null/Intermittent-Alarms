import Toybox.Lang;

module constVar{
    const secondsInMinutes as Number = 60;
    
    // Base View
    const strImgCenter as String = "ImageCenter";
    const strLblActivity as String = "LabelActivity";
    const strLblSeq as String = "LabelSequence";
    const strImgLoop as String = "LabelLoop";
    const strLblTimer as String = "LabelTimer";

    // Base View - Timer Text
    const strTxtReady as String = "Ready";
    const strTxtStart as String = "Press Start";
    const strTxtStop as String = "Stopped";
    const strTxtDone as String = "Done!";
    const strTxtComplete as String = "Sequence Complete";

    // Menu
    const fibonacci as Array = [1, 2, 3, 5, 8, 13];
    const strFib = "fibonacci";
    const countingUp as Array = [1, 2, 3, 4, 5];
    const strCountUp = "countingUp";
    const countingDown as Array = [5, 4, 3, 2, 1];
    const strCountDown = "countingDown";
    const generic as Array = [ 5, 10, 5 ,50 ];
    const strGeneric = "generic";

}

enum sequence {
    fibonacci = 0,
    countingUp = 1,
    countingDown = 2,
    generic = 3,
    initial = 4
}