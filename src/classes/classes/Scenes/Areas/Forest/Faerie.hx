package classes.scenes.areas.forest;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.scenes.SceneLib;
import classes.display.SpriteDb;

class Faerie extends BaseContent
{
    
    public function new()
    {
        super();
    }
    
    public function isEnabled() : Bool
    {
        return flags[kFLAGS.FAERIE_ENCOUNTER_DISABLED] <= 0;
    }
    
    //faerie Encounter
    public function encounterFaerie() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("A faerie slightly taller and thicker than your middle finger flits about the air. Her flat chest and girlish bob of hair make her look quite cute, but the solid black stockings and leather straps covering her chest show her slutty nature. Her wings are a light red, the color of aroused genitals.\n\n");
        if (player.cockTotal() > 0 && (!player.hasVagina() || rand(2) == 0))
        {
            outputText("She seems to notice you getting hard at the sight of her and looks down. \"<i>Ew, man parts!</i>\" the faerie exclaims, flying away like a frightened bird.");
            if (rand(player.spe / 2) + player.statusEffectv1(StatusEffects.FaerieFucked) > 15)
            {
                if (player.statusEffectv1(StatusEffects.FaerieFucked) < 5)
                {
                    outputText("\n\nYou make a desperate lunge for the faerie girl and grab her before she can fly away.   She wriggles and squirms in your grasp, shouting, \"<i>Let me go you meanie!</i>\"\n\n");
                    outputText("It would be cute if she wasn't dressed up like such a slut.  You bet you could get her to help pleasure you, but she might not like it.  Or you could be a nice " + player.mf("guy", "girl") + " and let her go...\n\nDo you force her to pleasure you?");
                }
                else if (player.statusEffectv1(StatusEffects.FaerieFucked) < 10)
                {
                    outputText("\n\nYou snatch her out of the air fairly easily.  She seems like she's slowed down a little.   She squirms and wriggles, begging you, \"<i>Please don't cover me in cum again... I get so drunk and feel even sluttier afterwards.  I don't want to be a slut!</i>\"\n\nShe pouts, but blushes.  Do you make her get you off again?");
                }
                else if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
                {
                    outputText("\n\nYou grasp the dizzy faerie out of the air with ease, smiling as you feel the flood of wetness between her thighs moistening your hand.  She wriggles and moans, \"<i>No, not again!  I want another cum-bath so bad... but I'm losing myself to it.  It's hard to keep flowers pollinated when you're jilling off half the day and waiting for a nice hard cock to wander your way...</i>\"\n\nShe wants to get you off almost as you do.  Do you make her service you again?");
                }
                else
                {
                    outputText("\n\nYou lazily make a grab for her and easily snatch her out of the air.  Her body is sticky with a mix of desire and cum from your last encounter.  You can feel her humping against your pinky while she begs, \"<i>Come on, let me crawl into your [armor] and wrap myself around your shaft.  I promise I'll only drink a little pre-cum this time, just enough to let me get off.  I'll be a good faerie slut, just let me get you off!</i>\"\n\nDo you let the faerie get you off?");
                }
                dynStats("lus", player.lib / 10 + 2, "scale", false);
                doYesNo(faerieCaptureHJ, letFaerieGo);
                if (player.statusEffectv1(StatusEffects.FaerieFucked) < 5)
                {
                    addButton(2, "Never", disableFaerieEncounterForGood);
                }
                return;
            }
            dynStats("lus", player.lib / 10 + 2, "scale", false);
            if (player.lust >= 90)
            {
                outputText("\n\nYou groan miserably with frustration. Desperate for stimulation, you sink to your knees and start jacking off, the faerie's visage still fresh in your mind. You catch a fleeting glimpse of yourself tightly gripping the faerie's legs in each of your fists, dragging her toward ");
                if (player.cockTotal() == 1)
                {
                    outputText("your dick");
                }
                else
                {
                    outputText("one of your dicks");
                }
                outputText(", too large for her tiny frame... the depraved image overwhelms your mind's eye, and you find yourself shooting all over the ground furiously.");
                player.orgasm();
            }
            else
            {
                outputText("\n\nYou try in vain to jump and catch her, but she's too high above you and much too fast.");
            }
            endEncounter();
            return;
        }
        outputText("The faerie slows the beating of her wings and hovers towards you. You dismiss your fearful notions, certain a small faerie is quite harmless to you.\n\n");
        outputText("How do you react?");
        //Shoo Away, Nothing, RAEP
        menu();
        addButton(0, "Shoo Away", faerieShooAway);
        addButton(1, "Nothing", faerieDoNothing);
        addButtonIfTrue(2, "Rape", faerieRAEP, "Req. a vagina", player.hasVagina());
    }
    
    private function faerieRAEP() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        //Count secksins
        if (!player.hasStatusEffect(StatusEffects.FaerieFemFuck))
        {
            player.createStatusEffect(StatusEffects.FaerieFemFuck, 1, 0, 0, 0);
        }
        else
        {
            player.addStatusValue(StatusEffects.FaerieFemFuck, 1, 1);
        }
        
        clearOutput();
        outputText("You let the tiny faerie buzz closer to investigate, then with an explosion of movement, snatch her out of the air.  She squirms in your palm, struggling futilely in your grasp.  You poke between her legs with a finger, noting the flushed redness of the faerie's skin.  ");
        //Changes based on times fucked
        if (player.statusEffectv1(StatusEffects.FaerieFemFuck) == 1)
        {
            outputText("She juices herself and screams, \"<i>Let me goooooooo,</i>\" trying to sound outraged instead of turned on, but the tiny girl's body gives away the lie.");
        }
        else if (player.statusEffectv1(StatusEffects.FaerieFemFuck) <= 5)
        {
            outputText("She juices herself and moans, \"<i>Stop teasing meeeeee,</i>\" doing her best to wriggle back against you, as if she could somehow impale herself on your digit.");
        }
        else
        {
            outputText("She squeals, rocking her hips back against you and moaning, \"<i>Ohhhh I love it when you do that,</i>\" grinding her incredibly small love-button on your digit.");
        }
        //Special Taurness
        if (player.isTaur())
        {
            outputText("\n\nYou bop the tiny Faerie on the head to daze her briefly, then place her on a branch. You back yourself up against the tiny creature, lifting your tail, so she can see your " + vaginaDescript(0) + ". The scent washes toward her, and you hear a high-pitched giggle; evidently that was more than enough to give her quite the contact high.  You feel a strange sensation in your slit as she slides her legs inside you and wraps her arms around your " + clitDescript() + ".\n\n");
            
            sceneHunter.print("Fork for clit sizes - 3\"");
            //[If cock-like clit:
            if (player.clitLength >= 3)
            {
                outputText("The tiny fae begins jerking your clit like a cock, squeezing her arms tightly around you and sliding in and out of your " + vaginaDescript(0) + ". Her motions are frenetic and unpredictable, but incredibly pleasurable.  She starts licking at your " + clitDescript() + " as your femcum runs down it, which only serves to make her more excited. She gets so excited that her legs start kicking wildly as she screams \"<i>Swim! Swim! Swim! Swim!</i>\" over and over again.  ");
                //[Small amount of cum:
                if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_WET)
                {
                    outputText("The fae giggles more and more as the fluid seeps about her and your " + vaginaDescript(0) + " ripples. She hugs your " + clitDescript() + " tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your clit, sprawling to the ground into a small puddle of femcum.\n\n");
                }
                //[Normal amount of cum:
                else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_DROOLING)
                {
                    outputText("The fae giggles more and more as the fluid squirts about her and your " + vaginaDescript(0) + " ripples. She hugs your " + clitDescript() + " tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your clit, sprawling to the ground into a puddle of femcum.\n\n");
                }
                //[Huge amount of cum:
                else
                {
                    outputText("The fae giggles more and more as the fluid sprays about her and your " + vaginaDescript(0) + " ripples. She hugs your " + clitDescript() + " tighter and starts gently gnawing at it, such a peculiar sensation that you cum suddenly, and wetly.  Her giggles quickly become all-out laughter, and she loses her grip on your clit, sprawling to the ground into a huge puddle of femcum, her giggling frame floating on the surface as her legs kick about erratically.\n\n");
                }
            }
            //[All other clits:
            else
            {
                outputText("The tiny fae rubs her hands around your " + clitDescript() + " as if entranced by it. Your body responds by pumping out more femcum, which she laps up happily.  She starts laughing maniacally and banging on your clit like a drum, periodically yelling out \"<i>CONGA!</i>\" for some reason. The strange ministrations feel incredible though, and you feel your love canal squeezing down on the faerie's tiny body.  ");
                //[Small amount of cum:
                if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_WET)
                {
                    outputText("You cum suddenly, and wetly. The fae giggles more and more as the fluid seeps about her and your " + vaginaDescript(0) + " ripples. Her giggles quickly become all-out laughter, and she loses her grip on your innards, sprawling to the ground into a small puddle of femcum.\n\n");
                }
                //[Normal amount of cum:
                else if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_DROOLING)
                {
                    outputText("You cum suddenly, and wetly. The fae giggles more and more as the fluid squirts around her and your " + vaginaDescript(0) + " ripples. Her giggles quickly become all-out laughter, and she loses her grip on your innards, sprawling to the ground into a puddle of femcum.\n\n");
                }
                //[Huge amount of cum:
                else
                {
                    outputText("You cum suddenly, and wetly. The fae tries desperately to hold on to your " + clitDescript() + " but the amount of fluid overwhelms her, and she's sent spiralling to the ground into a huge puddle of your fluid, her giggling frame floating on the surface as her legs kick about erratically.\n\n");
                }
            }
        }
        //Non-Taurs
        else
        {
            sceneHunter.print("Check failed: taur body");
            outputText("\n\nYou release the lower portion of your [armor], revealing your aroused slit to the faerie.  ");
            if (player.statusEffectv1(StatusEffects.FaerieFemFuck) < 4)
            {
                outputText("Her mood immediately shifts from panic to desire, and she licks her lips hungrily, locking her eyes onto your feminine folds.");
            }
            else
            {
                outputText("Her eyes open wide, like a junkie seeing a fix.  She licks her lips hungrily and humps the inside of your hand, ready for action.");
            }
            outputText("  You release the faerie, letting the pussy-entranced fae buzz down to your sensitive nether-regions.  She lands softly, her tiny feet and hands prancing over your vulva.  You gasp in delight, ");
            if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLAVERING)
            {
                outputText("releasing a tiny squirt");
            }
            else if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING)
            {
                outputText("dribbling juices");
            }
            else if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_WET)
            {
                outputText("growing so slippery the faerie nearly loses her footing");
            }
            else
            {
                outputText("feeling yourself moistening with need");
            }
            outputText(" from the tiny touches.\n\n");
            
            sceneHunter.print("Fork for clit sizes - 0.5\", 1.25\" and 4.5\"");
            //(small) <= .50\"
            if (player.clitLength <= .5)
            {
                outputText("She pulls apart your lips, revealing your tiny bud and repositioning herself to plant her feet inside you.  The flawless skin of her thighs pulls another gasp of pleasure from your lips.  They squeeze tightly around your " + clitDescript() + ", scissoring her gash across its sensitive surface.   You squirm, too engrossed in the rough grinding your button is receiving to worry about the faerie.   She clings to you, hanging on for dear life as your crotch nearly throws her free.  During the gyrations, she's slammed back into the " + clitDescript() + ", instantly penetrated by the nub with a wet 'schlick'.\n\n");
                outputText("Squealing and bouncing as she hangs on tightly, the faerie noisily orgasms around your clit, squirting her own fluids into your aching " + vaginaDescript(0) + ".  The fluid tingles, and you shove your fingers in, smearing the sticky-sweet faerie-cum through your passage.   Before you can get far with it, your own orgasm goes off, squeezing your fingers and rippling around them, trying to milk your hand as if it was a dick.  Your legs go weak and wobbly, forcing you down on your [butt] as the waves of pleasure flow through you, soaking the faerie in girlcum.\n\n");
            }
            //(medium) <= .1.25\"
            else if (player.clitLength <= 1.25)
            {
                outputText("She watches, entranced as your " + clitDescript() + " hardens, poking between your lips, flushed with blood like a tiny cock.   The faerie swivels around, planting her dainty butt squarely on your snatch, sinking down a bit into the folds as she wraps her legs around the pulsating 'shaft'.   She hugs it, pressing it between her tiny breasts and licking it up and down, making you moan and squirm from unexpected stimulation of your most sensitive area.\n\n");
                outputText("You spread your [legs], careful not to dislodge the faerie as she releases the " + clitDescript() + " and stands up, placing her dripping gash against the tip.   A quick plunge later, and she's bottomed out, pressing her hips into the opening of your " + vaginaDescript(0) + " her feet slipping over the outer folds as she tries to maintain her balance.   You start rocking back and forth happily, bouncing the faerie up and down.  She moans, cute and barely audible, but sexy in a way that makes your sopping fuckhole even wetter.\n\n");
                outputText("She orgasms on you, squirting copiously, drenching your " + clitDescript() + " and " + vaginaDescript(0) + " in clear faerie-fluid.  It tingles, wicking into your button and soaking into your snatch, enhancing every sensation.  You can feel the cool forest air as it flows over your vulva, seeming to stroke you, and without any chance of holding yourself back, you plunge your fingers into your " + vaginaDescript(0) + ", immediately orgasming from the penetration, not even noticing the exhausted faerie sliding off the large clit and slipping partway into your cunt.\n\n");
            }
            //(streeeetch – large) <= 4.5\"
            else if (player.clitLength <= 4.5)
            {
                outputText("Entranced by the growing " + clitDescript() + ", the faerie caresses her body, watching your love-button swell up, not stopping until it looks too huge for her tiny frame.  She climbs in a circle around it, awestruck by the size and majesty of your cock-like button.    She looks up at you, aroused but worried, saying, \"<i>You're so... BIG.  Oh goddess, I want to feel it inside me!</i>\"\n\n");
                outputText("She grabs hold of its slippery surface with both hands and jumps, lifting her lower body up before gravity yanks it back down onto the tip of your " + clitDescript() + ".  The tip barely slips in, despite the slippery wetness of the faerie.   She screams, though in pleasure or pain you cannot be sure.  You reason that it must be pleasure, because the faerie is wiggling her hips and grabbing hold of the rest of your " + clitDescript() + ", straining to pull herself further down the fem-cock.  Her belly starts to distort, displaying the cylindrical bulge on her tummy, expanding and contracting slightly as each of your heart-beats works through your clit.\n\n");
                outputText("In time, she manages to fully impale herself, quivering in orgasm as she gets off from the vibrations your pounding heart sends through your " + clitDescript() + ".  Her tongue lolls out, and her eyes roll back, shut down by the extreme penetration, pain, and pleasure of the act.  You feel her cum soaking into you, sliding down into your slit and making your sensitive slit tingle.  Watching her get off is all it takes to bring you to orgasm with her, and the walls of your " + vaginaDescript(0) + " clamp down hungrily, contracting and gushing fluids over the faerie as she lies there, impaled on your crotch like a perverted ornament.\n\n");
            }
            //(too big) (else – hump dat shit)
            else
            {
                outputText("Entranced by your swollen " + clitDescript() + ", the faerie watches it slowly erects, filling with blood like a smooth over-sensitive cock.  She tentatively touches it, gasping and pulling back when it twitches in response.   With a look of awe, she turns to you and says, \"<i>There's no way I could take this beautiful monster, but I know I can make it feel good!</i>\"\n\n");
                outputText("She jumps onto it, making it bounce in the air as it takes her relatively insubstantial weight.  Embracing it in a full-body hug, she starts grinding on it, smearing her thick faerie juices into the clit and giggling every time you twitch from the feeling.  You squirm, sinking down from the raw sensation, your [legs] giving out underneath you.   Grabbing hold of a stump, you try to steady yourself, but the faerie humping your " + clitDescript() + " is interfering with your motor ability, and you slump into the forest loam, happily twitching as orgasm washes over you.\n\n");
                outputText("Your " + clitDescript() + " jumps, throwing the tiny woman off.  She slips and scrabbles across the surface of your " + vaginaDescript(0) + ", sliding into your soaking gash.  She's squeezed tightly, sloshed around in the wetness of your orgasm.   The faerie's eyes cross, as she grows dizzy and battered in the sizzling whirlpool that is your groin.\n\n");
            }
        }
        //[OH SHIT ITS OVER, POOR BITCH CRAWLS OUT ALL STONE ON GIRLCUM]
        //[FIRST TIME]
        if (player.statusEffectv1(StatusEffects.FaerieFemFuck) == 1)
        {
            outputText("Lying in the forest loam as you recover, you watch as the faerie stumbles out of your groin, holding her head and giggling nonstop.  She tries to put on a serious face, but it's instantly overpowered by another fit of laughter, \"<i>Hehe, did you know I'd get stoned off your girlcum?  Omigod I've never been this -heheheheheh- high before!  Like I can see EVERYTHING.  Puuhleeeease don't make me do this again...</i>\"\n\n");
            outputText("She flies off, hungry and looking for a flower to munch on.");
        }
        //[REPEAT LOW]
        else if (player.statusEffectv1(StatusEffects.FaerieFemFuck) <= 5)
        {
            outputText("The faerie slowly drags herself out of your " + vaginaDescript(0) + ", smiling broadly with her eyes dilated wide.  She slips off you, dropping to the ground and giggling, \"<i>Everything feels so soft.  Mmmm that was fun!</i>\"\n\n");
            outputText("The little woman spins around happily, proclaiming, \"<i>The colors are like, so bright!  Oh gosh, I'm hungry!  See you and your clit later, just don't let me fall in your snatch, it fucks me up so much.  I don't think I can handle much more, or I'll be crawling between your legs every chance I get!</i>\"\n\n");
            outputText("She flits away, calling out, \"<i>Bye sweetie!</i>\"");
        }
        //[SLUTTIN IT UP]
        else
        {
            outputText("The faerie stumbles out of your snatch, giggling and scooping the slippery girl-goo off her body, licking it up.  She crawls up your body to your lips, giving you a cunt-flavored kiss and babbling happily, \"<i>Mmm your cunt makes me so warm and giggly!  I'm so fucking stoned!  Gawddess, I'm hungry too – I'm gonna grab some food, and then come back for another dip in your honeypot, ok?</i>\"\n\n");
            outputText("She flits away, a little unsteady and reeking of female sex and desire.");
        }
        player.orgasm();
        dynStats("lib", -2, "cor", .5);
        endEncounter();
    }
    
    private function faerieShooAway() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("You shake your hands, shooing away the tiny faerie.  She's clearly been touched by the magics of this land, and you want nothing to do with her. With a pouting look, she turns and buzzes away.");
        endEncounter();
    }
    
    private function faerieDoNothing() : Void
    {
        var nippleOK : Bool = player.nippleLength >= 1 && player.nippleLength <= 4.5;
        var clitOK : Bool = player.hasVagina() && player.clitLength >= 1.0 && player.clitLength <= 4.5;
        var nippleSmall : Bool = player.nippleLength < 1;
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        if (nippleOK && (!clitOK || rand(2) == 0))
        {
            outputText("She looks you over, stopping at your upper torso and letting out a cry of glee. She lands on your chest, her exposed pussy coming to rest on your nipple. With one hand she grabs hold of you above her head and uses her other hand to guide the rapidly hardening nub between her legs. She sighs in delight as her tight confines squeeze your nipple hard, the feeling somewhere between pinching fingers and suckling lips. You gasp in delight yourself, and you notice she can exercise amazing control with her groin muscles as a rippling feeling courses through your nipple.\n\n");
            outputText("Your nipple starts to get sloppy and wet as if someone's tongue were around it, but it's really the faerie's love juices dribbling down, some running down your breast, and some down her legs. She starts thrusting against you, and you notice her clit getting hard and pushing into your soft flesh. With a free hand you grab the area around your nipple and squeeze it harder, forcing more into her.\n\n");
            if (player.biggestLactation() > 1)
            {
                outputText("A squirt of milk shoots inside her, making the faerie moan. She looks up at you with lusty, slitted eyes, squeezing her legs together to draw more from you.\n\n");
            }
            outputText("Eventually you both find a rhythm, and soon she's moaning loudly.  ");
            if (player.hasVagina())
            {
                outputText("With your other hand you start diddling your " + vaginaDescript(0) + ", adding your own soft moans to hers.  ");
            }
            outputText("A few blissful moments later, she shudders, and you feel her uncontrolled spasms around your nipple.  ");
            if (player.hasVagina())
            {
                outputText("You join her shortly after.  ");
            }
            outputText("The faerie goes limp and spirals to the ground, crashing gently and still twitching in the afterglow. Stepping back carefully, you leave her.");
            if (player.biggestLactation() > 1.5)
            {
                outputText("\n\nA copious gout of your milk escapes her rosy folds.");
            }
            player.orgasm();
            dynStats("lib", -2);
            endEncounter();
        }
        else if (clitOK)
        {
            outputText("A smile crosses her face, and she flutters down to your crotch. She starts by scissoring you despite the size difference, driving your clit into her despite its erect state. Compared to her, it looks massive. She swings one leg over it and starts impaling herself on it. Your taut clitoris barely fits inside her, and the tight confines on your sensitive nub are enough to make you weak in the knees. Staggering to the ground, you grab hold of her frail body in your fist and thrust her roughly on your engorged button. She wails in both pain and pleasure, being crushed and stretched open at once. Her cries of pain combined with the intense stimulation on your most sensitive part bring you to a quick orgasm.\n\n");
            if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING)
            {
                outputText("You drench the poor faerie completely in your female juices, soaking her hair and body. Overwhelmed and spent, you drop her to the ground and catch your breath. She licks up what's around her face, but is too weak to do anything else but lie in the dirt.\n\n");
            }
            else
            {
                outputText("Shuddering, you maintain your composure and keep going, trying to ride the high for another. Eventually you look down, and you can see the faerie's eyes have glazed over and rolled to the back of her head. Her cunt has started clamping down on you a lot harder, evidence of her state of near-constant orgasm. The random clenching brings you off again very quickly, and you have an intense orgasm, joining your fae cohort.\n\n");
            }
            outputText("Time skips a beat, and you eventually come down, gently relaxing your grip and disengaging the worn out faerie from your softening female parts. The faerie regains consciousness slowly and thanks you before flying off.");
            player.orgasm();
            dynStats("lib", -1);
            endEncounter();
        }
        else if (nippleSmall)
        {
            outputText("The faerie flies close to your nipple and sucks it gingerly.  You pant in pleasure as you feel it pucker tight in her mouth, tingling with her saliva.  She lets it pop free, swollen with arousal.  Her hand flicks it playfully, the sudden sensation fluttering through you as you close your eyes in pleasure.  You recover and find she has flown high into the trees, waving playfully as she escapes.\n\nYou frown and begin to dress yourself, flushing irritably as your nipples protrude further into your clothes than you remember.");
            player.nippleLength += .25;
            if (player.nippleLength > 3 || player.biggestTitSize() <= 2)
            {
                outputText("  Thankfully it appears to be temporary.");
                player.nippleLength -= .25;
            }
            dynStats("sen", 1, "lus", 5);
            endEncounter();
        }
        else
        {
            outputText("The faerie flies close to your ear and speaks in a volume that would be a whisper from another human, \"You've got some sexy parts girl, but you're too big for me. I hope you find someone to get you off, so I can watch.\" Then she flies in front of you, cutely kisses the bridge of your nose, and flies off.");
            dynStats("lus", 5, "scale", false);
            endEncounter();
        }
    }
    
    //[No] *(let her go)
    private function letFaerieGo() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("You apologize and release her, letting her fly away on gossamer wings.  She thanks you, buzzing up to your lips and planting a chaste kiss on your mouth.  She zips away into the woods without a glance back...");
        endEncounter();
    }
    //Disable Faerie encounter
    private function disableFaerieEncounterForGood() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("You apologize and release her, letting her fly away on gossamer wings.  She thanks you, buzzing up to your lips and planting a chaste kiss on your mouth.  She zips away into the woods without a glance back...");
        outputText("\n\nYou make a mental note and resolve to never catch her again.");
        flags[kFLAGS.FAERIE_ENCOUNTER_DISABLED] = 1;
        endEncounter();
    }
    
    //[YES] *make her pleasure you
    private function faerieCaptureHJ() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        if (player.hasStatusEffect(StatusEffects.FaerieFucked))
        {
            player.addStatusValue(StatusEffects.FaerieFucked, 1, 2);
        }
        else
        {
            player.createStatusEffect(StatusEffects.FaerieFucked, 2, 0, 0, 0);
        }
        clearOutput();
        if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
        {
            outputText("You hold her tightly and scold her, \"<i>If you don't like hard cocks, you shouldn't be dressed up like a such a slut, flying around and teasing me like that.  You should be ashamed of yourself.  Now you've got me all worked up - so you better make it up to me and take care of my little 'problem'</i>.\"\n\n");
            outputText("She looks up at you and gulps before nodding silently, unwilling or unable to resist your command.   ");
        }
        outputText("You let her loose, and she hovers in place, as if pondering her one last chance to escape.  She sighs and looks back up, blushing fiercely as she lands on your hip and gazes down at " + player.clothedOrNakedLower("the bulge of ") + "your groin.  You can't help but laugh as she " + player.clothedOrNakedLower("slips under your " + player.armorName, "climbs onto you") + ", crawling across your sensitive thigh towards your [cocks].\n\n");
        //Taurs get a special scene!
        if (player.isTaur())
        {
            outputText("The tiny Faerie climbs on top of your " + cockDescript(0));
            if (player.cockTotal() > 0)
            {
                outputText("largest " + Appearance.cockNoun(CockTypesEnum.HUMAN));
            }
            outputText(" and crawls about on it for a while, getting used to its shape and taking in deep lungfuls of its musky odor. She wraps herself around you and begins rubbing herself up and down your hard length. As she moves around her tiny slit leaks cum in long streaks, teasing you with a cunt you can't penetrate. Pre begins to leak steadily from your tip as the faerie continues to work her way around, moaning quietly and betraying her inner desire.\n\n");
            outputText("Your body begins to naturally jerk forward and backward, attempting to hump the mare that isn't there. You can feel the faerie sliding about until she clenches onto you tighter, which only serves to make you hump harder. Realizing her mistake too late, she attempts to loosen herself, but your wild bucking sends her flying forward.\n\n");
            outputText("She smashes onto the end of your [cocks] and grasps at it. Her face crushes into your urethra as her tiny legs wrap themselves around the tip. Your wildly flailing cock starts to grow larger as your orgasm approaches, but the faerie doesn't notice as she happily drinks up your pre.\n\n");
            //[No testicles:
            if (player.balls == 0)
            {
                outputText("Your tiny globules of semen go straight into her open mouth, and she sucks them down gleefully before falling with a splat onto the pre-soaked ground.\n\n");
            }
            //[Small amount of cum:
            else
            {
                
                if (player.cumQ() < 50)
                {
                    outputText("Your semen splashes straight into her face, and she's quick to suck it up. She falls with a splat onto the pre-soaked ground while your member drips periodic droplets of cum onto her head.\n\n");
                }
                //[Normal amount of cum:
                else if (player.cumQ() < 200)
                {
                    outputText("Your semen washes into her face, and she loses her grip on your [cocks]. She falls with a splat onto the pre-soaked ground, and you spray her with periodic spurts of fresh cum.\n\n");
                }
                //[Huge amount of cum:
                else
                {
                    outputText("Your semen collides with her face, and she is propelled off of your cock onto the pre-soaked ground. Your [balls] continue pumping out cum like a hose until she's almost swimming in it.\n\n");
                }
            }
            player.sexReward("no", "Dick");
            dynStats("lib", -.5);
            //Epilogue!
            if (player.statusEffectv1(StatusEffects.FaerieFucked) < 10)
            {
                outputText("The faerie burps and giggles again before glaring up at you, accusing you with a mildly unfocused glare and asking, \"<i>Did you know we get drunk on cum?  Caushe I TRY SO HARRD not to get meshed up like this.</i>\"\n\n");
            }
            else if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
            {
                outputText("The faerie burps and laughs drunkenly, patting the side of your [leg] and slurring, \"<i>Oh by Marae's ripe titsh!  I needed that.  Do you thhink you could catsch me again?  I love feeling your cum coating my body.</i>\"\n\n");
            }
            else
            {
                outputText("The faerie burps and begins openly masturbating, panting and slurring happily, \"<i>Yush I-gasp-uh feel great!  MMMmmmhm, it makesh my twat so sensitive.  I'm gonna fly home and schtuff it full, then play with my clit till I fall ashleep!</i>\"\n\n");
            }
            if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
            {
                outputText("She licks her fingers and rolls around laughing, \"<i>Hehe, who caresh!  I'm happy! WHEEEEE!</i>\"\n\n");
            }
            outputText("The faerie takes off, still dripping, and flying in something less than a straight line...");
        }
        //Non-taurs
        else
        {
            sceneHunter.print("Check failed: Taur body.");
            outputText("The faerie reaches your swollen member and ");
            if (player.cocks[0].cockType == CockTypesEnum.HORSE)
            {
                outputText("climbs atop your [cock], hanging onto your ring of prepuce and wrapping her legs as far around your horse-like maleness as she can.  ");
            }
            else if (player.cocks[0].cockType == CockTypesEnum.DEMON)
            {
                outputText("climbs atop your [cock], hanging on to the corrupted nubs and nodules as she threads her legs between them, squeezing you tightly as she hangs on.  You can feel her wet gash sitting atop a particularly sensitive bump, teasing you with a tiny cunt you'll never be able to penetrate.  ");
            }
            else if (player.cocks[0].cockType == CockTypesEnum.TENTACLE)
            {
                outputText("climbs onto your squirming [cock], wrapping her legs tightly around it as it wiggles and writhes with excitement.  Unbidden, it curls around and rubs its reddish-purple head against her face like an animal.  She gives it a gentle squeeze and licks it.  ");
            }
            else if (player.hasKnot(0))
            {
                outputText("climbs atop your knot, wrapping her legs around the narrower shaft to hold on.  You can feel her cheeks resting atop the 'bulb' of your canine anatomy, teasing you with feminine features you're far too large to penetrate.  ");
            }
            else
            {
                outputText("climbs on to your hardness, wrapping her legs tightly around it as she secures a perch against you.   You can feel her wet gash rubbing against your sensitive skin, teasing you with a tiny cunt you'll never be able to penetrate.  ");
            }
            outputText("Your internal muscles clench unconsciously, squeezing out a dollop of pre that rolls down into the faerie's hair, soaking her head and face.  You can't see her reaction, but you can feel it oozing between her body and you, lubricating her as she humps and rubs against you.  Tiny muffled moans escape " + player.clothedOrNakedLower("your [armor]", "her mouth") + ", indicating that some part of her is enjoying the task.\n\n");
            outputText("Though she can only stimulate a few inches of you at a time, it feels really good – better than it should, and a budding warmth on the edge of release builds inside you.  " + player.clothedOrNakedLower("Too late you realize you should have gotten at least partially undressed.  You cum before you can do anything about it, splattering your [armor] with seed and leaving a wet patch on the crotch.  You can feel it dripping back onto you, and the faerie as more spunk squirts out, soaking the tiny girl in spooge as the wet spot grows", "Good thing your junk is exposed as otherwise you would have ended up jizzing in your pants. You cum, splattering the faerie with seed. This continues until the tiny girl is soaked in spooge") + ".  ");
            if (player.cumQ() > 250)
            {
                outputText("You cum uncontrollably, " + player.clothedOrNakedLower("regretting your fertility as your body paints the inside of your [armor] with goopy whiteness.", "painting the ground with goopy whiteness.") + "  ");
                if (player.cumQ() > 500)
                {
                    outputText("The proof of your release forms a puddle around you as your legs give out and y");
                }
                else
                {
                    outputText("Falling backwards as your legs give out, y");
                }
            }
            else
            {
                outputText("Y");
            }
            outputText("ou watch your wet groin squirm as the faerie finishes releasing your built-up tension and crawls out.  She's covered from head to toe in sloppy white jism, and is noisily slurping it up.\n\n");
            outputText("She rolls off of you, staggers, and plops down on her cute little ass next to you");
            if (player.cumQ() > 500)
            {
                outputText(" in the cum");
            }
            outputText(", giggling drunkenly.  ");
            if (player.statusEffectv1(StatusEffects.FaerieFucked) < 10)
            {
                outputText("The faerie burps and giggles again before glaring up at you, accusing you with a mildly unfocused glare and asking, \"<i>Did you know we get drunk on cum?  Caushe I TRY SO HARRD not to get meshed up like this.</i>\"\n\n");
            }
            else if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
            {
                outputText("The faerie burps and laughs drunkenly, patting the side of your [leg] and slurring, \"<i>Oh by Marae's ripe titsh!  I needed that.  Do you thhink you could catsch me again?  I love feeling your cum coating my body.</i>\"\n\n");
            }
            else
            {
                outputText("The faerie burps and begins openly masturbating, panting and slurring happily, \"<i>Yush I-gasp-uh feel great!  MMMmmmhm, it makesh my twat so sensitive.  I'm gonna fly home and schtuff it full, then play with my clit till I fall ashleep!</i>\"\n\n");
            }
            if (player.statusEffectv1(StatusEffects.FaerieFucked) < 15)
            {
                outputText("She licks her fingers and rolls around laughing, \"<i>Hehe, who caresh!  I'm happy! WHEEEEE!</i>\"\n\n");
            }
            outputText("The faerie takes off, still dripping, and flying in something less than a straight line...");
            player.sexReward("no", "Dick");
            dynStats("lib", -.5);
            if (!player.hasStatusEffect(StatusEffects.Jizzpants) && player.armor.name != "nothing" && player.armor != armors.LTHCARM && player.armor != armors.GOOARMR)
            {
                player.createStatusEffect(StatusEffects.Jizzpants, 1, 0, 0, 0);
            }
            if (player.armor == armors.GOOARMR)
            {
                outputText("\n\nFortunately, your jizz gets absorbed into the blue goo covering your body.");
                SceneLib.valeria.feedValeria(player.cumQ() / 10);
            }
        }
        endEncounter();
    }
    public function encounterFaerieDragon() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        if (player.isFemale())
        {
            outputText("A faerie slightly taller and thicker than your middle finger flits about the air. Her flat chest and girlish bob of hair makes her look quite cute, but the solid black stockings and leather straps covering her chest show her slutty nature. Her wings are a light red, the color of aroused genitals.\n\n");
            outputText("The faerie slows the beating of her wings and hovers towards you. You dismiss your fearful notions, certain a small faerie is quite harmless to you.\n\n");
            outputText("How do you react?\n\n");
            menu();
            addButton(0, "Fairy Tales", encounterFaerieDragonStory);
        }
        else
        {
            outputText("Your heart skips a beat as the little fairy draws near, seemingly as curious about you as you are her. You hold out a hand, and the tiny slut lands in your palm, tiny wings flapping nervously. Slowly, ever so slowly, you sit on the ground, your scales itching slightly. You keep your wings folded behind your back, slightly embarrassed about them. You stare at the tiny woman’s butterfly wings, how they shimmer in the light.\n\n");
            outputText("\"<i>You like ‘em too, huh?</i>\" She flaps her wings gently. \"<i>Can’t say I blame you.</i>\" She sits down, legs crossed. You nod, asking her if she’s a princess among her people. She laughs, asking you why, and you grin, remarking that if legends in your homeland were true, that you’d be kidnapping her if that were the case.\n\n");
            outputText("The little one laughs at that. \"<i>Yeah, otherworlders are a superstitious lot. Makes them that much more fun to mess with!</i>\" She begins to talk about a few foxes that come by her neck of the woods, and the pranks she pulls on them in response. She proves to be quite the chatterbox, and before you know it, you spend an hour or so talking with the odd little fae.\n\n");
            outputText("Eventually, she sits down, cross-legged, in your palm, nuzzling one of your fingers with her cheek. \"<i>I missed this, y’know. Most of my people don’t like you giant-folk…But I used to talk with a few, before they got all fuck-crazy.</i>\" She gives you a smile. \"<i>I noticed that you’ve been hiding your own wings. Why? You embarrassed about ‘em or something?</i>\"\n\n");
            outputText("You admit that your dragon wings are useful, but that you’d prefer it if they were… a little more pretty.\n\n");
            outputText("\"<i>Well…Normally I’d just say tough luck and leave it at that…But you seem different than most of the…shall we say, ‘men’ around here.</i>\" She smiles. \"<i>If you want, I could help you with that. Give you wings that match mine.</i>\"\n\n");
            encounterFaerieDragonStory2();
        }
    }
    private function encounterFaerieDragonStory() : Void
    {
        outputText("You feel strange as your body seems to react to the fairy’s presence. You can’t help but be jealous of the faerie’s carefree nature and beautiful butterfly wings, meanwhile you’re a big scaly lizard that might as well be kidnapping fairy tale princesses. The faerie seems to have noticed your envious stare.\n\n");
        outputText("\"<i>Oh, you got something special about you, girl! If you let me, I could make you cute and nice just like us faeries. Would you like that?</i>\"\n\n");
        outputText("How does she intend to do that anyway? It's not like you will suddenly shrink to pintsize.\n\n");
        outputText("\"<i>Just you watch. I got just the thing. Here, sniff that!</i>\"\n\n");
        encounterFaerieDragonStory2();
    }
    private function encounterFaerieDragonStory2() : Void
    {
        outputText("A small flower not unlike a pinkish tulip grows at your feet out of nowhere. Well, if the fairy’s words are true, this small item will change you. Do you eat it?\n\n");
        menu();
        addButton(1, "No", encounterFaerieDragonStoryNo);
        addButton(3, "Yes", encounterFaerieDragonStoryYes);
    }
    private function encounterFaerieDragonStoryNo() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("You excuse yourself, saying that you like yourself the way you are. Then you turn back, making your way back to camp.\n\n");
        endEncounter();
    }
    private function encounterFaerieDragonStoryYes() : Void
    {
        spriteSelect(SpriteDb.s_faerie);
        clearOutput();
        outputText("You smell the flower. Its scent is nice and soothing, like that of lavender. You feel euphoria reach toward your mind for unknown reason and giggle as your body begins to change.\n\n");
        outputText("Your scale’s color slowly shifts towards a cheerful pinkish purple, similar to morning glory, while your hair color changes towards pink. The greatest change comes when your wings begin to shrivel up, rapturous ecstasy flowing through your appendages.. You feel lighter and lighter, shrinking a little in size as your wings turns into those of a butterfly. You flap them, hovering above the ground for a few second and smile wide, giddy from the flight. The faerie was telling the truth, and now you’re a Faerie dragon! You happily thank her for gifting you with this form.\n\n");
        outputText("\"<i>All fine by me. See you around!</i>\"\n\n");
        outputText("The faerie flutters off as you head back to camp with a whole new pinkish outlook on your life.\n\n");
        player.hairColor = "pink";
        player.scaleColor1 = "pinkish purple";
        transformations.WingsFeyDragon.applyEffect(false);
        transformations.TailFeyDraconic.applyEffect(false);
        transformations.ArmsFeyDraconic.applyEffect(false);
        transformations.LowerBodyFeyDraconic(player.legCount).applyEffect(false);
        if (!player.hasPerk(PerkLib.DragonFaerieBreath))
        {
            player.createPerk(PerkLib.DragonFaerieBreath, 0, 0, 0, 0);
        }
        endEncounter();
    }
}

