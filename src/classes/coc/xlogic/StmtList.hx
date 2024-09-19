/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;


class StmtList extends Statement
{
    public var stmts(get, never) : Array<Dynamic>;

    private var _stmts : Array<Dynamic> = [];
    
    private function get_stmts() : Array<Dynamic>
    {
        return _stmts;
    }
    public function new(init : Array<Dynamic> = null)
    {
        super();
        if (init != null)
        {
            _stmts.push.apply(_stmts, init);
        }
    }
    
    override public function execute(context : ExecContext) : Void
    {
        context.executeAll(_stmts);
    }
}

