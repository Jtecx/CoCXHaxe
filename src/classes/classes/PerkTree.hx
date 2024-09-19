/**
 * Created by aimozg on 22.05.2017.
 */
package classes;

import flash.utils.Dictionary;
import classes.PerkType;

class PerkTree extends BaseContent
{
    /*
	 perk.id => PerkTreeEntry
	 */
    private static var pdata : Dictionary = new Dictionary();
    
    public function new()
    {
        super();
        var library : Dictionary = PerkType.getPerkLibrary();
        var perk : PerkType;
        var entry : PerkTreeEntry;
        var req : Dynamic;
        // 0. Initialize PerkTreeEntries
        for (perk/* AS3HX WARNING could not determine type for var: perk exp: EIdent(library) type: Dictionary */ in library)
        
        //var perk:PerkType = library[k];{
            
            entry = new PerkTreeEntry(perk);
            pdata[perk.id] = entry;
            if (perk.requirements.length > 0)
            {
                perk.distance = PerkType.DISTANCE_STARTING;
            }
            for (req/* AS3HX WARNING could not determine type for var: req exp: EField(EIdent(perk),requirements) type: null */ in perk.requirements)
            
            // Starting perk distance{
                
                if (Std.is(req.distance, Float) && !Math.isNaN(req.distance))
                {
                    perk.distance += req.distance;
                }
            }
        }
        // 1. Build PerkTreeEntry.unlocks array - for every perk i, for every requirement j, add i to j.unlocks
        var processedIds : Dynamic = { };  // processed perk ids  
        var queue : Array<Dynamic> = [];
        for (perk/* AS3HX WARNING could not determine type for var: perk exp: EIdent(library) type: Dictionary */ in library)
        {
            entry = pdata[perk.id];
            var done : Bool = true;
            for (req/* AS3HX WARNING could not determine type for var: req exp: EField(EIdent(perk),requirements) type: null */ in perk.requirements)
            {
                var p2 : PerkType;
                var _sw1_ = (req.type);                

                switch (_sw1_)
                {
                    case "perk":
                        done = false;
                        p2 = req.perk;
                        (try cast(pdata[p2.id], PerkTreeEntry) catch(e:Dynamic) null).unlocks.push(entry);
                    case "anyperk":
                        done = false;
                        var ps : Array<Dynamic> = req.perks;
                        for (p2 in ps)
                        {
                            (try cast(pdata[p2.id], PerkTreeEntry) catch(e:Dynamic) null).unlocks.push(entry);
                        }
                    case "allperks":
                        done = false;
                        var aps : Array<Dynamic> = req.allperks;
                        for (p2 in aps)
                        {
                            (try cast(pdata[p2.id], PerkTreeEntry) catch(e:Dynamic) null).unlocks.push(entry);
                        }
                }
            }
            if (done)
            {
                Reflect.setField(processedIds, Std.string(perk.id), true);
                if (perk.requirements.length > 0)
                {
                    perksByDistance.push(perk);
                }
            }
            else
            {
                queue.push(perk);
            }
        }
        // 2. Compute perk distance for perk/anyperk/allperks requirements
        while (queue.length > 0)
        {
            var oldSz : Int = queue.length;
            var i : Int = as3hx.Compat.parseInt(queue.length - 1);
            while (i >= 0)
            {
                perk = queue[i];
                entry = pdata[perk.id];
                done = true;
                for (req/* AS3HX WARNING could not determine type for var: req exp: EField(EIdent(perk),requirements) type: null */ in perk.requirements)
                {
                    var _sw2_ = (req.type);                    

                    switch (_sw2_)
                    {
                        case "perk":
                            p2 = req.perk;
                            if (Reflect.field(processedIds, Std.string(p2.id)) != null)
                            {
                                perk.distance = Math.max(perk.distance, p2.distance) + PerkType.DISTANCE_PER_PERK;
                            }
                            else
                            {
                                done = false;
                            }
                        case "anyperk":
                            var mindist : Float = Infinity;
                            for (p2/* AS3HX WARNING could not determine type for var: p2 exp: EField(EIdent(req),perks) type: null */ in req.perks)
                            {
                                if (Reflect.field(processedIds, Std.string(p2.id)) != null)
                                {
                                    mindist = Math.min(mindist, p2.distance);
                                }
                                else
                                {
                                    done = false;
                                    break;
                                }
                            }
                            if (done && Math.isFinite(mindist))
                            {
                                perk.distance = Math.max(perk.distance, mindist) + PerkType.DISTANCE_PER_PERK;
                            }
                        case "allperks":
                            var maxdist : Float = -Infinity;
                            for (p2/* AS3HX WARNING could not determine type for var: p2 exp: EField(EIdent(req),allperks) type: null */ in req.allperks)
                            {
                                if (Reflect.field(processedIds, Std.string(p2.id)) != null)
                                {
                                    maxdist = Math.max(maxdist, p2.distance);
                                }
                                else
                                {
                                    done = false;
                                    break;
                                }
                            }
                            if (done && Math.isFinite(maxdist))
                            {
                                perk.distance = Math.max(perk.distance, maxdist) + PerkType.DISTANCE_PER_PERK * req.allperks.length;
                            }
                    }
                }
                if (done)
                {
                    Reflect.setField(processedIds, Std.string(perk.id), true);
                    perksByDistance.push(perk);
                    // Remove i-th element: move last to i-th place and remove last
                    queue[i] = queue[queue.length - 1];
                    queue.pop();
                }
                i--;
            }
            if (queue.length >= oldSz)
            
            // Halt if queue was not changed{
                
                trace("[ERROR] PerkTree distance calculation stuck in a loop: queue.length = " + queue.length);
                break;
            }
        }
        if (queue.length > 0)
        {
            trace("[ERROR] Failed to compute distance of perks:");
            for (perk in queue)
            {
                trace("[ERROR]     " + perk.id);
            }
            trace("[ERROR]   (total " + queue.length + ")");
        }
        queue = [];
        perksByDistance.sortOn(["distance", "id"], Array.NUMERIC);
        /*
		if (CoC_Settings.debugBuild) {
			for each (perk in perksByDistance) {
				trace("" + perk.distance + " " + perk.id);
			}
		}
		 */
        // 3. Group perks by roots (jobs)
        var rootLists : Array<Dynamic> = [
        PerkLib.PRESTIGE_JOBS, 
        PerkLib.ADVANCED_JOBS, 
        PerkLib.BASIC_JOBS
    ];
        var job : PerkType;
        for (i in 0...rootLists.length)
        {
            var jobTier : Int = as3hx.Compat.parseInt(rootLists.length - i);
            for (job in rootLists[i])
            {
                if (listUnlocks(job).length == 0)
                {
                    trace("WARNING: Perk " + job.id + " listed as job but has no unlocks");
                    continue;
                }
                var unlocks : Array<Dynamic> = [];
                queue = listUnlocks(job);
                while (queue.length > 0)
                {
                    perk = queue.pop();
                    if (Std.is(perk, IMutationPerkType))
                    {
                        continue;
                    }
                    if (PerkLib.isJob(perk))
                    {
                        continue;
                    }
                    entry = pdata[perk.id];
                    if (entry == null)
                    {
                        continue;
                    }
                    if (entry.jobTier > jobTier)
                    {
                        continue;
                    }
                    if (entry.hasJob(job))
                    {
                        continue;
                    }
                    
                    entry.addJob(job, jobTier);
                    unlocks.push(perk);
                    pushAll(queue, listUnlocks(perk));
                }
                
                unlocks.sortOn(["distance", "id"], Array.NUMERIC);
                if (CoC_Settings.debugBuild)
                {
                    trace(job.id + " perks (" + unlocks.length + ")");
                }
                rootUnlocks[job.id] = unlocks;
            }
        }
    }
    
    /** perk.id -> PerkType[] sorted by distance  */
    private static var rootUnlocks : Dictionary = new Dictionary();
    /**
	 * Return all perks associated with this job:
	 * - require (directly on indirectly) this job
	 * - not a job perks themselves
	 * - do not require higher-tier job
	 */
    public static function getJobUnlocks(job : PerkType) : Array<Dynamic>
    {
        return rootUnlocks[job.id] || [];
    }
    public static function getJobs(perk : PerkType) : Array<Dynamic>
    {
        var entry : PerkTreeEntry = pdata[perk.id];
        if (entry == null)
        {
            return null;
        }
        if (entry.jobs && entry.jobs.length > 0)
        {
            return entry.jobs;
        }
        return null;
    }
    public static function hasJob(perk : PerkType, job : PerkType) : Bool
    {
        var entry : PerkTreeEntry = pdata[perk.id];
        if (entry == null)
        {
            return false;
        }
        return entry.hasJob(job);
    }
    
    public var perksByDistance : Array<Dynamic> = [];
    
    /**
	 * Returns Array of PerkType
	 */
    public function listUnlocks(p : PerkType) : Array<Dynamic>
    {
        if (pdata[p.id] == null)
        {
            return [];
        }
        return pdata[p.id].unlocks.map(function(entry : PerkTreeEntry, idx : Int, array : Array<Dynamic>) : PerkType
                {
                    return entry.perk;
                });
    }
    private static var obtanablePerksCached : Array<Dynamic> = null;
    /**
	 * Returns Array of PerkType
	 */
    public static function obtainablePerks() : Array<Dynamic>
    {
        if (obtanablePerksCached != null)
        {
            return obtanablePerksCached;
        }
        var rslt : Array<Dynamic> = [];
        for (perk/* AS3HX WARNING could not determine type for var: perk exp: ECall(EField(EIdent(PerkType),getPerkLibrary),[]) type: null */ in PerkType.getPerkLibrary())
        {
            if (perk.requirements.length > 0)
            {
                rslt.push(perk);
            }
        }
        obtanablePerksCached = rslt.sortOn("name");
        return obtanablePerksCached;
    }
    /**
	 * Returns Array of PerkType
	 */
    public static function availablePerks(player : Player, withMutations : Bool) : Array<Dynamic>
    {
        return obtainablePerks().filter(
                function(perk : PerkType, idx : Int, array : Array<Dynamic>) : Bool
                {
                    if (Std.is(perk, IMutationPerkType) && !withMutations)
                    {
                        return false;
                    }
                    return !player.hasPerk(perk) && perk.available(player);
                }
        );
    }
}



class PerkTreeEntry
{
    public var perk : PerkType;
    public var jobs : Array<Dynamic>;
    public var jobTier : Int = 0;
    public var unlocks : Array<Dynamic> = [];
    
    public function new(perk : PerkType)
    {
        this.perk = perk;
    }
    public function addJob(job : PerkType, tier : Int) : Void
    {
        if (jobs == null)
        {
            jobs = [];
        }
        jobs.push(job);
        jobTier = tier;
    }
    public function hasJob(job : PerkType) : Bool
    {
        return jobs && Lambda.indexOf(jobs, job) >= 0;
    }
}
