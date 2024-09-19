package classes;


class PregnancyStore extends Dynamic
{
    public var type(get, never) : Int;
    public var incubation(get, never) : Int;
    public var buttType(get, never) : Int;
    public var buttIncubation(get, never) : Int;
    public var isPregnant(get, never) : Bool;
    public var isButtPregnant(get, never) : Bool;
    public var event(get, never) : Int;
    public var buttEvent(get, never) : Int;

    public static function getIncubation(pregType : Int) : Int
    {
        switch (pregType)
        {
            case PREGNANCY_IMP:return INCUBATION_IMP;
            case PREGNANCY_MINOTAUR:return INCUBATION_MINOTAUR;
            case PREGNANCY_COCKATRICE:return INCUBATION_COCKATRICE;
            case PREGNANCY_MOUSE:return INCUBATION_MOUSE;
            case PREGNANCY_OVIELIXIR_EGGS:return INCUBATION_OVIELIXIR_EGGS;
            case PREGNANCY_HELL_HOUND:return INCUBATION_HELL_HOUND;
            case PREGNANCY_CENTAUR:return INCUBATION_CENTAUR;
            case PREGNANCY_MARBLE:return INCUBATION_MARBLE;
            case PREGNANCY_BUNNY:return INCUBATION_BUNNY_EGGS;
            case PREGNANCY_ANEMONE:return INCUBATION_ANEMONE;
            case PREGNANCY_AMILY:return INCUBATION_MOUSE;
            case PREGNANCY_IZMA:return INCUBATION_IZMA;
            case PREGNANCY_SPIDER:return INCUBATION_SPIDER;
            case PREGNANCY_BASILISK:return INCUBATION_BASILISK;
            case PREGNANCY_DRIDER_EGGS:return INCUBATION_DRIDER;
            case PREGNANCY_GOO_GIRL:return INCUBATION_GOO_GIRL;
            case PREGNANCY_EMBER:return INCUBATION_EMBER;
            case PREGNANCY_BENOIT:return INCUBATION_BASILISK;
            case PREGNANCY_SATYR:return INCUBATION_SATYR;
            case PREGNANCY_COTTON:return INCUBATION_COTTON;
            case PREGNANCY_URTA:return INCUBATION_URTA;
            case PREGNANCY_SAND_WITCH:return INCUBATION_SAND_WITCH;
            case PREGNANCY_FROG_GIRL:return INCUBATION_FROG_GIRL;
            case PREGNANCY_FAERIE:return INCUBATION_FAERIE;
            case PREGNANCY_BEE_EGGS:return INCUBATION_BEE;
            case PREGNANCY_SANDTRAP_FERTILE:return INCUBATION_SANDTRAP;
            case PREGNANCY_SANDTRAP:return INCUBATION_SANDTRAP;
            case PREGNANCY_JOJO:return INCUBATION_MOUSE;
            case PREGNANCY_KELT:return INCUBATION_CENTAUR;
            case PREGNANCY_MINERVA:return INCUBATION_MINERVA;
            case PREGNANCY_BEHEMOTH:return INCUBATION_BEHEMOTH;
            case PREGNANCY_QUASI_PHOENIX:return INCUBATION_QUASI_PHOENIX;
            case PREGNANCY_ALRAUNE:return INCUBATION_ALRAUNE;
            case PREGNANCY_CELESS:return INCUBATION_CELESS;
            case PREGNANCY_GOBLIN:return INCUBATION_GOBLIN;
            case PREGNANCY_ZENJI:return INCUBATION_ZENJI;
            case PREGNANCY_LOPPE:return INCUBATION_LOPPE;
            //case PREGNANCY_SIDONIE: return INCUBATION_SIDONIE;
            //case PREGNANCY_ARIAN: return INCUBATION_ARIAN;
            default:return -1;
        }
    }
    
    //Pregancy types. Both butt and normal. Each type represents the father of this baby.
    public static inline var PREGNANCY_IMP : Int = 1;
    public static inline var PREGNANCY_MINOTAUR : Int = 2;
    public static inline var PREGNANCY_COCKATRICE : Int = 3;
    public static inline var PREGNANCY_MOUSE : Int = 4;
    public static inline var PREGNANCY_OVIELIXIR_EGGS : Int = 5;  //Also caused by Phoenixes apparently  
    public static inline var PREGNANCY_HELL_HOUND : Int = 6;
    public static inline var PREGNANCY_CENTAUR : Int = 7;
    public static inline var PREGNANCY_MARBLE : Int = 8;
    public static inline var PREGNANCY_BUNNY : Int = 9;
    public static inline var PREGNANCY_ANEMONE : Int = 10;
    public static inline var PREGNANCY_AMILY : Int = 11;
    public static inline var PREGNANCY_IZMA : Int = 12;
    public static inline var PREGNANCY_SPIDER : Int = 13;
    public static inline var PREGNANCY_BASILISK : Int = 14;
    public static inline var PREGNANCY_DRIDER_EGGS : Int = 15;
    public static inline var PREGNANCY_GOO_GIRL : Int = 16;
    public static inline var PREGNANCY_EMBER : Int = 17;
    public static inline var PREGNANCY_BENOIT : Int = 18;
    public static inline var PREGNANCY_SATYR : Int = 19;
    public static inline var PREGNANCY_COTTON : Int = 20;
    public static inline var PREGNANCY_URTA : Int = 21;
    public static inline var PREGNANCY_SAND_WITCH : Int = 22;
    public static inline var PREGNANCY_FROG_GIRL : Int = 23;
    public static inline var PREGNANCY_FAERIE : Int = 24;  //Indicates you are carrying either a phouka or faerie baby. Which one is determined by the PREGNANCY_CORRUPTION flag  
    public static inline var PREGNANCY_PLAYER : Int = 25;  //The player is the father. Will be used when an NPC is able to have children from multiple different fathers.  
    public static inline var PREGNANCY_BEE_EGGS : Int = 26;
    public static inline var PREGNANCY_SANDTRAP_FERTILE : Int = 27;
    public static inline var PREGNANCY_SANDTRAP : Int = 28;
    public static inline var PREGNANCY_JOJO : Int = 29;  //So we can track them separately from other mouse pregnancies  
    public static inline var PREGNANCY_KELT : Int = 30;  //So we can track them separately from other centaur pregnancies  
    public static inline var PREGNANCY_TAOTH : Int = 31;
    public static inline var PREGNANCY_GOO_STUFFED : Int = 32;  //Used to fill the player's ass and/or vagina when Valeria has a goo girl take up residence. This prevents any other  
    //form of pregnancy from taking hold. Does not respond to ovielixirs.
    public static inline var PREGNANCY_WORM_STUFFED : Int = 33;  //Used to fill the player's vagina when the worms take up residence. This prevents any other form of  
    //pregnancy from taking hold. Does not respond to ovielixirs.
    public static inline var PREGNANCY_MINERVA : Int = 34;
    public static inline var PREGNANCY_BEHEMOTH : Int = 35;
    public static inline var PREGNANCY_QUASI_PHOENIX : Int = 36;
    public static inline var PREGNANCY_ALRAUNE : Int = 38;
    public static inline var PREGNANCY_CELESS : Int = 39;
    public static inline var PREGNANCY_GOBLIN : Int = 40;
    public static inline var PREGNANCY_ZENJI : Int = 41;
    public static inline var PREGNANCY_AYANE : Int = 42;  //This is a placeholder for a future expansion.  
    public static inline var PREGNANCY_ANT_EGGS : Int = 43;
    public static inline var PREGNANCY_MANTIS_EGGS : Int = 44;
    public static inline var PREGNANCY_HARPY_EGGS : Int = 45;  //All Harpy eggs  
    public static inline var PREGNANCY_HARPY_HATCHING : Int = 46;
    public static inline var PREGNANCY_LOPPE : Int = 47;
    public static inline var PREGNANCY_ELECTRA : Int = 48;
    public static inline var PREGNANCY_LUNA : Int = 49;
    public static inline var PREGNANCY_NADIA : Int = 50;
    
    public static inline var INCUBATION_IMP : Int = 432;  //Time for standard imps. Imp lords, Ceraph, Lilium and the imp horde cause slightly faster pregnancies  
    public static inline var INCUBATION_MINOTAUR : Int = 432;
    public static inline var INCUBATION_MOUSE : Int = 350;
    public static inline var INCUBATION_OVIELIXIR_EGGS : Int = 50;
    public static inline var INCUBATION_HELL_HOUND : Int = 352;
    public static inline var INCUBATION_CENTAUR : Int = 420;
    public static inline var INCUBATION_MARBLE : Int = 368;
    public static inline var INCUBATION_BUNNY_BABY : Int = 200;
    public static inline var INCUBATION_BUNNY_EGGS : Int = 808;  //High time indicates neon egg pregnancy  
    public static inline var INCUBATION_ANEMONE : Int = 256;
    public static inline var INCUBATION_IZMA : Int = 300;
    public static inline var INCUBATION_SPIDER : Int = 400;
    public static inline var INCUBATION_BASILISK : Int = 250;
    public static inline var INCUBATION_COCKATRICE : Int = 225;
    public static inline var INCUBATION_DRIDER : Int = 400;
    public static inline var INCUBATION_GOO_GIRL : Int = 85;
    public static inline var INCUBATION_EMBER : Int = 336;
    public static inline var INCUBATION_SATYR : Int = 160;
    public static inline var INCUBATION_COTTON : Int = 350;
    public static inline var INCUBATION_URTA : Int = 515;
    public static inline var INCUBATION_SAND_WITCH : Int = 360;
    public static inline var INCUBATION_FROG_GIRL : Int = 30;
    public static inline var INCUBATION_FAERIE : Int = 200;
    public static inline var INCUBATION_BEE : Int = 48;
    public static inline var INCUBATION_SANDTRAP : Int = 42;
    public static inline var INCUBATION_HARPY : Int = 168;
    public static inline var INCUBATION_SHIELA : Int = 72;
    public static inline var INCUBATION_SALAMANDER : Int = 336;
    public static inline var INCUBATION_MINERVA : Int = 216;
    public static inline var INCUBATION_BEHEMOTH : Int = 1440;  //Sorry Behemoth, but Isabella wins.  
    public static inline var INCUBATION_QUASI_PHOENIX : Int = 192;
    public static inline var INCUBATION_KIHA : Int = 384;
    public static inline var INCUBATION_ISABELLA : Int = 2160;  //Longest pregnancy ever.  
    public static inline var INCUBATION_ALRAUNE : Int = 168;
    public static inline var INCUBATION_CELESS : Int = 720;
    public static inline var INCUBATION_GOBLIN : Int = 168;
    public static inline var INCUBATION_MITZI : Int = 312;
    public static inline var INCUBATION_EXCELLIA : Int = 480;
    public static inline var INCUBATION_ZENJI : Int = 720;
    public static inline var INCUBATION_AYANE : Int = 336;
    public static inline var INCUBATION_ETNA : Int = 300;
    public static inline var INCUBATION_CHI_CHI : Int = 300;
    /*public static const INCUBATION_BELISA:int				= 300;
		public static const INCUBATION_LILY:int					= 300;
		public static const INCUBATION_TYRANTIA:int				= 300;*/
    public static inline var INCUBATION_LOPPE : Int = 200;
    public static inline var INCUBATION_ARIAN : Int = 150;
    public static inline var INCUBATION_SIDONIE : Int = 250;
    public static inline var INCUBATION_ELECTRA : Int = 250;
    public static inline var INCUBATION_LUNA : Int = 300;
    public static inline var INCUBATION_NADIA : Int = 300;
    private static inline var MAX_FLAG_VALUE : Int = 2999;
    private static inline var PREG_TYPE_MASK : Int = 0x0000FFFF;  //Should be safe with 65535 different pregnancy types  
    private static inline var PREG_NOTICE_MASK : Int = 0x7FFF0000;  //Use upper half to store the latest stages of pregnancy the player has noticed  
    
    private var _pregnancyTypeFlag : Int;
    private var _pregnancyIncubationFlag : Int;
    private var _buttPregnancyTypeFlag : Int;
    private var _buttPregnancyIncubationFlag : Int;
    private var _pregnancyEventValue : Array<Array<Int>>;  //Using a vector of vectors so that each different pregnancy type can have its own set of events  
    private var _buttPregnancyEventValue : Array<Array<Int>>;
    
    //All the flags are passed through the constructor so that they can be different in every class that uses PregnancyStore but the pregnancy code remains the same
    public function new(pregType : Int, pregInc : Int, buttPregType : Int, buttPregInc : Int)
    {
        super();
        _pregnancyTypeFlag = pregType;
        _pregnancyIncubationFlag = pregInc;
        _buttPregnancyTypeFlag = buttPregType;
        _buttPregnancyIncubationFlag = buttPregInc;
        _pregnancyEventValue = new Array<Array<Int>>();
        _buttPregnancyEventValue = new Array<Array<Int>>();
        if (pregType < 0 || pregType > MAX_FLAG_VALUE || pregInc < 0 || pregInc > MAX_FLAG_VALUE || buttPregType < 0 || buttPregType > MAX_FLAG_VALUE || buttPregInc < 0 || buttPregInc > MAX_FLAG_VALUE || pregType == buttPregType || pregInc == buttPregInc)
        {
            CoC_Settings.error("PregnancyStore created with invalid values for its flags. PregnancyStore(" + pregType + ", " + pregInc + ", " + buttPregType + ", " + buttPregInc + ")");
        }
    }
    
    private function get_type() : Int
    {
        return ((_pregnancyTypeFlag == 0) ? 0 : CoC.instance.flags[_pregnancyTypeFlag] & PREG_TYPE_MASK);
    }
    
    private function get_incubation() : Int
    {
        return ((_pregnancyIncubationFlag == 0) ? 0 : CoC.instance.flags[_pregnancyIncubationFlag]);
    }
    
    private function get_buttType() : Int
    {
        return ((_buttPregnancyTypeFlag == 0) ? 0 : CoC.instance.flags[_buttPregnancyTypeFlag] & PREG_TYPE_MASK);
    }
    
    private function get_buttIncubation() : Int
    {
        return ((_buttPregnancyIncubationFlag == 0) ? 0 : CoC.instance.flags[_buttPregnancyIncubationFlag]);
    }
    
    private function get_isPregnant() : Bool
    {
        return type != 0;
    }  //At birth the incubation can be zero so a check vs. type is safer  
    
    private function get_isButtPregnant() : Bool
    {
        return buttType != 0;
    }  //At birth the incubation can be zero so a check vs. type is safer  
    
    /* Using this function adds a series of events which happen during the pregnancy. They must be added in descending order (ex. 500, 450, 350, 225, 100, 25)
		   to work properly. For NPCs who have multiple pregnancy types each type has its own set of events. Events can be used to see how far along the NPC
		   is in her pregnancy with the event property. They can also be checked using the eventTriggered() function. This checks to see which was the latest event
		   the player noticed. The eventTriggered() function only triggers once per event per pregnancy. */
    public function addPregnancyEventSet(pregType : Int, pregStage : Array<Dynamic> = null) : Void
    {
        var pregVector : Array<Int> = new Array<Int>();
        pregVector[0] = pregType;  //First element is the pregnancy type  
        for (i in 0...pregStage.length)
        {
            pregVector[i + 1] = pregStage[i];
        }
        pregVector[pregVector.length - 1] = -1;  //Make last element -1 to ensure there is always a match  
        _pregnancyEventValue.push(pregVector);
    }
    
    //Same as addPregnancyEventSet, but for butts
    public function addButtPregnancyEventSet(buttPregType : Int, buttPregStage : Array<Dynamic> = null) : Void
    {
        var pregVector : Array<Int> = new Array<Int>();
        pregVector[0] = buttPregType;  //First element is the butt pregnancy type  
        for (i in 0...buttPregStage.length)
        {
            pregVector[i + 1] = buttPregStage[i];
        }
        pregVector[pregVector.length - 1] = -1;  //Make last element -1 to ensure there is always a match  
        _buttPregnancyEventValue.push(pregVector);
    }
    
    public function knockUp(newPregType : Int = 0, newPregIncubation : Int = 0) : Void
    {
        if (!isPregnant)
        {
            knockUpForce(newPregType, newPregIncubation);
        }
    }
    
    public function knockUpForce(newPregType : Int = 0, newPregIncubation : Int = 0, ignoreGargoyle : Bool = false) : Void
    {
        newPregIncubation = CoC.instance.gameSettings.sceneHunter_inst.shortPregTimer(newPregIncubation);
        if (CoC.instance.player.isGargoyle() && newPregType == PREGNANCY_PLAYER && !ignoreGargoyle)
        {
            return;
        }  //gargoyles can't impreg  
        if (_pregnancyTypeFlag == 0 || _pregnancyIncubationFlag == 0)
        {
            return;
        }  //Check that these variables were provided by the containing class  
        if (newPregType != 0)
        {
            newPregType = as3hx.Compat.parseInt((CoC.instance.flags[_pregnancyTypeFlag] & PREG_NOTICE_MASK) + newPregType);
        }
        //If a pregnancy 'continues' an existing pregnancy then do not change the value for last noticed stage
        CoC.instance.flags[_pregnancyTypeFlag] = newPregType;
        CoC.instance.flags[_pregnancyIncubationFlag] = ((newPregType == 0) ? 0 : newPregIncubation);
    }
    
    public function buttKnockUp(newPregType : Int = 0, newPregIncubation : Int = 0) : Void
    {
        if (!isButtPregnant)
        {
            buttKnockUpForce(newPregType, newPregIncubation);
        }
    }
    
    public function buttKnockUpForce(newPregType : Int = 0, newPregIncubation : Int = 0) : Void
    {
        newPregIncubation = CoC.instance.gameSettings.sceneHunter_inst.shortPregTimer(newPregIncubation);
        if (CoC.instance.player.isGargoyle())
        {
            return;
        }
        if (_buttPregnancyTypeFlag == 0 || _buttPregnancyIncubationFlag == 0)
        {
            return;
        }  //Check that these variables were provided by the containing class  
        if (newPregType != 0)
        {
            newPregType = as3hx.Compat.parseInt((CoC.instance.flags[_buttPregnancyTypeFlag] & PREG_NOTICE_MASK) + newPregType);
        }
        //If a pregnancy 'continues' an existing pregnancy then do not change the value for last noticed stage
        CoC.instance.flags[_buttPregnancyTypeFlag] = newPregType;
        CoC.instance.flags[_buttPregnancyIncubationFlag] = ((newPregType == 0) ? 0 : newPregIncubation);
    }
    
    //The containing class is responsible for calling pregnancyAdvance, usually once per timeChange()
    public function pregnancyAdvance() : Void  //Separate function so it can be called more often than timeChange if neccessary  
    {
        if (incubation != 0)
        {
            CoC.instance.flags[_pregnancyIncubationFlag]--;
            if (CoC.instance.flags[_pregnancyIncubationFlag] < 0)
            {
                CoC.instance.flags[_pregnancyIncubationFlag] = 0;
            }
        }
        if (buttIncubation != 0)
        {
            CoC.instance.flags[_buttPregnancyIncubationFlag]--;
            if (CoC.instance.flags[_buttPregnancyIncubationFlag] < 0)
            {
                CoC.instance.flags[_buttPregnancyIncubationFlag] = 0;
            }
        }
    }
    
    /* Many NPCs go through several events during their pregnancies. This function returns the latest event the NPC qualifies for.
		   When the NPC is not pregnant this always returns 0, when pregnant it will return at least 1. The further along the NPC is the larger the value. Each NPC
		   is free to have as many event as desired. They must be added using the addPregnancyEventSet function and are unique to each pregnancy type. */
    private function get_event() : Int
    {
        var pregType : Int = type;
        if (pregType == 0)
        {
            return 0;
        }  //Not pregnant  
        var incubationValue : Int = incubation;
        var pregEventVector : Array<Int> = null;
        for (i in 0..._pregnancyEventValue.length)
        {
            pregEventVector = _pregnancyEventValue[i];
            if (pregEventVector[0] == pregType)
            {
                for (j in 1...pregEventVector.length)
                
                //Skip element zero, the pregnancy type{
                    
                    if (incubationValue > ((CoC.instance.gameSettings.sceneHunter_inst.shortPreg) ? 
                        Math.round(pregEventVector[j] / pregEventVector[1] * CoC.instance.gameSettings.sceneHunter_inst.shortPregTimer(pregEventVector[1]))  // 1 usually stores zero-hour stuff   : pregEventVector[j]))
                    {
                        return j;
                    }
                }
            }
        }
        return 1;
    }
    
    //The same event system as for vaginal pregnacies, but for butts
    private function get_buttEvent() : Int
    {
        var pregType : Int = buttType;
        if (pregType == 0)
        {
            return 0;
        }  //Not pregnant  
        var incubationValue : Int = buttIncubation;
        var pregEventVector : Array<Int> = null;
        for (i in 0..._buttPregnancyEventValue.length)
        {
            pregEventVector = _buttPregnancyEventValue[i];
            if (pregEventVector[0] == pregType)
            {
                for (j in 1...pregEventVector.length)
                
                //Skip element zero, the pregnancy type{
                    
                    if (incubationValue > ((CoC.instance.gameSettings.sceneHunter_inst.shortPreg) ? 
                        Math.round(pregEventVector[j] / pregEventVector[1] * CoC.instance.gameSettings.sceneHunter_inst.shortPregTimer(pregEventVector[1]))  // 1 usually stores zero-hour stuff   : pregEventVector[j]))
                    {
                        return j;
                    }
                }
            }
        }
        return 1;
    }
    
    //Returns either zero - for no change - or the value of the new pregnancy event which the player has not yet noticed
    //This function updates the noticed pregnancy event, so it only triggers once per event per pregnancy.
    public function eventTriggered() : Int
    {
        var currentStage : Int = event;
        var lastNoticed : Int = CoC.instance.flags[_pregnancyTypeFlag] & PREG_NOTICE_MASK;
        if (currentStage * 65536 == lastNoticed)
        {
            return 0;
        }  //Player has already noticed this stage  
        CoC.instance.flags[_pregnancyTypeFlag] = (CoC.instance.flags[_pregnancyTypeFlag] & PREG_TYPE_MASK) + (currentStage * 65536);
        //Strip off the old noticed value by ANDing with PREG_TYPE_MASK
        return currentStage;
    }
    
    //Same as eventTriggered, but for butts
    public function buttEventTriggered() : Int
    {
        var currentStage : Int = buttEvent;
        var lastNoticed : Int = CoC.instance.flags[_buttPregnancyTypeFlag] & PREG_NOTICE_MASK;
        if (currentStage * 65536 == lastNoticed)
        {
            return 0;
        }  //Player has already noticed this stage  
        CoC.instance.flags[_buttPregnancyTypeFlag] = (CoC.instance.flags[_buttPregnancyTypeFlag] & PREG_TYPE_MASK) + (currentStage * 65536);
        //Strip off the old noticed value by ANDing with PREG_TYPE_MASK
        return currentStage;
    }
}
