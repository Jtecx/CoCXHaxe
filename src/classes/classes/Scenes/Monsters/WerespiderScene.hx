/**
 * ...
 * @author Ormael
 */
package classes.scenes.monsters;

import classes.*;

class WerespiderScene extends BaseContent
{
    
    public function new()
    {
        super();
    }
    
    public function werespiderEncounter() : Void
    {
        clearOutput();
        outputText("\n\n");
        outputText("\"<i></i>\"\n\n");
        outputText("\n\n");
        startCombat(new Werespider());
    }
    private function tfIntoWereSpider() : Void
    {
        clearOutput();
        outputText("\n\n");
    }
}

