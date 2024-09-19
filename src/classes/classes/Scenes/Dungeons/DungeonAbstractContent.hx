package classes.scenes.dungeons;

import haxe.Constraints.Function;
import classes.BaseContent;
import classes.scenes.SceneLib;

class DungeonAbstractContent extends BaseContent
{
    private var dungeons(get, never) : DungeonEngine;

    public function new()
    {
        super();
    }
    
    public static var inDungeon : Bool = false;
    public static var dungeonLoc : Int = DUNGEON_CABIN;
    public static var inRoomedDungeon : Bool = false;
    public static var inRoomedDungeonResume : Function = null;
    
    private function get_dungeons() : DungeonEngine
    {
        return SceneLib.dungeons;
    }
    
    //Dungeon constants. Moved here so derived classes will have easier access to them
    public static var DUNGEON_CABIN : Int = -10;
    
    public static inline var DUNGEON_FACTORY_FOYER : Int = 0;
    public static inline var DUNGEON_FACTORY_BREAK_ROOM : Int = 1;
    public static inline var DUNGEON_FACTORY_PUMP_ROOM : Int = 2;
    public static inline var DUNGEON_FACTORY_FURNACE_ROOM : Int = 3;
    public static inline var DUNGEON_FACTORY_REPAIR_CLOSET : Int = 4;
    public static inline var DUNGEON_FACTORY_MAIN_CHAMBER : Int = 5;
    public static inline var DUNGEON_FACTORY_BATHROOM : Int = 6;
    public static inline var DUNGEON_FACTORY_FOREMANS_OFFICE : Int = 7;
    public static inline var DUNGEON_FACTORY_PUMP_CONTROL : Int = 8;
    public static inline var DUNGEON_FACTORY_STORE_ROOM : Int = 9;
    
    public static inline var DUNGEON_CAVE_ENTRANCE : Int = 10;
    public static inline var DUNGEON_CAVE_TUNNEL : Int = 11;
    public static inline var DUNGEON_CAVE_GATHERING_HALL : Int = 12;
    public static inline var DUNGEON_CAVE_FUNGUS_CAVERN : Int = 13;
    public static inline var DUNGEON_CAVE_TORTURE_ROOM : Int = 14;
    public static inline var DUNGEON_CAVE_SECRET_TUNNEL : Int = 15;
    public static inline var DUNGEON_CAVE_ZETAZ_CHAMBER : Int = 16;
    
    public static inline var DUNGEON_HEL_GUARD_HALL : Int = 17;
    public static inline var DUNGEON_HEL_WINE_CELLAR : Int = 18;
    public static inline var DUNGEON_HEL_STAIR_WELL : Int = 19;
    public static inline var DUNGEON_HEL_DUNGEON : Int = 20;
    public static inline var DUNGEON_HEL_MEZZANINE : Int = 21;
    public static inline var DUNGEON_HEL_THRONE_ROOM : Int = 22;
    
    public static inline var DUNGEON_WITCH_ENTRANCE_GATEWAY : Int = 23;
    public static inline var DUNGEON_WITCH_CAVERNOUS_COMMONS : Int = 24;
    public static inline var DUNGEON_WITCH_WEST_WARRENS_MAIN : Int = 25;
    public static inline var DUNGEON_WITCH_CHILDRENS_PLAYROOM : Int = 26;
    public static inline var DUNGEON_WITCH_PREGNANT_LUST_ROOM : Int = 27;
    public static inline var DUNGEON_WITCH_WEST_WARRENS_WEST : Int = 28;
    public static inline var DUNGEON_WITCH_NURSERY : Int = 29;
    public static inline var DUNGEON_WITCH_PHARMACY : Int = 30;
    public static inline var DUNGEON_WITCH_EAST_WARRENS_MAIN : Int = 31;
    public static inline var DUNGEON_WITCH_SLEEPING_CHAMBER : Int = 32;
    public static inline var DUNGEON_WITCH_BATH_ROOM : Int = 33;
    public static inline var DUNGEON_WITCH_EAST_WARRENS_EAST : Int = 34;
    public static inline var DUNGEON_WITCH_CUM_WITCH_BEDROOM : Int = 35;
    public static inline var DUNGEON_WITCH_CUM_WITCH_OFFICE : Int = 36;
    public static inline var DUNGEON_WITCH_SACRIFICIAL_ALTAR : Int = 37;
    public static inline var DUNGEON_WITCH_THRONE_ROOM : Int = 38;
    
    public static inline var DUNGEON_HIDDEN_CAVE_ENTRANCE : Int = 39;
    public static inline var DUNGEON_HIDDEN_CAVE_SE_UP : Int = 40;
    public static inline var DUNGEON_HIDDEN_CAVE_E_UP : Int = 41;
    public static inline var DUNGEON_HIDDEN_CAVE_NE_UP : Int = 42;
    public static inline var DUNGEON_HIDDEN_CAVE_N_UP : Int = 43;
    public static inline var DUNGEON_HIDDEN_CAVE_S_STAIRCASE : Int = 44;
    public static inline var DUNGEON_HIDDEN_CAVE_S_UP : Int = 45;
    public static inline var DUNGEON_HIDDEN_CAVE_S_STORAGE : Int = 46;
    public static inline var DUNGEON_HIDDEN_CAVE_NW_UP : Int = 47;
    public static inline var DUNGEON_HIDDEN_CAVE_W_UP : Int = 48;
    public static inline var DUNGEON_HIDDEN_CAVE_SW_UP : Int = 49;
    public static inline var DUNGEON_HIDDEN_CAVE_NARROW_T_E : Int = 50;
    public static inline var DUNGEON_HIDDEN_CAVE_NARROW_T : Int = 51;
    public static inline var DUNGEON_HIDDEN_CAVE_NARROW_T_N : Int = 52;
    public static inline var DUNGEON_HIDDEN_CAVE_L_STORAGE_W : Int = 53;
    public static inline var DUNGEON_HIDDEN_CAVE_L_STORAGE_E : Int = 54;
    public static inline var DUNGEON_HIDDEN_CAVE_S_STAIRCASE_B : Int = 55;
    public static inline var DUNGEON_HIDDEN_CAVE_TUNNEL_00 : Int = 56;
    public static inline var DUNGEON_HIDDEN_CAVE_TUNNEL_01 : Int = 57;
    public static inline var DUNGEON_HIDDEN_CAVE_TUNNEL_02 : Int = 58;
    public static inline var DUNGEON_HIDDEN_CAVE_TEDS_LAIR : Int = 59;
    public static inline var DUNGEON_HIDDEN_CAVE_SMALL_CAVE_W : Int = 60;
    public static inline var DUNGEON_HIDDEN_CAVE_MEDIUM_CAVE : Int = 61;
    public static inline var DUNGEON_HIDDEN_CAVE_SMALL_CAVE_E : Int = 62;
    public static inline var DUNGEON_HIDDEN_CAVE_SMALL_CAVE_N : Int = 63;
    
    public static inline var DUNGEON_DEN_OF_DESIRE_ENTRANCE : Int = 64;
    public static inline var DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA : Int = 65;
    public static inline var DUNGEON_DEN_OF_DESIRE_LABORATORY : Int = 66;
    public static inline var DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS : Int = 67;
    
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_01 : Int = 68;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_02 : Int = 69;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_03 : Int = 70;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_04 : Int = 71;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_05 : Int = 72;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_06 : Int = 73;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_07 : Int = 74;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_08 : Int = 75;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_09 : Int = 76;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_10 : Int = 77;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_11 : Int = 78;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_12 : Int = 79;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_13 : Int = 80;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_14 : Int = 81;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_15 : Int = 82;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_16 : Int = 83;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_17 : Int = 84;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_18 : Int = 85;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_19 : Int = 86;
    public static inline var DUNGEON_RIVER_FLOOR_01_ROOM_20 : Int = 87;
    
    public static inline var DUNGEON_ANZU_OUTSIDE : Int = 88;
    public static inline var DUNGEON_ANZU_HALL_FLOOR1 : Int = 89;
    public static inline var DUNGEON_ANZU_LIVING_ROOM : Int = 90;
    public static inline var DUNGEON_ANZU_BATHROOM : Int = 91;
    public static inline var DUNGEON_ANZU_DINING_ROOM : Int = 92;
    public static inline var DUNGEON_ANZU_KITCHEN : Int = 93;
    public static inline var DUNGEON_ANZU_HALL_FLOOR2 : Int = 94;
    public static inline var DUNGEON_ANZU_BEDROOM : Int = 95;
    public static inline var DUNGEON_ANZU_LIBRARY : Int = 96;
    public static inline var DUNGEON_ANZU_MULTIUSE_ROOM : Int = 97;
    public static inline var DUNGEON_ANZU_HALL_FLOOR3 : Int = 98;
    public static inline var DUNGEON_ANZU_PALACE_VAULTS : Int = 99;
    public static inline var DUNGEON_ANZU_ALCHEMY_ROOM : Int = 100;
    public static inline var DUNGEON_ANZU_ROOF : Int = 101;
    public static inline var DUNGEON_ANZU_BASEMENT : Int = 102;
    public static inline var DUNGEON_ANZU_ARMORY : Int = 103;
    
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_01 : Int = 104;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_02 : Int = 105;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_03 : Int = 106;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_04 : Int = 107;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_05 : Int = 108;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_06 : Int = 109;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_07 : Int = 110;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_08 : Int = 111;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_09 : Int = 112;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_10 : Int = 113;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_11 : Int = 114;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_12 : Int = 115;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_13 : Int = 116;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_14 : Int = 117;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_15 : Int = 118;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_16 : Int = 119;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_17 : Int = 120;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_18 : Int = 121;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_19 : Int = 122;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_20 : Int = 123;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_21 : Int = 124;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_22 : Int = 125;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_23 : Int = 126;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_24 : Int = 127;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_25 : Int = 128;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_26 : Int = 129;
    public static inline var DUNGEON_RIVER_FLOOR_02_ROOM_27 : Int = 130;
    
    public static inline var DUNGEON_EBON_LABYRINTH : Int = 131;
    
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_01 : Int = 135;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_02 : Int = 136;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_03 : Int = 137;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_04 : Int = 138;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_05 : Int = 139;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_06 : Int = 140;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_07 : Int = 141;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_08 : Int = 142;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_09 : Int = 143;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_10 : Int = 144;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_11 : Int = 145;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_12 : Int = 146;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_13 : Int = 147;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_14 : Int = 148;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_15 : Int = 149;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_16 : Int = 150;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_17 : Int = 151;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_18 : Int = 152;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_19 : Int = 153;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_20 : Int = 154;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_21 : Int = 155;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_22 : Int = 156;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_23 : Int = 157;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_24 : Int = 158;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_25 : Int = 159;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_26 : Int = 160;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_27 : Int = 161;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_28 : Int = 162;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_29 : Int = 163;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_30 : Int = 164;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_31 : Int = 165;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_32 : Int = 166;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_33 : Int = 167;
    public static inline var DUNGEON_RIVER_FLOOR_03_ROOM_34 : Int = 168;
    
    public static inline var DUNGEON_BEE_HIVE_1 : Int = 169;
    public static inline var DUNGEON_BEE_HIVE_2 : Int = 170;
    public static inline var DUNGEON_BEE_HIVE_3 : Int = 171;
    public static inline var DUNGEON_BEE_HIVE_4 : Int = 172;
    public static inline var DUNGEON_BEE_HIVE_5 : Int = 173;
    
    public static inline var DUNGEON_LAB_ENTRANCE : Int = 174;
    public static inline var DUNGEON_LAB_BALLROOM_1 : Int = 175;
    public static inline var DUNGEON_LAB_TYRANT_1 : Int = 176;
    public static inline var DUNGEON_LAB_TYRANT_PRISON : Int = 177;
    public static inline var DUNGEON_LAB_TYRANT_2 : Int = 178;
    public static inline var DUNGEON_LAB_BALLROOM_2 : Int = 179;
    public static inline var DUNGEON_LAB_FSPREADER : Int = 180;
    public static inline var DUNGEON_LAB_INCEL : Int = 181;
    public static inline var DUNGEON_LAB_BALLROOM_3 : Int = 182;
    public static inline var DUNGEON_LAB_NIGHTWALKER_1 : Int = 183;
    public static inline var DUNGEON_LAB_NIGHTWALKER_2 : Int = 184;
    public static inline var DUNGEON_LAB_PANIC_ROOM : Int = 185;
    
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_01 : Int = 186;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_02 : Int = 187;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_03 : Int = 188;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_04 : Int = 189;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_05 : Int = 190;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_06 : Int = 191;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_07 : Int = 192;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_08 : Int = 193;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_09 : Int = 194;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_10 : Int = 195;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_11 : Int = 196;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_12 : Int = 197;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_13 : Int = 198;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_14 : Int = 199;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_15 : Int = 200;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_16 : Int = 201;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_17 : Int = 202;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_18 : Int = 203;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_19 : Int = 204;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_20 : Int = 205;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_21 : Int = 206;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_22 : Int = 207;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_23 : Int = 208;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_24 : Int = 209;
    public static inline var DUNGEON_RIVER_FLOOR_04_ROOM_25 : Int = 210;
    
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_01 : Int = 211;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_02 : Int = 212;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_03 : Int = 213;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_04 : Int = 214;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_05 : Int = 215;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_06 : Int = 216;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_07 : Int = 217;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_08 : Int = 218;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_09 : Int = 219;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_10 : Int = 220;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_11 : Int = 221;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_12 : Int = 222;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_13 : Int = 223;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_14 : Int = 224;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_15 : Int = 225;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_16 : Int = 226;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_17 : Int = 227;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_18 : Int = 228;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_19 : Int = 229;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_20 : Int = 230;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_21 : Int = 231;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_22 : Int = 232;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_23 : Int = 233;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_24 : Int = 234;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_25 : Int = 235;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_26 : Int = 236;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_27 : Int = 237;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_28 : Int = 238;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_29 : Int = 239;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_30 : Int = 240;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_31 : Int = 241;
    public static inline var DUNGEON_RIVER_FLOOR_05_ROOM_32 : Int = 242;
    
    public static inline var DUNGEON_TWILIGHT_GROVE_1 : Int = 132;
    public static inline var DUNGEON_TWILIGHT_GROVE_2 : Int = 133;
    public static inline var DUNGEON_TWILIGHT_GROVE_3 : Int = 134;
    public static inline var DUNGEON_TWILIGHT_GROVE_4 : Int = 243;
    public static inline var DUNGEON_TWILIGHT_GROVE_5 : Int = 244;
    public static inline var DUNGEON_TWILIGHT_GROVE_6 : Int = 245;
    
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_01 : Int = 246;
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_02 : Int = 247;
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_03 : Int = 248;
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_04 : Int = 249;
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_05 : Int = 250;
    public static inline var DUNGEON_RIVER_FLOOR_06_ROOM_06 : Int = 251;
}
