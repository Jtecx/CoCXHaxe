/**
 * Coded by aimozg on 28.07.2018.
 */
package classes.stats;


interface IStatHolder
{

    /*
	 Reference implementation:
	 
	 public function findStat(fullname:String):IStat;
	     if (fullname.indexOf('.') == -1) return local_private_stat_object[fullname];
	     return StatUtils.findStatByPath(this, fullname);
	 }

	 */
    function findStat(fullname : String) : IStat
    ;
    function allStats() : Array<Dynamic>
    ;
    function allStatNames() : Array<Dynamic>
    ;
}

