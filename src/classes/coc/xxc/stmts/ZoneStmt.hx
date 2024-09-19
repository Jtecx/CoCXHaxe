/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc.stmts;

import classes.scenes.aPI.GroupEncounter;
import coc.script.Eval;
import coc.xlogic.ExecContext;
import coc.xlogic.Statement;
import coc.xxc.Story;

class ZoneStmt extends Story
{
    public var encounters : GroupEncounter;
    private var lastContext : ExecContext;
    public function new(parent : Story, name : String)
    {
        super("zone", parent, name, false);
        this.encounters = new GroupEncounter(name, []);
    }
    public static function wrap(group : GroupEncounter, parent : Story, rename : String = "") : ZoneStmt
    {
        var zone : ZoneStmt = new ZoneStmt(parent, rename || group.encounterName());
        zone.encounters = group;
        return zone;
    }
    public function add(content : Story, chance : String = null, when : String = null) : Void
    {
        var fchance : Eval = (chance != null) ? Eval.compile(chance) : null;
        var fwhen : Eval = (when != null) ? Eval.compile(when) : null;
        this.encounters.add({
                    name : content.name,
                    call : function() : Void
                    {
                        content.execute(lastContext);
                    },
                    chance : (fchance != null) ? function() : Dynamic
                    {
                        return fchance.vcall((lastContext != null) ? lastContext.scopes : []);
                    } : null,
                    when : (fwhen != null) ? function() : Dynamic
                    {
                        return fwhen.vcall((lastContext != null) ? lastContext.scopes : []);
                    } : null
                });
    }
    override public function execute(context : ExecContext) : Void
    {
        lastContext = context;
        super.execute(context);
        encounters.execEncounter();
        lastContext = null;
    }
}

