/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import classes.CoCSettings;

class Statement
{
    public function new()
    {
    }
    public function execute(context : ExecContext) : Void
    {
        CoC_Settings.errorAMC("coc.xlogic.Statement", "execute", "" + this);
    }
}

