package classes.internals.race;

import haxe.Constraints.Function;
import classes.Race;

class ConditionedRaceScoreBuilder extends RaceScoreBuilder
{
    private var condition : Function;
    private var conditionName : String;
    public function new(
            race : Race,
            condition : Function,
            conditionName : String,
            minScore : Int)
    {
        super(race, minScore);
        this.condition = condition;
        this.conditionName = conditionName;
    }
    
    override private function addRequirement(requirement : RacialRequirement, customName : String = "") : Void
    {
        super.addRequirement(requirement.withCondition(condition, conditionName), customName);
    }
}

