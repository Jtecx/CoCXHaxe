/**
 * Created by aimozg on 08.01.14.
 */
package classes.scenes.nPCs;

import classes.*;
import classes.scenes.FollowerInteractions;
import classes.scenes.places.TelAdre;
import classes.scenes.SceneLib;

/**
	 * Contains handy references to scenes and methods
	 */
class NPCAwareContent extends BaseContent
{
    private var telAdre(get, never) : TelAdre;
    private var finter(get, never) : FollowerInteractions;
    private var amilyScene(get, never) : AmilyScene;
    private var kidAScene(get, never) : KidAScene;
    private var arianScene(get, never) : ArianScene;
    private var ayaneFollower(get, never) : AyaneFollower;
    private var celessScene(get, never) : CelessScene;
    private var ceraphScene(get, never) : CeraphScene;
    private var ceraphFollowerScene(get, never) : CeraphFollowerScene;
    private var emberScene(get, never) : EmberScene;
    public var etnaKidFollower(get, never) : EtnaDaughterScene;
    private var exgartuan(get, never) : Exgartuan;
    private var helScene(get, never) : HelScene;
    private var helFollower(get, never) : HelFollower;
    private var helSpawnScene(get, never) : HelSpawnScene;
    private var holliScene(get, never) : HolliScene;
    private var isabellaScene(get, never) : IsabellaScene;
    private var isabellaFollowerScene(get, never) : IsabellaFollowerScene;
    private var izmaScene(get, never) : IzmaScene;
    private var jojoScene(get, never) : JojoScene;
    private var joyScene(get, never) : JoyScene;
    private var monk(get, never) : Float;
    private var kihaFollower(get, never) : KihaFollower;
    private var kihaScene(get, never) : KihaScene;
    private var latexGirl(get, never) : LatexGirl;
    private var marbleScene(get, never) : MarbleScene;
    private var marblePurification(get, never) : MarblePurification;
    public var midokaScene(get, never) : MidokaScene;
    private var milkWaifu(get, never) : MilkWaifu;
    private var sheilaScene(get, never) : SheilaScene;
    private var shouldraFollower(get, never) : ShouldraFollower;
    private var shouldraScene(get, never) : ShouldraScene;
    private var sophieBimbo(get, never) : SophieBimbo;
    private var sophieScene(get, never) : SophieScene;
    private var sophieFollowerScene(get, never) : SophieFollowerScene;
    private var urta(get, never) : Urta;
    private var urtaPregs(get, never) : UrtaPregs;
    private var urtaHeatRut(get, never) : UrtaHeatRut;
    private var valeria(get, never) : ValeriaScene;
    private var vapula(get, never) : Vapula;

    public function new()
    {
        super();
    }
    // Common scenes
    private function get_telAdre() : TelAdre
    {
        return SceneLib.telAdre;
    }
    // Follower interactions
    private function get_finter() : FollowerInteractions
    {
        return SceneLib.followerInteractions;
    }
    
    // Amily
    private function get_amilyScene() : AmilyScene
    {
        return SceneLib.amilyScene;
    }
    
    public function amilyFollower() : Bool
    {
        return SceneLib.amilyScene.amilyFollower();
    }
    // Anemone
    private function get_kidAScene() : KidAScene
    {
        return SceneLib.kidAScene;
    }
    // Arian
    private function get_arianScene() : ArianScene
    {
        return SceneLib.arianScene;
    }
    public function arianFollower() : Bool
    {
        return SceneLib.arianScene.arianFollower();
    }
    // Ayayayane
    private function get_ayaneFollower() : AyaneFollower
    {
        return SceneLib.ayaneFollower;
    }
    // Celess
    private function get_celessScene() : CelessScene
    {
        return CelessScene.instance;
    }
    // Ceraph
    private function get_ceraphScene() : CeraphScene
    {
        return SceneLib.ceraphScene;
    }
    private function get_ceraphFollowerScene() : CeraphFollowerScene
    {
        return SceneLib.ceraphFollowerScene;
    }
    public function ceraphIsFollower() : Bool
    {
        return SceneLib.ceraphFollowerScene.ceraphIsFollower();
    }
    // Ember
    private function get_emberScene() : EmberScene
    {
        return SceneLib.emberScene;
    }
    public function followerEmber() : Bool
    {
        return SceneLib.emberScene.followerEmber();
    }
    public function emberMF(man : String, woman : String) : String
    {
        return SceneLib.emberScene.emberMF(man, woman);
    }
    public function etnaScene() : EtnaFollower
    {
        return SceneLib.etnaScene;
    }
    public function followerEtnaKid() : Bool
    {
        return SceneLib.etnaDaughterScene.etnaDaughterFollower();
    }
    private function get_etnaKidFollower() : EtnaDaughterScene
    {
        return SceneLib.etnaDaughterScene;
    }
    // Exgartuan
    private function get_exgartuan() : Exgartuan
    {
        return SceneLib.exgartuan;
    }
    // Helia
    private function get_helScene() : HelScene
    {
        return SceneLib.helScene;
    }
    private function get_helFollower() : HelFollower
    {
        return SceneLib.helFollower;
    }
    public function followerHel() : Bool
    {
        return SceneLib.helScene.followerHel();
    }
    // Helia spawn
    private function get_helSpawnScene() : HelSpawnScene
    {
        return SceneLib.helSpawnScene;
    }
    
    public function helPregnant() : Bool
    {
        return SceneLib.helSpawnScene.helPregnant();
    }
    public function helspawnFollower() : Bool
    {
        return SceneLib.helSpawnScene.helspawnFollower();
    }
    
    // Holli
    private function get_holliScene() : HolliScene
    {
        return SceneLib.holliScene;
    }
    // Isabella
    private function get_isabellaScene() : IsabellaScene
    {
        return SceneLib.isabellaScene;
    }
    private function get_isabellaFollowerScene() : IsabellaFollowerScene
    {
        return SceneLib.isabellaFollowerScene;
    }
    
    public function isabellaFollower() : Bool
    {
        return SceneLib.isabellaFollowerScene.isabellaFollower();
    }
    
    public function isabellaAccent() : Bool
    {
        return SceneLib.isabellaFollowerScene.isabellaAccent();
    }
    
    // Izma
    public function izmaFollower() : Bool
    {
        return SceneLib.izmaScene.izmaFollower();
    }
    private function get_izmaScene() : IzmaScene
    {
        return SceneLib.izmaScene;
    }
    // Jojo
    private function get_jojoScene() : JojoScene
    {
        return SceneLib.jojoScene;
    }
    private function get_joyScene() : JoyScene
    {
        return SceneLib.joyScene;
    }
    private function get_monk() : Float
    {
        return JojoScene.monk;
    }
    public function campCorruptJojo() : Bool
    {
        return SceneLib.jojoScene.campCorruptJojo();
    }
    // Kiha
    private function get_kihaFollower() : KihaFollower
    {
        return SceneLib.kihaFollower;
    }
    private function get_kihaScene() : KihaScene
    {
        return SceneLib.kihaScene;
    }
    
    public function followerKiha() : Bool
    {
        return SceneLib.kihaFollower.followerKiha();
    }
    
    // Latex Girl
    private function get_latexGirl() : LatexGirl
    {
        return SceneLib.latexGirl;
    }
    public function latexGooFollower() : Bool
    {
        return SceneLib.latexGirl.latexGooFollower();
    }
    // Marble
    private function get_marbleScene() : MarbleScene
    {
        return SceneLib.marbleScene;
    }
    private function get_marblePurification() : MarblePurification
    {
        return SceneLib.marblePurification;
    }
    public function marbleFollower() : Bool
    {
        return SceneLib.marbleScene.marbleFollower();
    }
    public function followerMidoka() : Bool
    {
        return SceneLib.midokaScene.midokaFollower();
    }
    private function get_midokaScene() : MidokaScene
    {
        return SceneLib.midokaScene;
    }
    // Milk slave
    public function milkSlave() : Bool
    {
        return SceneLib.milkWaifu.milkSlave();
    }
    private function get_milkWaifu() : MilkWaifu
    {
        return SceneLib.milkWaifu;
    }
    // Raphael
    private function raphael() : Raphael
    {
        return SceneLib.raphael;
    }
    public function RaphaelLikes() : Bool
    {
        return SceneLib.raphael.RaphaelLikes();
    }
    // Rathazul
    private function rathazul() : Rathazul
    {
        return SceneLib.rathazul;
    }
    // Sheila
    private function get_sheilaScene() : SheilaScene
    {
        return SceneLib.sheilaScene;
    }
    // Shouldra
    private function get_shouldraFollower() : ShouldraFollower
    {
        return SceneLib.shouldraFollower;
    }
    
    private function get_shouldraScene() : ShouldraScene
    {
        return SceneLib.shouldraScene;
    }
    
    public function followerShouldra() : Bool
    {
        return SceneLib.shouldraFollower.followerShouldra();
    }
    
    // Sophie
    private function get_sophieBimbo() : SophieBimbo
    {
        return SceneLib.sophieBimbo;
    }
    private function get_sophieScene() : SophieScene
    {
        return SceneLib.sophieScene;
    }
    
    private function get_sophieFollowerScene() : SophieFollowerScene
    {
        return SceneLib.sophieFollowerScene;
    }
    
    public function bimboSophie() : Bool
    {
        return SceneLib.sophieBimbo.bimboSophie();
    }
    
    public function sophieFollower() : Bool
    {
        return SceneLib.sophieFollowerScene.sophieFollower();
    }
    // Urta
    public function urtaLove(love : Float = 0) : Bool
    {
        return SceneLib.urta.urtaLove(love);
    }
    private function get_urta() : Urta
    {
        return SceneLib.urta;
    }
    private function get_urtaPregs() : UrtaPregs
    {
        return SceneLib.urtaPregs;
    }
    private function get_urtaHeatRut() : UrtaHeatRut
    {
        return SceneLib.urtaHeatRut;
    }
    // Valeria
    private function get_valeria() : ValeriaScene
    {
        return SceneLib.valeria;
    }
    // Vapula
    private function get_vapula() : Vapula
    {
        return SceneLib.vapula;
    }
    public function vapulaSlave() : Bool
    {
        return SceneLib.vapula.vapulaSlave();
    }
}
