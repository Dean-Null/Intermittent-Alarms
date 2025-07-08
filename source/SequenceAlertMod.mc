import Toybox.Lang;

module constVar{
    const minuteInSeconds as Number = 60;
    
    const fibonacci as Array = [1, 2, 3, 5, 8, 13];
    const strFib = "fibonacci";
    const countingUp as Array = [1, 2, 3, 4, 5];
    const strCup = "countingUp";
    const countingDown as Array = [5, 4, 3, 2, 1];
    const strCdown = "countingDown";
    const generic as Array = [ 5, 10, 5 ,50 ];
    const strGen = "generic";

    const strLblTimer as String = "LabelTimer";
    const strLblSeq as String = "LabelSequence";
    const strLblStatus as String = "LabelStatus";

    const strTxtReady as String = "Ready";
    const strTxtStart as String = "Press Start";
    const strTxtStop as String = "Stopped";
    const strTxtDone as String = "Done!";
    const strTxtComplete as String = "Sequence Complete";
}

enum sequence {
    fibonacci = 0,
    countingUp = 1,
    countingDown = 2,
    generic = 3,
    initial = 4
}