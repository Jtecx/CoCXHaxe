/**
 * Coded by aimozg on 27.08.2017.
 */
package coc.xlogic;

import flash.errors.Error;
import classes.internals.Utils;

class Compiler
{
    public function new()
    {
    }
    public function compile(x : FastXML) : Statement
    {
        switch (x.node.nodeKind.innerData())
        {
            case "element":
                return compileTag(x.node.localName.innerData(), x);
            case "text":
                if (Utils.trimSides(Std.string(x)) == "")
                {
                    return null;
                }
                return compileText(x);
            default:
                return null;
        }
    }
    private function compileTag(tag : String, x : FastXML) : Statement
    {
        switch (tag)
        {
            case "if":
                return compileIf(x);
            case "switch":
                return compileSwitch(x);
            default:
                return unknownTag(tag, x);
        }
    }
    private function compileText(x : FastXML) : Statement
    {
        throw new Error("Encountered text element " + Std.string(x).substr(0, 20));
    }
    private function unknownTag(tag : String, x : FastXML) : Statement
    {
        throw new Error("Unknown tag " + tag);
    }
    public function compileChildren(x : FastXML) : StmtList
    {
        return new StmtList(compileChildrenInto(x, []));
    }
    private function compileChildrenInto(x : FastXML, stmts : Array<Dynamic>) : Array<Dynamic>
    {
        for (item/* AS3HX WARNING could not determine type for var: item exp: ECall(EField(EIdent(x),children),[]) type: null */ in x.nodes.children())
        {
            var e : Statement = compile(item);
            if (e != null)
            {
                stmts.push(e);
            }
        }
        return stmts;
    }
    public function compileXMLList(x : FastXMLList) : StmtList
    {
        return new StmtList(compileXMLListInto(x, []));
    }
    private function compileXMLListInto(x : FastXMLList, stmts : Array<Dynamic>) : Array<Dynamic>
    {
        for (item in x)
        {
            var e : Statement = compile(item);
            if (e != null)
            {
                stmts.push(e);
            }
        }
        return stmts;
    }
    public function compileIf(x : FastXML) : IfStmt
    {
        var item : FastXML;
        var attrs : Dynamic = attrMap(x);
        var iff : IfStmt = new IfStmt(Reflect.field(attrs, "test"));
        if (Lambda.has(attrs, "then"))
        {
            iff.thenBlock.push(compileText(x.att.then[0]));
        }
        if (Lambda.has(attrs, "else"))
        {
            iff.elseBlock = compileText(x.nodes.attribute("else")[0]);
        }
        //noinspection JSMismatchedCollectionQueryUpdate
        var currentBlock : Array<Dynamic> = iff.thenBlock;
        var currentIff : IfStmt = iff;
        for (item/* AS3HX WARNING could not determine type for var: item exp: ECall(EField(EIdent(x),children),[]) type: null */ in x.nodes.children())
        {
            switch (item.node.localName.innerData())
            {
                case "else":
                    iff.elseBlock = compileChildren(item);
                    currentBlock = (try cast(iff.elseBlock, StmtList) catch(e:Dynamic) null).stmts;
                case "elseif":
                    currentIff = compileIf(item);
                    iff.elseBlock = currentIff;
                    currentBlock = currentIff.thenBlock;
                default:
                    var e : Statement = compile(item);
                    if (e != null)
                    {
                        currentBlock.push(e);
                    }
            }
        }
        return iff;
    }
    public function compileSwitch(x : FastXML) : SwitchStmt
    {
        var sattrs : Dynamic = attrMap(x);
        var hasval : Bool = Lambda.has(sattrs, "value");
        var zwitch : SwitchStmt = new SwitchStmt(Reflect.field(sattrs, "value"));
        for (xcase/* AS3HX WARNING could not determine type for var: xcase exp: ECall(EField(EIdent(x),elements),[]) type: null */ in x.nodes.elements())
        {
            switch (xcase.localName())
            {
                case "case":
                    var cattrs : Dynamic = attrMap(xcase);
                    var caze : CaseStmt = new CaseStmt();
                    caze.testAttr = Reflect.field(cattrs, "test");
                    caze.valueAttr = Reflect.field(cattrs, "value");
                    caze.valuesAttr = Reflect.field(cattrs, "values");
                    caze.ltAttr = Reflect.field(cattrs, "lt");
                    caze.lteAttr = Reflect.field(cattrs, "lte");
                    caze.gtAttr = Reflect.field(cattrs, "gt");
                    caze.gteAttr = Reflect.field(cattrs, "gte");
                    caze.neAttr = Reflect.field(cattrs, "ne");
                    compileChildrenInto(xcase, caze.thenBlock.stmts);
                    zwitch.cases.push(caze);
                case "default":
                    compileChildrenInto(xcase, zwitch.defaults.stmts);
            }
        }
        return zwitch;
    }
    public static function attrMap(x : FastXML) : Dynamic
    {
        var e : Dynamic = { };
        for (k/* AS3HX WARNING could not determine type for var: k exp: ECall(EField(EIdent(x),attributes),[]) type: null */ in x.nodes.attributes())
        {
            Reflect.setField(e, Std.string(k.localName()), Std.string(k));
        }
        return e;
    }
}

