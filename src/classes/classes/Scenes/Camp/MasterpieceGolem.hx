/**
 * ...
 * @author Ormael
 */
package classes.scenes.camp;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.internals.SaveableState;

class MasterpieceGolem extends BaseContent
{  /*
		public static var GhostInTheMachine:Boolean; - 2nd major upgrade
		public static var SentientCore:Boolean; - 1st major upgrade
		public static var ElementalWeaponry:Boolean;
		public static var PoisonedWeaponry:Boolean;
		public static var MultiAttacks:Number;
		public static var ImprovedManaCircuit:Number;
		public static var ElementalWeaponryType:Number;
		public static var MultiAttacksRank:Number;
Extra armor
Lazers
Spells
A grapple
Stuns
Mace for arms
Poisoned weaponry
Magic eater
Mana syphon?
		
		public function stateObjectName():String {
			return "MasterpieceGolem";
		}

		public function resetState():void {
			GhostInTheMachine = false;
			SentientCore = false;
			ElementalWeaponry = false;
			PoisonedWeaponry = false;
			MultiAttacks = 0;
			ImprovedManaCircuit = 0;
			ElementalWeaponryType = 0;
			MultiAttacksRank = 0;
		}

		public function saveToObject():Object {
			return {
				"GhostInTheMachine": GhostInTheMachine,
				"SentientCore": SentientCore,
				"ElementalWeaponry": ElementalWeaponry,
				"PoisonedWeaponry": PoisonedWeaponry,
				"MultiAttacks": MultiAttacks,
				"ImprovedManaCircuit": ImprovedManaCircuit,
				"ElementalWeaponryType": ElementalWeaponryType,
				"MultiAttacksRank": MultiAttacksRank
			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				GhostInTheMachine = o["GhostInTheMachine"];
				SentientCore = o["SentientCore"];
				ElementalWeaponry = o["ElementalWeaponry"];
				PoisonedWeaponry = o["PoisonedWeaponry"];
				MultiAttacks = o["MultiAttacks"];
				ImprovedManaCircuit = o["ImprovedManaCircuit"];
				ElementalWeaponryType = o["ElementalWeaponryType"];
				MultiAttacksRank = o["MultiAttacksRank"];
			} else {
				// loading from old save
				resetState();
			}
		}
		*/  
    public function new()
    {
        super();
        //Saves.registerSaveableState(this);
        
    }
}

