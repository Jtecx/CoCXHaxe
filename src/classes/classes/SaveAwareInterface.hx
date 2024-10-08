package classes;


//Call CoC.saveAwareClassAdd if you want a class that implements this interface to receive updates when the game is loaded or saved
interface SaveAwareInterface
{

    /*	Called for every Class in the _saveAwareClassList just after the game is loaded from a save.
			Each class should use this opportunity to read all its stored information from one or more flag variables. */
    function updateAfterLoad(game : CoC) : Void
    ;
    
    /*	Called for every Class in the _saveAwareClassList just before the game is to be saved.
			Each class should use this opportunity to write all its stored information to one or more flag variables so that it will be saved. */
    function updateBeforeSave(game : CoC) : Void
    ;
}
