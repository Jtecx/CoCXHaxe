//Minerva Corruption (Warped by Lies)
package classes.scenes.areas.highMountains;

import classes.*;
import classes.globalFlags.KFLAGS;
import classes.iMutations.IMutationsLib;
import classes.scenes.SceneLib;

class MinervaCorruption extends BaseContent
{
    public var minervaScene(get, never) : MinervaScene;
    public var kidsCount(get, never) : Int;

    /*
    TODO:
    Hey. Turned out Minerva's corruption route is nice, but not really finished. Of course, I can try to do a shitty editing myself, but I doubt my writing skills. Here's a general map of what should happen.
    In general, after corruption Minerva should not let you inside her pussy. Only after fighting, you're allowed to fuck her properly. Though the information is lacking (I'm basically restoring it from code fragments and comments).
    The existing scenes are too good to just drop, but doing it properly would need some serious writing help if anyone's up for it.
    Some of this can be adapted from existing (Minerva or Pure Minerva) scenes, probably.
    https://media.discordapp.net/attachments/979691280328167515/980736062576001054/unknown.png
    Basically, what is present and finished:
    1. Starting corruption scenes.
    2. New anal and addicted-blowjob scenes.
    3. Harpy bad-end.
    4. Naga scenes.
    5. Win and lose scenes for fight (both genders)
    6. Talks and children scenes.

    What is lacking:
    1. There is cum-addiction mechanic, stacking when she dominates you. There is an extra BJ scene just for it. But:
    - Other scenes almost don't mention it. Perhaps add a few mentions to BJ-including scenes?
    - After 5 stacks, a bad end is supposed to happen. Never written.
    2. Seems like old scenes still should be accessible. Though she has two cocks and is much more aggressive, so they would need some adaptation. And also she shouldn't let you inside the pussy, so how is it supposed to work..
    3. There are NO birthing scenes yet, neither for Minerva nor you.
    4. There are some mentions of turning her into a sub using lethicite. Though there is almost nothing but the initial dialogue. I'd suggest just cutting out the mentions of lethicite, but if anyone's ready to adapt the scenes for this too...
    5. No pre-fighting dialogue, though it shouldn't be that hard.
    6. Corrupted peach - new item?
    7. Initial bathing may be a bit lewder than just a link to the Minerva bath.
    */
    
    private function get_minervaScene() : MinervaScene
    {
        return SceneLib.mountain.minervaScene;
    }
    
    /*
Corrupted Minerva at first glance looks like some demonic looking being, her skin is Ultraviolet with a deep red belly, inner thighs, neck as well as her stripes. Minerva’s eyes change from electric blue to a dark blood red  her sclera grow even darker, turing into two black pits accentuating the new color of her eyes.

Her hair and feathers also change, her feathers turning pure black with her wrings growing larger. Minerva’s red hair gaining black streaks in it

Other changes to her body after corruption are that her breasts grow to large E-cup size and
between her legs she retains her tentacle endowed penis, though growing larger and a second equally large cock grows, they look more natural as if it was meant to be part of her body. her Twin balls change as well, growing to the size of soccer balls marking her with corrupted and very potent fertility. Similarly to her legs, her tongue keeps its demonic nature, a twisting, 2ft long prehensile appendage.

Corrupted Minerva Notes
Won’t voluntarily birth kids; PC must beat her to impregnate her

[Upon purifying Minerva she will give the pc her silver lance]

Silver lance: a bladed lance with a long ornate pole, the blade is made of a whitish silver that has been purified by quenching the blades metal in the pure springs waters imparting a power to harm corruption. +10 attack. +1.5 attack for every 10 enemy corruption. example. if enemy has a corruption score of 30 the lance gives a +4.5 attack on top of its base +10 for 14.5 this gives it only a fair sized boost for most repeatable enemies. on very corrupt enemies like powerful demons it would give a boost that could tip a hard battle more in the pc’s favor


Offspring notes.

only corrupt siren daughters that the PC themselves father or birth stay at the tower and count toward the number of siren daughters

     */
    
    private function minervaRomanced() : Bool
    {
        return minervaScene.minervaRomanced();
    }
    
    //Total counter, including harpy children
    private function get_kidsCount() : Int
    {
        return flags[kFLAGS.MINERVA_CHILDREN];
    }
    
    public function cumAddiction(change : Int = 0) : Int
    {
        if (flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] < -change)
        {
            flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] = 0;
        }
        else
        {
            flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] += change;
        }
        return flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION];
    }
    
    public function introToCorruptMinerva() : Void
    {
        clearOutput();
        if (minervaRomanced())
        
        //Minerva is your love!{
            
            outputText("You grin and approach Minerva with devilish intent. The tall redhead blushes and smiles at the sight of you, clearly very happy to see you after the romantic encounter you had earlier. As soon as she notices your grin, she giggles and give you a sly look, believing she knows of your intentions. “<i>Well, well, well, someone is perky today; happy to see your beloved siren?</i>“ she asks playfully, clearly having no idea what you have planned.");
            outputText("\n\nAs if to answer her you slide an arm around her waist, grab a handful of her curvy rear and pull her close to you, giving her a squeeze, eliciting a squeak from her and causing her blush to deepen. You spin the most flattering comments you can devise, your words working their magic on the shark harpy. She smiles and giggles to you, before pulling you into a hug and kissing you deeply, her tantalisingly long tongue sliding into your mouth and around your own.");
            outputText("\n\nAfter a steamy, tongue-tangling make out session you pull back to see her happy blushing expression. ");
            if (player.cor < 60)
            {
                outputText("A small part of you feels bad for what you're going to do and that it’s cruel to use her feelings for you like this and trick her into taking some potion. But you came here with the potion in hand for a reason and it’s too late to stop now.");
            }
            else if (player.cor < 80)
            {
                outputText("A small voice, almost like a whisper in the back of your mind, tells you this is wrong and you shouldn’t take advantage of Minerva’s feelings for you like this... But you came here with the potion in hand for a reason and it’s too late to stop now.");
            }
            else
            {
                outputText("You know it’s wrong to trick such a sweet woman that loves you like this, but, fortunately for you, your corrupted mind giggles at the thought of how horny and fun she will be after getting a dose of this potion.");
            }
            outputText(" You reach into your pack and pull out a red bubbling vial and show it to your companion. In a preemptive act of cunning you have scratched off its label to hide its intentions.");
            outputText("\n\nMinerva looks at it curiously and with a bit of nervousness. “<i>What’s that, love? Is that one of your spoils from battles with the beasts of the land?</i>“ she asks you, clearly wondering why you would show her something like that. You shake your head and tell her it’s something you had cooked up by an alchemist you know, something that would make your already passionate lovemaking even more amazing and that she told you the two of you could add it to the pure spring and take a bath in the new mixture. You assure her that it's safe and won't cause any harm to the spring.");
            if (player.inte < 50)
            {
                usePotionFail();
            }
            else
            {
                usePotionSuccess(true);
            }
        }
        //Or not? Just friends...
        else
        {
            
            outputText("Smirking, you approach Minerva, who smiles at you softly and looks between you and the floor. Clearly she still has feelings for you despite your rejection, something that will greatly aid you in what you want to do with her. You look the tall, enamored siren up and down before looking at her seriously. You tell the siren that you want to talk about your previous discussion, but the mere mention of that awkward conversation causes the tall redhead to become embarrassed and given how things went you can't blame her.");
            outputText("\n\n“<i>Hey, no, it’s alright...I mean. I thought we had something special, but it’s alright; I’ll be fine. I’ve been alone for a long time, so I’m used to it.... I’m very glad you came back though, that you still want to visit me here</i>“ she says, not quite making eye contact. It’s easy to see she is still sore from before and is just trying to hide it so you won’t feel bad.");
            outputText("\n\nShaking your head, you decide to push forward with your plan for the shark-like harpy. You hold up your hand to stop her from talking. You tell her that you’ve been thinking about the idea, and you want to see if maybe you can work as a couple after all, trying to be as convincing as possible so she will fall for it.");
            outputText("\n\nAs if to answer her, you slide an arm around her waist and, grabbing a handful of her curvy rear, you pull her close to you and give her a squeeze, eliciting a squeak from her and causing her blush to deepen. As you hold onto her, you promise her that you really do want to try and be a couple, your words working their magic on the lonely shark-harpy. She smiles and giggles to you, before pulling you into a hug and kissing you deeply, her long demonic tongue sliding into your mouth and around your own.");
            outputText("\n\nAfter a steamy, tongue-tangling make out session you pull back to see her happy blushing expression. ");
            if (player.cor < 60)
            {
                outputText("A small part of you feels bad for what you're going to do and that it’s cruel to use her feelings for you to trick her into taking some potion. But you came here with the potion in hand for a reason and it’s too late to stop now.");
            }
            else if (player.cor < 80)
            {
                outputText("A small voice, almost like a whisper in the back of your mind, tells you this is wrong and you shouldn’t take advantage of Minerva’s feelings for you like this... But you came here with the potion in hand for a reason and it’s too late to stop now.");
            }
            else
            {
                outputText("You know it’s wrong to trick such a sweet woman that loves you like this, but, fortunately for you, your corrupted mind giggles at the thought of how horny and fun she will be after getting a dose of this potion.");
            }
            outputText(" You reach into your pack and pull out a red bubbling vial and show it to your companion. In a preemptive act of cunning you have scratched off its label to hide its intentions.");
            outputText("\n\nYou don't have to wait long before a bright smile breaks out across her face, her sharp shark-like teeth showing in all their jaggedness. As soon as you finish speaking she grabs you and hugs you tightly, almost like she is trying to squeeze the life from you with her grip. She really does care for you. (And here you are lying to her...you dick) “<i>Oh, [name], that's... that’s amazing. I’m so glad. I promise I’ll do everything I can to make you happy, it’s the least I can do for you after how nice you have been. Visiting me all the way up here, taking time out of your quest to talk to me and make me feel companionship for the first time in so long.</i>“ she says honestly as she hugs you tightly.");
            outputText("\n\nNow that she believes you, it's time to go through with your plan. Reaching behind yourself, you delve into your back and pull out a vial filled with a rolling red liquid. You hold the fuckdraft in your hands and show it to Minerva. Thankfully, you had the forethought to scratch off the label so she wouldn't know what was inside.");
            outputText("\n\nMinerva looks at it curiously and with a bit of nervousness. “<i>What’s that, love? Is that one of your spoils from battles with the beasts of the land?</i>“ she asks you, clearly wondering why you would show her something like that. You shake your head and tell her it’s something you had cooked up by an alchemist you know, something that would make your already passionate lovemaking even more amazing, that she told you the two of you could add it to the pure spring and take a bath in the new mixture. You assure her that it's safe and won't cause any harm to the spring.");
            if (player.inte < 50)
            {
                usePotionFail();
            }
            else
            {
                usePotionSuccess(false);
            }
        }
    }
    
    /**
     * Convince Minerva to use the potion. Text based on lover status.
     * @param    isLover is Minerva already the players lover?
     */
    private function usePotionSuccess(isLover : Bool) : Void
    {
        outputText("\n\nYour explanation of the situation as well as the pros of using the vial’s contents seems to work. Making sure to calm the worried siren by telling her that you worked with an expert alchemist on this to ensure it would be safe for you doesn’t hurt either. As you intelligently speak about the delights of using the vial, Minerva’s face brightens more and more until she is grinning widely and her eyes are shining brightly like precious gems. Without waiting, Minerva grabs the vial and looks it over. “<i>It will make things even better, huh? Well, what are we waiting for, " + player.mf("stud", "sexy") + "?</i>“ she asks, but doesn't wait for the answer before practically bouncing over to her pure spring and uncorking the vial. She sniffs it, smelling the strongly sweet-scented potion before pouring the roiling red liquid into the pool.");
        outputText("\n\nThe new fluid turns the spring cloudy red for a moment, before settling into the pure water and giving it a very slight, reddish tinge. The new lust-enhancing steam starts flowing off the water and mixes with the air. You can already feel its effects seeping into you, first causing a tingling on your skin, then a heat surges in your loins, ");
        if (player.hasCock())
        {
            outputText("your [cock] swelling in your [armor]");
        }
        if (player.hasCock() && player.hasVagina())
        {
            outputText("and ");
        }
        if (player.hasVagina())
        {
            outputText("your [pussy] quivering and growing wet");
        }
        outputText((". If this is what's happening to you so soon, Minerva must feel much more. Licking your lips, you approach your shark-harpy and pull her against you. Kissing her neck, you whisper to her, suggesting that the two of you " + isLover) ? "take that bath now." : "get started on your new romance.");
        outputText("\n\nMinerva gulps and looks over to you with a blushing face. She then smiles and nods before pulling away just long enough to strip her tube top and short shorts off and step into the soothing waters. The tall redhead looks over her shoulder, beckoning for you to join her.");
        
        dynStats("cor", 1);
        player.destroyItems(consumables.F_DRAFT, 1);
        flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = 1;  //The start of corruption.  
        doNext(minervaScene.bathTimeWithMinerva);
    }
    
    /**
     * Fail to convince Minerva to use the potion.
     */
    private function usePotionFail() : Void
    {
        outputText("As you explain what you have in mind and show Minerva the potion, she looks at you with worry and bites her pierced lip slowly. “<i>I don't know... I don't think it would be good to chance it. The spring is too important to risk exposing it to things from the corruption-infested outside world.</i>“ She leans in and nuzzles you gently. “<i>I'm sorry love. I just can’t risk it.</i>“ She says, as she gently pushes the vial back into your hands.");
        doNext(createCallBackFunction(minervaScene.genericMenu, true));
    }
    
    //Post-taint, pre-corruption encounter
    public function lustfulEncounter() : Void
    {
        minervaScene.minervaSprite();
        clearOutput();
        outputText("You make your way back up the mountain, passing the usual harpy nests as you go. Climbing through the clouds you reach a height that has become easy to you, thanks to the repeated effort. Your hands grip the rough stone as you pull yourself up, higher still, pushing yourself to reach the top of this enormous mountain. Looking up above yourself, you see the lip of the cliff that marks the top, luring you with the promise of a respite from your climb long with food and hopefully very pleasurable company.");
        outputText("\n\nGritting your teeth, you push yourself, forcing your tired muscles to pull you up over that lip, your hands grabbing for anything you can hold onto as you pull yourself up and over the rocky ridge. As soon as you are up, you roll onto your back and lay there panting from your difficult workout. You lick your lips as you think of what will be waiting for you in the tower. Ever since you spiked Minerva’s spring with a fuck draft you have been anticipating another visit to your lust-filled siren.");
        if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] == 4)
        {
            preCorruptionQuestBegin();
        }
        //plays even after the corruption warning, I assume?
        else
        {
            
            if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] == 1)
            {
                outputText("\n\nEven before you enter the tower you can hear sounds coming from inside. The pleasure-filled sounds of someone pleasuring themselves. However, as you get closer you can hear two sets of sounds. Deciding to investigate, you enter to find Minerva pinning a harpy to the mossy ground as she furiously pounds the fat-reared female’s cunt with her bloated, tentacle-bedecked member. The “<i>unfortunate</i>“ harpy seems to have her wings bound behind her back, as if Minerva captured her to use as her own sex slave... Maybe you shouldn’t of had her pour so much of that fuck draft into her pool. Despite being tied up, the harpy clearly doesn't seem to mind her position, as the feathery fuck slut is groaning and chirping with ecstasy.");
                outputText("\n\nAs you step closer the fuck-hungry shark-harpy notices your presence and grins, her tail swaying with playful glee at the thought of having someone else to play with. With a groan she turns her attention from you back to her harpy, just in time to ram her powerful hips against her lover’s wide, meaty thighs. Minerva shudders as her painfully engorged balls swell and stuff her harpy with gout after gout of her thick creamy cum. The slutty harpy lets out a delighted shriek as her belly inflates from the sheer amount of jizz being pumped into her womb by her fertile mistress.");
                outputText("\n\nMinerva sighs and pulls out of her bound companion and lets the big-butted female flop to the side, the harpy’s gaping pussy leaking thick globs of sperm as she pants and coos in a sex induced daze, licking her golden lips. Your siren lover turns her attention back to you before approaching you, her generous hips swaying back and forth enticingly, as she struts toward you, her anemone dick clearly still bloated with lust. “<i>Mmmm, so good of you to come [name], I’m not sure what’s going on with my body, but I’ve been so needy lately. That slutty harpy I caught has really helped out, but I need to fuck her at least once a day just to stop from going crazy. So... what can I do for you, love? Want to help me through this strange new hunger of mine?</i>“ she asks, licking her lips and sliding a hand across your thigh, as if to accentuate her need and help convince you to mate with her.");
            }
            else
            {
                outputText("\n\nEven before you enter the tower you can hear sounds coming from inside. Clearly Minerva is playing with her harpy slut as usual, you definitely put too much fuckdraft into her spring... that, or her unique corruption somehow amplified the effects.");
                outputText("\n\nAs you step closer the fuck-hungry shark-harpy notices your presence and grins, her tail swaying with playful glee at the thought of having someone else to play with. With a groan she turns her attention from you back to her harpy, just in time to ram her powerful hips against her lover’s wide, meaty thighs. Minerva shudders as her painfully engorged balls swell and stuff her harpy with gout after gout of her thick, frothy, creamy cum. The slutty harpy lets out a delighted shriek as her belly inflates from the sheer amount of jizz being pumped into her womb by her virile mistress.");
                outputText("\n\nMinerva sighs and pulls out of her bound companion and lets the ample hipped bird woman flop to the side, the harpy’s gaping pussy leaking thick globs of sperm as she pants and coos in a sex induced daze, licking her golden lips. Your siren lover turns her attention back to you before approaching you, her generous hips swaying back and forth enticingly as she struts toward you, her anemone dick clearly still bloated with lust. “<i>Oh, good! [name] I’ve missed you so much... have you come to spend some time with little old me? Would you like to help me get this hunger of mine under control?</i>“");
            }
            if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] < 4)
            {
                ++flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS];
            }
            minervaScene.genericMenu();
        }
    }
    
    private function preCorruptionQuestBegin() : Void
    {
        outputText("Even before you enter the tower you can hear sounds coming from inside. The same sounds of someone pleasuring themselves that you have got used to hearing, but something is different this time. Wondering about the change, you keep on going. As you get closer, you can hear numerous sets of sounds all mixed together. Deciding to investigate, you enter to find Minerva in the arms (so to speak) of three harpies at once. One is pinned under her as she brutally fucks it, harder than you have seen her take her old harpy, as if she is filled with a desperate need to breed. The second harpy holds onto Minerva’s thrusting hips while she licks and sucks on the siren’s now massive balls. Her already sizable pair of fertile nuts have gotten bigger, much bigger; her once apple sized balls have each grown to the size of cantaloupes.\n"
                + "\n"
                + "You look at her change with worry as you wonder if anything else will change with more time, but this doesn’t stop you from coming closer. The second harpy is eagerly sucking and massaging Minerva’s sperm factories, as if they were precious treasures to be worshipped, having a dreamy yet hungry look on her face as she fondles the shark-harpy’s sack."
                + ((player.hasPerk(PerkLib.MinotaurCumAddict)) ? " It's a look that you know very well" : "")
                + "The third harpy is eagerly kissing Minerva, hungrily making out with her and planting golden kisses on her lips and neck, clearly trying to arouse Minerva as much as possible with her potent harpy lipgloss. Upon closer inspection you see many kiss marks over Minerva’s body that can only be helping to fuel the immense sex craze that Minerva is locked in. Even with you so close, she doesn't seem to notice you, as her body and mind too consumed by the moment to bother with you, for now at least. You step back and watch as she shudders and rams her hips against her current fucktoy’s round meaty ass before finally cumming, her now-huge cantaloupe sized nuts swelling and pulling up into her body as she blows a truly massive load inside the harpy. The “<i>unfortunate</i>“ feathery woman’s belly begins swelling up almost instantly as what has to be liters of jizz flood her hungry pussy.\n"
                + "\n"
                + "It doesn't take long for the harpy to become over-stuffed by Minerva’s orgasm, yet more potent siren cum tries to fill her, splattering uselessly onto the ground. That is when the second harpy moves from Minerva’s heavy balls to lick and slurp up all the splooge she can get as it leaks out. As if sensing their need Minerva pulls back and forces her bloated, over-aroused cock from the very pregnant looking harpy. The two remaining harpies immediately take her place, grabbing the thick tentacle endowed dick and lapping up every drop they can get. The two feathery females continue worshipping the fat swollen thing even as it finally starts to ease off cumming. Even after Minerva’s orgasm is over, heavy, sticky, white cream continues leaking from it, only to be licked up by the needy girls. Strangely, it looks like they can’t get enough of the stuff, even though you can clearly see that they have had plenty. Their bellies are already rounded, swollen with eggs or with cum you can't tell, but regardless it’s more than likely that they are pregnant.\n"
                + "\n"
                + "Finally, as her orgasm ends, Minerva notices you, her lust hazed eyes looking at you for a moment as if she doesn't recognize you. After a couple of long seconds, though, she realizes who she is looking at and seems to snap back to reality. “<i>O-oh! [name], I didn't see you there. How long have you been here? I-I’m sorry, this place is such a mess. I haven't been able to get anything done. This rut I have been feeling just seems to be getting worse by the day... I’m not even sure where these two came from... maybe they smelled all the sperm I have been letting loose to calm myself down.</i>“\n"
                + "\n"
                + "Now a little worried about your friend, you approach her and ask if she is alright, your hand reaching out to touch her in an attempt to comfort her.\n"
                + "\n"
                + "“<i>I don't know. I have never felt like this before, it’s.... it’s scaring me actually. My dick won't go down at all and my balls, just... I mean, look at them! They’re huge! They have swelled up so much... no matter how much I fuck these harpies, I just can’t stop, I can’t calm down, I can't stop fucking....</i>“ The strong woman looks at you with worry and fear clearly written on her face. “<i>I don't know what’s happening to me... what if it just keeps getting worse? I don't want to become some sex-crazed beast that just hunts for its next fuck. I don't want to lose myself and become like everything else in this twisted world, existing just rape everything in sight!</i>“\n"
                + "\n");
        if (player.cor < 50)
        {
            outputText("Her distress is clear as the sun in the sky as she spills her guts to you. You know that you're the reason for her current condition, you’re the reason she is suffering at the hand of this insatiable lust and growing corruption. biting your lip, you feel terrible for putting Minerva through all this.");
        }
        else
        {
            outputText("Her distress is clear as the sun in the sky as she spills her guts to you. You know that you're the reason for her current condition, you feel a little bad for her, though if you were to just leave her like this you're sure she wouldn't be worrying about the implications for much longer. On the other hand, how grateful would she be if you were to cure her of the lust that fills her?");
        }
        if (flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] < 2)
        
        //Begins the quest so you have some time to do purification.{
            
            flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 1;
            flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 1;
            flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 1;
            flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
        }
        menu();
        addButton(0, "Reassure", reassure);
        if (minervaRomanced())
        {
            addButton(1, "Comfort", comfort);
        }
        //PC can return to Minerva and interact with her. if comfort, pc has 7 game days to do one of the purification options. after 7 days the next time the pc visits Minerva she reaches her end and becomes corrupted. if reassure pc has only 2 days to complete the purification after the 2nd day the next time the pc visits Minerva she becomes corrupted.
        
        //==================================
        function reassure() : Void
        {
            flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = 5;
            flags[kFLAGS.MINERVA_CORRUPTION_TIMER] = 3;
            clearOutput();
            outputText("You start guiding Minerva away from the harpies, who, at least for now, are too distracted by the fresh batch of cream on the ground and in one of the harpies themselves to notice you taking its source away. You lead her behind one of her fruit trees and sit her down on the soft moss that covers the ground. Sitting next to the tall redhead you slide an arm around her, trying to ignore the fact that she is still very much aroused. You pull her close to you and stroke her back softly, trying to calm her down, reassuring her that things are going to be alright. Your words seem to have some effect on her: her shark tail slides around and pulls against you, as if she didn't want you to let go of her.\n"
                    + "\n"
                    + "“<i>I... I’m sure you’re right...I’m just worried it’s not going to stop. I just don’t want to lose myself to this creature inside me. I want to be free of it. I want to be able to fly through the sky without worrying that if I stray too far I won't be able to get back to the spring in time.</i>“ Minerva says as she holds you. Despite her words, you can feel her shaking a little, clearly still afraid of what's going on with her body.\n"
                    + "\n"
                    + "You look over at the harpies and notice that they have cleaned up all the cum left over and are now eyeing Minerva. It probably won't be long until they try to get at her again for more of the surprisingly addictive cum she is putting out. Not wanting to get into a fight with them, you hug Minerva one last time and kiss her cheek before letting go. You point out that her “<i>pets</i>“ are likely to want her soon and that it’s best if you don’t hang around too long, causing her to sigh with frustration even though you swear you can see her cock grow harder in anticipation.\n"
                    + "\n"
                    + "“<i>I'm sure they will want me soon. Still, I think we have some time for ourselves, though. Is there anything you need, hun? Anything I can do for you?</i>“\n"
                    + "\n"
                    + "Due to her current condition, it’s likely she is running out of time. You probably only have a couple of days to find and administer a cure...");
            doNext(camp.returnToCampUseOneHour);
        };
        var comfort : Void->Void = function() : Void
        {
            flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = 6;
            flags[kFLAGS.MINERVA_CORRUPTION_TIMER] = 8;
            clearOutput();
            outputText("You start guiding Minerva away from the harpies, who, at least for now, are too distracted by the fresh batch of cream on the ground and in one of the harpies themselves to notice you taking its source away. You lead her behind one of her fruit trees and sit her down on the soft moss that covers the ground. Sitting next to the tall redhead you slide an arm around her, trying to ignore the fact that she is still very much aroused. You pull her close to you and stroke her softly, trying to calm her down.\n"
                    + "\n"
                    + "Using a hand, you touch her cheek and turn her head so you’re looking right into her bright, electric blue eyes. You promise that you will do whatever it takes to stop whatever is happening to her, before you tighten your hold on her and pull her into a deep kiss, her eyes fluttering closed at the intimate contact. Your hands stroke her smooth sharky skin gently as you work to comfort your lover. Your tongue slips out, licking her lips before sliding inside to deepen the tender embrace, her own coming to meet yours, slithering around yours and coiling around it like a snake.\n"
                    + "\n"
                    + "Minerva throws her arms around you and eagerly presses herself into the kiss, the siren diving headfirst into your attempt to calm her down and keep her from falling into despair. Your lover clutches your [player armor] tightly, not daring to let go as you kiss her and stroke her gently.\n"
                    + "\n"
                    + "Before long, you have to pull back and break the kiss to get some air. Looking at Minerva, you can see she is blushing and smiling just a little. “<i>Thank you, love. I’ll be strong I promise. I’ll be strong for you and fight this as hard as I can</i>“ she declares before kissing your neck gently.\n"
                    + "\n"
                    + "Smirking, you decide to take things a step further to help your lover. Pushing her down onto the soft moss you kiss her again, before reaching between her legs and feeling up her painfully engorged dick and moving down to touch her hot soaked pussy. Playfully, you tease her about giving her a certain form of physical help she so obviously needs.\n"
                    + "\n"
                    + "Your words make her blush deeply and look away shyly, before a bright smile breaks across her face. “<i>You’re such a charmer, you know that? Come here... give me the strength I need, "
                    + player.mf("stud", "sexy")
                    + "</i>“ she purrs before pulling you down on top of her.");
            doNext((player.hasVagina()) ? minervaScene.pcGetsEatenOutByMinerva : minervaScene.letMinervaSuckYouOff);
        }
    }
    
    //Minerva Corruption - after you haven't managed to fix her in time
    public function corruptTransformation() : Void
    {
        clearOutput();
        if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] == 5)
        
        //Reassure- Three days after reassure option and player visits the high mountain{
            
            outputText("It’s been at least three days since Minerva expressed just how scared and worried she was to you. Three days since you half-heartedly attempted to reassure her that it would be alright. Deciding to check on her progress, you scale back up the mountain and head for Minerva’s oasis. Even before you enter you can feel something is off. You can hear groaning and soft sobs coming from inside.\n"
                    + "\n"
                    + "Hurrying inside the tower, you clearly can see what's happening. Minerva is on her knees, her skin looking pale and sickl as she pants and groans in pain, clutching her chest and head. Her fevered eyes are looking unfocused as you approach her. It takes a moment for her to notice you and look up at you. You can see she is drenched in sweat, her smooth sharky skin glistening with it. What a sorry state she is in, clearly near the end of her uncorrupted life.\n"
                    + "\n"
                    + "Looking up at you with unfocused eyes, she licks her parched lips and tries to speak. It's easy to tell that she is suffering from what must be happening inside her body. Despite her pain, you can clearly see she is also painfully aroused, her tentacle-endowed cock at full hardness and swollen cantaloupe sized balls stretched tight, practically sloshing with pent-up seed, even as cum dribbles ceaselessly from her cocktip.\n"
                    + "\n"
                    + "“<i>L...Love... this is... this is it.... I can feel it. It’s growing out of control. I can feel my corruption spreading through me... after all this time, it's going to happen... I can't hold out anymore. I've tried to stop it, I’ve drunk from the spring and eaten the pure fruit until I just can't swallow anymore, but it’s not working!... There is nothing I can do to stop it!</i>“ she says to you with tears in her eyes. Her worst fears are coming to fruition: she is going to become fully corrupted very soon, and you will be here to witness her rebirth first-hand.\n"
                    + "\n");
            if (player.cor < 50)
            {
                outputText("Falling to your knees you wrap your arms around Minerva, holding her tightly as she is wracked with fever and pain from her dawning transformation. You can't help but feel bad for this. You may not have been in love with her and you know she’s going to be fun when she is corrupted, but your heart aches in empathy for her, knowing she is in such pain, and that you are the cause of it all. Lifting your hands you stroke her clammy cheeks before softly whispering to her that it’s going to be alright, that she just has to hold on a little longer.\n"
                        + "\n"
                        + "“<i>N-no you... you did all you could... I’m sorry I couldn't hold out any longer, I’m sorry I was too weak to keep fighting.</i>“ Minerva says, before gasping and clutching her chest, the parasite inside squirming in anticipation of its success.\n"
                        + "\n"
                        + "You put a hand on her shoulder and kneel with her. You tell her you're sorry, that you did what you could but it wasn't enough, that there wasn’t enough time.\n"
                        + "\n"
                        + "“<i>I...I thought that this would be it, that you would save me....you said you would... if only I had met you sooner, maybe something could have been done.</i>“ she whispers, as fresh tears run down her cheeks, before she lets out a scream of pain, announcing the start of her final transformation.");
            }
            else if (player.cor < 70)
            {
                outputText("Mournfully you step toward the sorrowful siren and put a hand on her clammy, hot cheek. Her body has grown so feverishly hot in a vain attempt to fight back against the inevitable. Smiling sadly at you, she reaches up with a shaky hand and touches yours.\n"
                        + "\n"
                        + "“<i>You... you did all you could... I’m sorry I couldn't hold out any longer, I’m sorry I was too weak to keep fighting.</i>“ Minerva says, before gasping and clutching her chest. the parasite inside squirming in anticipation of its success.\n"
                        + "\n"
                        + "You put a hand on her shoulder and kneel with her. You tell her you're sorry, that you did what you could but it wasn't enough, that there wasn’t enough time.\n"
                        + "\n"
                        + "“<i>I...wish I could have met you sooner.... maybe... maybe then there would have been enough time.</i>“ she whispers as fresh tears run down her cheeks, before she lets out a scream of pain, announcing the start of her final transformation.");
            }
            else
            {
                outputText("You smirk at the fallen woman as you step toward the sorrowful siren and put a hand on her clammy hot cheek. Her body has so feverishly hot in a vain attempt to fight back against the inevitable. Smiling sadly at you, she reaches up with a shaky hand and touches yours.\n"
                        + "\n"
                        + "“<i>You... you did all you could... I’m sorry I couldn't hold out any longer, I’m sorry I was too weak to keep fighting.</i>“ Minerva says, before gasping and clutching her chest. The parasite inside squirming in anticipation of its success.\n"
                        + "\n"
                        + " You snicker before brushing her hand away. You look down at her with amusement on your face. Minerva looks up at you with pain and confusion. “<i>Wha... What's the matter? Won't you even be here for me? For my last moments before I turn into a monster?</i>“ she asks with pain clear in her voice. Laughing, you taunt her, telling the once-woman that you tricked her, made her believe you cared for her just so she would taint her own spring with those drugs. She has destroyed what was keeping her from being fully corrupted, and now she will become what she was always meant to be!\n"
                        + "\n"
                        + "“<i>I...you.... you "
                        + player.mf("bastard", "bitch")
                        + "! You cruel heartless monster! How could you! How could you do this to me!</i>“  Minerva screams with rage, before actually climbing to her feet and lunging to attack you. Fortunately for you her own body betrays her. Frozen by newfound agony, Minerva lets out a scream of pain as her final transformation begins.");
            }
        }
        //Comfort- eight days after comfort option and player visits the high mountain
        else
        {
            
            outputText("It’s been over a week since Minerva expressed just how scared and worried she was to you. Over a week since you comforted her and promised her that you would find a way to cure her of her affliction before it was too late. ");
            if (player.cor < 60)
            {
                outputText("You know time is running out for her and now you scale the mountains again to check on your lover and see if you can provide her some form of comfort again. As you reach the tower again, though, you can feel it deep in your heart before you can even enter. You can feel some dark presence inside the tower, the very feeling of it causes your heart to drop and grow cold. What if you're too late? You hadn't found anything to cure her with, what if it's too late and she is already too far gone...?");
            }
            else
            {
                outputText("You know time is running out for her and now you scale the mountains again to check on your lover and see if you can provide her some form of comfort again. As you reach the tower again, though, you can feel it deep in your heart before you can even enter. You can feel some dark presence inside the tower, the very feeling of it causes you to grow excited, could it be too late? are you just in time to witness Minerva’s transformation?");
            }
            outputText("\n"
                    + "\n"
                    + "Hurrying inside the tower you clearly can see what's happening. Minerva is on her knees, her skin looking pale and sick as she pants and groans in pain, her hands clutching her chest and head. Her fevered expression looking unfocused as you run to her side. it seemingly takes a moment for her to notice you and look up at you. You can see she is drenched in sweat, her smooth sharky skin glistening with it. Its as bad as you thought, the corruptive parasite inside her has grown too strong. Your lover is reaching the end of her uncorrupted life, soon to be reborn as something far darker.\n"
                    + "\n"
                    + "Looking up at you with unfocused eyes, she licks her parched lips and tries to speak. It's easy to tell she is suffering and in pain from what must be happening inside her body. Despite her obvious pain, you can clearly see she is painfully aroused, her tentacle endowed cock at full hardness and swollen cantaloupe sized balls tight and practically sloshing with pent-up seed.\n"
                    + "\n"
                    + "“<i>L...Lover... this is... this is it.... I can feel it. It’s growing out of control. I can feel my corruption spreading through me... after all this time, it's going to happen... I can't hold out anymore. I've tried to stop it, I’ve drunk from the spring and eaten the pure fruit until I just can't swallow anymore, but it’s not working!... There is nothing I can do to stop it!</i>“ she says to you with tears in her eyes. Her worst fears are coming to fruition: that she is going to become fully corrupted very soon and you will be here to witness your utter failure to save her from her fate/witness her rebirth into a far more suitable form first hand.\n"
                    + "\n");
            if (player.cor < 50)
            {
                outputText("Falling to your knees, you wrap your arms around Minerva, holding her tightly as she is wracked with fever and pain from her dawning transformation. You can't help but feel bad for this. You know she is going to be fun when she is corrupted, but you still love her and your heart aches for her, knowing she is in such pain. Lifting your hands, you stroke her clammy cheeks before kissing her softly, whispering to her that it’s going to be alright, that she just has to hold on a little longer.\n"
                        + "\n"
                        + "Despite your words, you can see the fear in her eyes. She knows it’s too late, and she knows what's going to happen to her. Shakily she brings a hand up to yours and holds it. “<i>No... no, it’s not... it’s too late. I can already feel it spreading, creeping into my mind, getting so hard to fight... I don't have much time left, lover, so I need to tell you...I love you! You have brought me so much happiness and, even though my end is near. I want you to know that ever since I came to this world, you have been the one bright light in my life.</i>“ she says, before gasping and shuddering against you. “<i>P...please... I have one last request...I know it’s hard but... please, kill me. I don’t want to be one of those monsters. Please, I don’t want this! Please, kill me now before it’s too late. I want to be myself in my last moments, knowing the love of the one most special to me. Please do me this las-</i>“\n"
                        + "\n"
                        + "You don’t even let her finish. With tears in your eyes you kiss the distraught siren and cradle her the best you can. Even though this is happening to her, and that it’s your fault for not trying hard enough, you can't bring yourself to kill her. You hold the kiss and keep her held tightly, even as she gently hits you and “<i>struggles</i>“ against you. You don’t let go even as she pulls back with tears running down her face, the distraught woman crying out in pain before screaming, as her final transformation has begun.");
            }
            else if (player.cor < 70)
            {
                outputText("Falling to your knees, you wrap your arms around Minerva, holding her tightly as she is wracked with fever and pain from her dawning transformation. You can't help but feel bad for this. You know she is going to be fun when she is corrupted, but you still love her and your heart aches for her, knowing she is in such pain. Lifting your hands, you stroke her clammy cheeks before kissing her softly, whispering to her that it’s going to be alright, that she just has to hold on a little longer.\n"
                        + "\n"
                        + " Despite your words, you can see the fear in her eyes, she knows it’s too late, and she knows what's going to happen to her. Shakily, she brings a hand up to yours and holds it. “<i>No... no, it’s not... it’s too late. I can already feel it spreading, creeping into my mind, getting so hard to fight... I don't have much time left, lover, so I need to tell you...I love you. You have brought me so much happiness and, even though my end is near, I want you to know that ever since I came to this world, you have been the one bright light in my life.</i>“ she says, before gasping and shuddering against you. “<i>P...please... I have one last request... I know it’s hard but... please, kill me. I don’t want to be one of those monsters. Please, I don’t want this! Please, kill me now before it’s too late! I want to be myself in my last moments, knowing the love of the one most special to me. Please do me this las-</i>“\n"
                        + "\n"
                        + "Putting a hand to her mouth you stop her from talking, looking at her with shock that she even suggested such a thing. Despite her asking you at such a critical time, you shake your head, refusing to even think about it. You hug Minerva tightly and tell her it’s alright, No matter what happens to her, you will still love her. Minerva shakes her head, looks at you and is about to insist, when she groans before crying out and then screaming in pain as her final transformation begins.");
            }
            else
            {
                outputText("Falling to your knees, you wrap your arms around Minerva, holding her tightly as she is wracked with fever and pain from her dawning transformation. You can't help but feel bad for this. You know she is going to be fun when she is corrupted, but you still love her and your heart aches for her knowing she is in such pain. Lifting your hands, you stroke her clammy cheeks before kissing her softly, whispering to her that it’s going to be alright, that she just has to hold on a little longer.\n"
                        + "\n"
                        + "Despite your words, you can see the fear in her eyes, She knows it’s too late, and she knows what's going to happen to her. Shakily, she brings a hand up to yours and holds it. “<i>No... no, it’s not... it’s too late. I can already feel it spreading, creeping into my mind, getting so hard to fight... I don't have much time left, lover, so I need to tell you...I love you. You have brought me so much happiness and, even though my end is near, I want you to know that ever since I came to this world, you have been the one bright light in my life</i>“ she says before gasping and shuddering against you. “<i>P...please... I have one last request...I know it’s hard but... please, kill me. I don’t want to be one of those monsters. Please, I don’t want this! Please, kill me now before it too late. I want to be myself in my last moments, knowing the love of the one most special to me.</i>“\n"
                        + "\n"
                        + "You look at her with confusion. Why would she even want this to stop? She should be embracing this change. You tell her that you could never kill her and that you will love her more because of the transformation. For a moment she looks at you baffled at your words. “<i>You promised to help me! You promised to save me, not turn me into some monster! This isn’t what I wanted!</i>“ she yells at you before groaning, crying out and then finally screaming in pain as her final transformation begins.");
            }
        }
        //Shared part
        outputText("As you watch, you can see it happen. Her body shifting and transforming into a twisted, corrupted version of herself. The first thing to change is her skin, colors shifting in a pattern that spreads out from her chest, where the parasite once was. Her navy blue and grey sharkskin darkening and turning into a vibrant ultraviolet, her orange and white stripes along with her gray tummy, neck and inner thighs becoming an angry, devilish, red color. Her wings change as well, the red feathers darkening and turning a deep black as her wings grow larger than before.\n"
                + "\n"
                + "Minerva’s once bright blue eyes shift and seem to take on an unnatural vivdness, her black sclera seeming to darken even more, turning her orbs into black pits with shocking blue gems at the center.  You can feel more changes coming about as you "
                + ((player.cor < 70) ? "hold" : "watch")
                + " the corrupting herm. Her body seems to harden, growing stronger while gaining a strange outward softness, like a powerful monster hiding in the guise of a beautiful woman.\n"
                + "\n"
                + "Your lover's breasts grow larger, reaching large E-cups that retain surprising perkiness. Between her legs a second anemone dick sprouts and swells to the size of her first member, both dicks changing and losing their transparency, as if they truly were merging with her body. Minerva’s already huge balls swell to reach the size of soccer balls as her hips and ass widen even more, spreading out as if to give them room and to make it easy to give birth.\n"
                + "\n"
                + "With the last small changes Minerva stops screaming, falling to her hands and knees. The only thing that remains of the original Minerva is her fiery red hair, though it is now streaked with black. Slowly she starts to stand up. Her now more voluptuous body rising to her usual 8’5 as she looks around lazily, her vivid electric blue eyes sweeping the room before she looks at you. She stares at you for a moment as if trying to remember you, soon though she grins a sinister grin and starts to caress and grope her newly corrupted body. “<i>Mmmm.... So this is what it feels like. Such dangerous hunger, such desires... I owe it all to you, love, for doing this to me.</i>“ she purrs as she strokes your cheek seductively, before turning away from you and looking at the pure oasis.\n"
                + "\n"
                + "“<i>Now to rid this eyesore from my home.</i>“ the corrupted siren proclaims as she strides toward the spring, her hands grabbing hold of her twin cocks and starting to stroke them with shameless abandon, her wide broodmother like hips swaying back and forth enticingly as she approaches the edge of the spring. Licking her lips she spreads her legs and strokes herself harder, her hands pumping her twin cocks madly. Instantly, she starts to moan and groan with perverted delight, the combination of her increased libido and the venom her tentacles are pumping into each wrist pushing her swiftly to arousal. Minerva’s demonic tongue slithers out of her mouth as she fully indulges the pleasure of what she is about to do.\n"
                + "\n"
                + "With her body still so sensitive from her transformation, she quickly reaches her much-needed orgasm. Reaching deep inside her twisted, irreparably corrupted body, she explodes into orgasm with a deep echoing moan, barely maintaining enough control to angle her dicks down, aiming right at the pure spring. Her massive balls clench as thick black jizz gushes from her enormous twin cocks, the corrupted sperm landing in the water with thick wet sloshes. Deep within the grip of the most explosive orgasm she has ever felt, Minerva unloads a truly massive amount of ebony cream. Bolt after long goopy bolt is blasted into the water, and with each shot the concentrated corruption defiles the pure spring, the water losing its clarity,  turning dark and syrupy with the sheer amount of black cum mixed in with the once pure, clean water.\n"
                + "\n"
                + "With the foul act completed, Minerva brings her corruption stained hands to her lips before licking the black jizz from them in an erotic fashion, her eyes rolling back in ecstasy as she drinks this most blatant symbol of her twisted new self. “<i>Mmmm... such a pure thing has no place in this world. Not as long as I’m here.</i>“ she says out loud before turning to you and starting to walk toward you. “<i>Thank you for showing me the light, love. Without you, I never would have been able to realize that this is how I was meant to be.</i>“ she says, pausing for a second before stroking your cheek with a freshly cleaned hand.\n"
                + "\n");
        if (player.hasVagina())
        {
            if (player.isPregnant())
            {
                outputText("“<i>What can I do for you, love? Shame you're pregnant already, you could have had the honor of being the first to bear my progeny... though I wonder what would happen if I took you and ravaged you anyway.</i>“ she muses before licking her pouty black lips.");
            }
            else
            {
                outputText("“<i>What can I do for you, love? Perhaps you want to have the honor of bearing my progeny?</i>“");
            }
        }
        else
        {
            outputText("“<i>It’s a shame you’re male. If you were a woman you could have had the honor of being the first to bear my progeny. I can't just let someone like you just get me pregnant, either. You will have to prove your worthiness if you want that honor.</i>“");
        }
        flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = 10;
        minervaScene.minervaSprite();  //here to consider the flag  
        corruptMenu();
    }
    
    public function corruptEncounter() : Void
    {
        if (player.isRace(Races.HARPY))
        {
            corruptEncounterAsHarpy();
            return;
        }
        minervaScene.minervaSprite();
        clearOutput();
        outputText("You make your way back up the mountain, passing the usual harpy nests as you go, looking for the oasis tower that you know has to be around here somewhere. With a bit of searching you locate the correct path and head for the oasis. The promise of a respite from your climb, along with food and company, commands you to continue until you finally reach the oasis tower. Thankfully, you don't have to walk for long and promptly catch sight of the crumbling tower.  Panting from your long trek, you enter the tower through its crumbling door, only to find the corrupted creature you helped create\n"
                + "\n"
                + "As you enter the tower, you can't help but notice its general condition has improved a bit. Much of the broken stone that just lay scattered on the ground has been removed, as well as the walls and roof being shored up and secured. It seems your corrupted lover has been improving her lair. Taking a look around, you see the corrupted oasis, the trees looking more sinister and the pool like a thick bubbling pit of blackish ooze.\n"
                + "\n"
                + "It doesn’t take you long to spot Minerva’s harpies, though it seems she has captured more and added them to her harem since you were last here. The half-bird females have been chained to the floor, with their wings bound together so they can’t fly away, even if they do escape their chains. From the looks on their faces they are drugged out of their minds, It’s most likely that being corrupted has further enhanced the drug-like effects of Minerva’s new cum.\n"
                + "\n");
        //preg talks override everything
        if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancy2Type == PregnancyStore.PREGNANCY_MINERVA)
        {
            encTextBothPreg();
        }
        else if (player.isPregnant())
        {
            encTextPlayerPreg();
        }
        else if (minervaScene.pregnancy.isPregnant)
        {
            encTextMinervaPreg();
        }
        else if (kidsCount > 0)
        {
            randomChoice(encTextHarpySex, encTextBath, encTextBabies)();
        }
        else
        {
            randomChoice(encTextHarpySex, encTextBath)();
        }
        corruptMenu();
        //===========================================
        
        //harpy sex
        function encTextHarpySex() : Void
        {
            outputText("Soon you notice Minerva too, her dark, imposing form leaning over one of her harpy sluts and roughly fucking her into the ground. From the looks of it, Minerva has been going in a line, intending to fuck and knock up each of her slaves. As you approach the rutting pair Minerva’s dark eyes look you up and down, visually undressing you as she continues rutting her harpy.\n"
                    + "\n"
                    + "As she watches you, you can tell she is likely swimming in lustful thoughts about you. Before you can even head over to her, it seems the corrupted creature is just finishing. With a deep grunt and powerful thrust, she hilts herself balls-deep in the feathery, cum addicted female, before blowing her massive corrupted load into the woman, bloating her belly and filling her body with thick sticky cum.\n"
                    + "\n"
                    + "With her current fuck done, Minerva slowly pulls out, drawing out the sexual pleasure as long as possible, before letting the harpy collapse onto the ground. Sighing contently, the corrupted siren rises to her full imposing height, before striding toward you, her brood mother hips swinging back and forth as she approaches you and reaches out to you, her hands sliding around you as she leans in, pushing her now larger breasts against you, their pillowy softness squishing against you delightfully. “<i>Now... what can I do for you, lover? Here to take part in the fun, or would you like to try the new fruits going around here. They taste sooo much better than before, positively spine tingling, and guaranteed to put you in the right mood.</i>“ she croons as she gestures to the now corrupted fruit that grows from the trees.");
        }  //bathing - no conditions  ;
        
        
        
        function encTextBath() : Void
        {
            outputText("As you look around you don't spot her right away, but upon further inspection you find her bathing in the defiled spring, her large, dark form lounging in the bubbling black syrup. You can clearly see that she is enjoying herself. Her head lays back against the edge of the pool, her arms under the water, slowly moving under the thick fluid, making it's clear that she is masturbating in her perverse “<i>bath</i>“.\n"
                    + "\n"
                    + "As you approach, her eyes open and lock on to you. A grin grows on her face, as she keeps jerking her members. One of her hands rises from the sludge to beckon to you, calling you over to her as she slowly jerks herself off in her bath. Letting out a purr of delight, the corrupt creature speaks.“<i>Mmmm, darling, how wonderful of you to join me here. Would you care to take a dip with me in this delicious bath?</i>“ she asks before shivering with delight. Her body arches visibly as her 2-foot demonic tongue lolls out and licks her lips. A cloud of white forming in the thick pool makes it obvious that Minerva reaches her orgasm. Despite the copious climax, the blackness of the ooze returns almost instantly, as if it's devouring the corrupt woman's cum.\n"
                    + "\n"
                    + "Looking down at her, you can't help but be amazed and even a little wary with the corrupted being you helped create. Seeing that you aren't going to join her, Minerva sighs and sits up before stepping out of the defiled spring, the black, sticky ooze slipping off her body like oil as it coats her. You can't help but notice how the syrupy fluid defines her amazingly curvy body, drawing your eyes across her very generous curves.\n"
                    + "\n"
                    + "Seeing your eyes practically molesting her, Minerva grins widely, showing her sharp shark teeth before seductively posing for you, sliding her hands lavishly over her body. “<i>Like what you see, do you? Well, feel free to indulge in them. ");
            if (player.hasCock())
            {
                outputText("As long as you don't try and knock me up, of course. You have to prove yourself worthy of giving me children. Only the most worthy males or herms can have the honor of getting me pregnant.</i>");
            }
            else
            {
                outputText("Perhaps you have come to be blessed with my delightful progeny...? You would make a fine mother.</i>");
            }
        }  //babies (only available after corrupt Minerva births  1+babies. or after 7 game days) 2 variants  ;
        
        
        
        function encTextBabies() : Void
        {
            if (rand(2) == 0)
            
            //too many differences to merge{
                
                if (kidsCount == 1)
                {
                    outputText("As you take a look around, you take in the sight of Minerva with her offspring, the corrupted herm already fully mature and somewhere around seven feet tall. The dark siren broodmother is stroking her daughter’s face as she presents a new harpy to her mother as a gift. “<i>Such a good girl you are, bringing your mother a new harpy to impregnate. As a reward, you can play with the harpies that are already pregnant.</i>“ she magnanimously tells her daughter, who cheers and quickly runs off to play with the chained up bird-women.\n"
                            + "\n"
                            + "Turning her attention to you. Minerva grins devilishly at you. “<i>How nice of you to join us, darling. Come to check on little old me? My daughter is growing up quickly. Already she is ready to breed. As you can see, she even brings more harpies for me to fuck and knock up, all so she can have more sisters.");
                }
                else
                {
                    outputText("As you take a look around, you take in the sight of Minerva with a few of her offspring, the corrupted herms already fully mature and somewhere around seven feet tall. The dark siren broodmother is stroking her daughters’ faces as they present a new harpy to their mother as a gift. “<i>Such good girls you are, bringing your mother a new harpy to impregnate. As a reward, you girls can play with the harpies that are already pregnant.</i>“ she magnanimously tells her daughters, who cheer and quickly run off to play with the chained up bird-women.\n"
                            + "\n"
                            + "Turning her attention to you. Minerva grins devilishly at you. “<i>How nice of you to join us darling. Come to check on little old me? My daughter(s) is/are growing up quickly. Already they are ready to breed. As you can see, they even bring more harpies for me to fuck and knock up, all so they can have more sisters.");
                }
                outputText(" Won't be too long, before there will be so many of us we will have to spread out into the mountains.</i>“\n"
                        + "\n"
                        + "Minerva strides over to you, for now ignoring the bound and struggling harpy that was brought to her and turns her attention to you. Her hands slide over you and pull you to her large, curvaceous, motherly body. “<i>So, my dear, what can I do for you.? Want to taste the sweet corrupt juices of my fruit, drink deep of my defiled spring? Or perhaps you want to join in ultimate pleasure...  ");
                if (player.hasCock())
                {
                    outputText("as long as you don't try and knock me up, of course. You have to prove yourself worthy of giving me children. Only the most worthy males or herms can have the honor of getting me pregnant.");
                }
                else
                {
                    outputText("Perhaps you have come to be blessed with my delightful progeny. You would make a fine mother for my beautiful daughters...");
                }
            }
            else
            {
                outputText("As you enter the ruins, you instantly catch sight of Minerva bouncing " + ((kidsCount == 1) ? "her daughter" : "one of her daughters") + " in her lap, fucking the smaller siren with both of her cocks. ");
                if (kidsCount >= 3)
                {
                    outputText("Off to the side, you see her other daughters enjoying each other’s company, the dark-colored herms dissolving into a sexual pile as they join their mother in the delicious debauchery.");
                }
                else if (kidsCount == 2)
                {
                    outputText("Off to the side, you see her other daughter pleasuring herself to the sight of her mother stuffing her sister with her thick tentacle dicks.");
                }
                outputText(" You can't help but look at the sinful display of incest before you. Your corrupted siren responds by shooting you a glance and grinning, even as she fucks her daughter with newfound passion, as if the fact that she has an audience only turns her on more. “<i>Look at how eager ");
                if (kidsCount == 1)
                {
                    outputText("she is. She grew up so quickly and she is");
                }
                else
                {
                    outputText("they are. They grow up so quickly and are");
                }
                outputText(" already old enough for breeding. Poor thing couldn't even wait and jumped me as I was getting out of the spring.</i>“ she laughs wildly with glee.\n"
                        + "\n");
                if (player.cor >= 60)
                {
                    outputText("Licking your lips at the delicious display, you approach the dark brood mother as she bounces her horny daughter up and down in her lap.");
                }
                else
                {
                    outputText("Shuddering at the sinful sight, you approach them; as you came here for a reason after all.");
                }
                outputText(" The young herm in question pays no attention to you, just moaning and grabbing her mother's tits aggressively before she lets out a cry and cums hard. The smaller herm’s dicks are gushing cum onto her uncaring mother, splashing across her belly and breasts, painting them white with her corrupted fertility. The mother herself groaning, her 2-foot demonic tongue lolling out as she hilts deep into her daughter and blows her copious load into her daughter’s body, utterly filling her ass and pussy with what has to be liters of thick corrupted sperm. You wouldn't be surprised if she just knocked up her daughter with how much was pumped into her once-empty womb.\n"
                        + "\n"
                        + "After stoking her daughters face and kissing her passionately, Minerva pulls her daughter off her and deposits her on the mossy ground, before striding over to you, two tentacled cocks still rock hard. “<i>Now what can I do for you, my love? ");
                if (player.hasVagina())
                {
                    outputText("Did you like what you saw? Perhaps you want to be just like the little slut? Want to take a ride on my fat cocks and get knocked up with a beautiful siren daughter that I'll fuck as soon as she is ready to breed?</i>“");
                }
                else
                {
                    outputText("Perhaps you want to try your hand at knocking me up? Of course, you have to prove you're worthy of giving me children. Only the most worthy males or herms can have the honor of getting me pregnant.</i>“");
                }
            }
        }  //Corrupt Minerva pregnant encounter  ;
        
        
        
        function encTextMinervaPreg() : Void
        {
            clearOutput();
            outputText("As you enter the tower, you catch sight of Minerva, heavily pregnant and stroking her belly. Looking up to see you, she smirks and cradles her belly, seemingly happy that you had managed to prove yourself to her and actually impregnate her.\n"
                    + "\n"
                    + "“<i>Well, well, my strong fertile lover has returned to me. Your new daughter is growing well inside me. Won't be long until it's time for me to give birth.</i>“ she notes before getting up. She makes a show of stretching to her full height so you can clearly see the heavy bulge in her tummy, the sign of your offspring growing inside her. Approaching her, you stroke her belly and even plant a kiss on it, Looking at the corrupted & pregnant woman’s reaction you see her looking a little surprised, but soon a jagged grin slides onto her face. “<i>She is going to grow up quickly when she is born. I'm sure she will enjoy ‘getting to know’ her father.</i>“ The siren broodmother says with a perverted snicker, before stroking your cheek and licking her lips.\n"
                    + "\n"
                    + "“<i>Now, did you just come to visit me or was there something you're after?");
            if (player.hasVagina() && player.canGetPregnant())
            {
                outputText(" Perhaps you want a belly to match mine? Is that it? You want your Minerva to knock you up with a beautiful siren baby?");
            }
            outputText("</i>“");
        }  //PC pregnant with Minerva’s baby  ;
        
        
        
        var encTextPlayerPreg : Void->Void = function() : Void
        {
            if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancy2Type == PregnancyStore.PREGNANCY_MINERVA)
            {
                outputText("As you enter the tower, you scan around, looking for the corrupted siren. One of your hands stroking your swollen belly gently, you know you're carrying Minerva’s corrupted progeny inside you. You don't have to wait long, The proud-looking siren quickly spots you and approaches eagerly, sweeping up to you and placing a hand on your belly, stroking it tenderly. Despite being so corrupted, Minerva is still, in her way, a loving mother... or loving father, in this case.\n"
                        + "\n"
                        + "“<i>You know you look so good with a bellyful of my babies. How does it feel, to know you’re going to birth such a corrupted daughter, sired by such a fertile and powerful being.</i>“ she says as she strokes your stomach. “<i>Make sure you come back after she is born. I would be eager to knock you up with another.</i>“ she says. Her tone is playful, but you know she is completely serious.\n"
                        + "\n"
                        + "“<i>Now then, I’m sure you didn't just come here so I could stroke your pregnant belly. What can I do for you, you darling breeder of mine?</i>“ she coos, pinching your rump for emphasis.");
            }
            else
            {
                outputText("As you enter the tower, you scan around, looking for the corrupted siren, one of your hands stroking your swollen belly gently while you do. You don't have to wait long before Minerva finds you, the tall, curvaceous woman approaching you and looking you up and down. You can't help but notice she looks disappointed as she reaches down and feels your swollen stomach.\n"
                        + "\n"
                        + "“<i>A shame...you let yourself get knocked up by some inferior beast. Why ever would you let one of them put a baby in your belly when you could come to me and get a proper fucking. I’ll impregnate you with beautiful strong siren daughters!</i>“ she says as she teasingly fondles her heavy, virile balls and twin tentacled cocks.\n"
                        + "\n"
                        + "“<i>Now, my dear, tell me what Minerva can do for you! Just remember to come to me when that belly of yours becomes available and I'll gladly stuff your womb with my energetic little spermies.  I’ll get you good and pregnant with my sirens, just like you should be.</i>“");
            }
        }
        
        var encTextBothPreg : Void->Void = function() : Void
        {
            clearOutput();
            outputText("As you enter the tower, you scan around, looking for the corrupted siren. One of your hands stroking your swollen belly gently, you know you're carrying Minerva’s corrupted progeny inside you. You don't have to wait long, as the proud-looking siren quickly spots you and approaches eagerly, sweeping up to you and placing a hand on your belly, stroking it tenderly. Despite being so corrupted, Minerva is still, in her way, a loving mother... or loving father, in this case. The tall, dark broodmother’s belly matches yours, swollen and round with a new siren daughter. You can't help but reach up and stroke her belly as well. After all, you have proven yourself worthy and impregnated the proud woman with your seed, Making you the father of the young siren growing in her corrupted womb.\n"
                    + "\n"
                    + "You look at her as she coos to you, sounding almost like a dove. She pulls you closer and presses her pregnant body against your own, your gravid bellies touching. “<i>Isn't it a beautiful sight? Both of us pregnant with beautiful young sirens. Imagine the pleasure there will be when all females bear my progeny inside them... when all will feel the delight of bearing such strong, beautiful, pleasurable daughters... don't you think so?</i>“ she asks. ");
            if (player.cor < 60)
            {
                outputText("You look at her unsure of her words. What if her kind did fill the world, impregnating every female and raping every worthy and strong male, all to make more and more admittedly beautiful sirens?");
            }
            else
            {
                outputText("Licking your lips you imagine a world filled with beautiful, curvy large breasted, thick dicked sirens. Nodding, you can't help but agree with her sentiments, leaning down to kiss her pregnant tummy, your act drawing a grin and perverse giggle from Minerva. “<i>Mmmm... I’m glad to see you agree, darling. Let's be sure to keep breeding more and more wonderful sirens.</i>“");
            }
            outputText("Finally the maternal moment is over for now and Minerva strokes your cheek. “<i>What can Minerva do for you, my beautiful fertile breeder? Tell me your desires.</i>“");
        }
    }
    
    //ANYWAY:
    private function corruptMenu() : Void
    {
        menu();
        addButton(0, "Talk", corruptTalkMenu);
        addButton(1, "Eat", eatWrapper).hint("Corrupted 'Eat' menu is neither written nor coded, so... have the basic one.");
        addButton(2, "Sex", corruptSexMenu).disableIf(player.isGenderless(), "Not for genderless.").disableIf(player.lust < 33, "Not aroused enough!");
        addButton(3, "Fight", minervaScene.fightMinerva);
        if (debug)
        {
            addButton(4, "ROLLBACK", fixHer).hint("Rollback Minerva to pre-corrupted state.");
        }
        addButton(14, "Leave", camp.returnToCampUseOneHour);
    }
    
    public function corruptTalkMenu() : Void
    {
        if (flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] == 0)
        {
            corruptTalkBackstory();
            return;
        }
        outputText("What do you want to ask her about?");
        menu();
        addButton(0, "Her", corruptTalkBackstory);
        addButton(1, "Spring", corruptTalkSpring);
        addButton(2, "Daughter", corruptTalkDaughter);
        addButton(4, "Back", corruptMenu);
    }
    
    private function eatWrapper() : Void
    {
        minervaScene.eatSomethingYouCunt();
        addButton(4, "Back", corruptMenu);
    }
    
    private function fixHer() : Void
    {
        flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] = 0;
        flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = 0;
        flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 0;
        flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 0;
        flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 0;
        flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 0;
        flags[kFLAGS.MINERVA_CORRUPTED_AS_HARPY] = 0;
        flags[kFLAGS.MINERVA_CORRRUPTED_HARPY_COUNTER] = 0;
        //reset children counter and clear pregnancies
        flags[kFLAGS.MINERVA_CHILDREN] = 0;
        minervaScene.pregnancy.knockUpForce();
        if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA)
        {
            player.knockUpForce();
        }
        if (player.pregnancy2Type == PregnancyStore.PREGNANCY_MINERVA)
        {
            player.knockUpForce(0, 0, 1);
        }
        playerMenu();
    }
    
    private function corruptEncounterAsHarpy() : Void
    {
        minervaScene.minervaSprite();
        clearOutput();
        outputText("Making your way up the mountain, you find yourself at the path that will lead you to Minerva’s lair. Looking down the path you feel creeping sense of fear, like a primal instinct warning you not to go that way. Thinking about the siren, you know she likes to capture harpies and use them to birth her siren daughters, raping them till they are drugged out, mind broken sex slaves that she keeps pregnant. With how you are now you are now you can't help but worry that she might try to do the same to you. With the sense of danger strong in your head, do you follow the path or do you turn away, taking a less dangerous route?");
        addButton(0, "Follow", follow);
        addButton(1, "Turn Away", turnAway);
        addButton(4, "ReturnToCamp", camp.returnToCampUseOneHour);  //to make it less annoying?  
        //=========================================================
        
        function follow() : Void
        {
            clearOutput();
            ++flags[kFLAGS.MINERVA_CORRUPTED_AS_HARPY];
            if (flags[kFLAGS.MINERVA_CORRUPTED_AS_HARPY] > 3)
            {
                if (player.hasVagina())
                {
                    harpyBadEnd();
                    return;
                }
                else
                {
                    sceneHunter.print("Check... passed? You don't have a vagina. But what if you had?");
                }
            }
            if (flags[kFLAGS.MINERVA_CORRUPTED_AS_HARPY] == 1)
            {
                outputText("As soon as you enter, you feel a sinister presence. You don't have to wait long to find out what it is. Within moments, something grabs hold of you. Looking around frantically for whatever beast has grabbed you, you finally manage to spot Minerva grinning at you. “<i>Well, well, a little harpy has found her way into my home... I hope you like it, 'cause you're gonna be here forever, little one, forever birthing my offspring.</i>“ she croons, baring her teeth in her most intimidating grin. However, she stops, looking at you closely and inspecting you critically before grinning even wider.");
            }
            else if (flags[kFLAGS.MINERVA_CORRUPTED_AS_HARPY] <= 3)
            {
                outputText("As you enter you look around for Minerva, remembering what happened last time with her, you can't be too careful. Almost immediately you feel anxious and start looking around, but your eyes can't see the corrupted siren anywhere, feeling almost like you're being hunted. Instinctively you start to reach for your [weapon] as you approach the spring, but as you do a large hand rips you off the ground and holds you up into the air. Looking up, you see the grinning face of Minerva\n"
                        + "\n"
                        + "“<i>I’ve been so fortunate. so many harpies find their way to me lately, none of them ever leave, though. After they get a taste of my cum they don't want to go anywhere and neither will you.</i>“ she says, licking her lips with that demon tongue. You're about to struggle against her when she stops, looking at you closely and inspecting you critically before grinning wider.");
            }
            outputText(" “<i>Oh, darling! It’s you! I almost didn't recognise you. For a moment I thought you were just another harpy... Do come in, love, I’m happy to see you.</i>“\n"
                    + "\n"
                    + "Your heart is pounding like a drum as she lets you back down on the ground and struts away further into her tower. That was a close call! What if she had not recognised you? Would she have chained you up like those other harpies? Reduced you to nothing more than something to be used as a birthing machine for the rest of your life? Minerva turns back to you and looks you up and down... You can't help but notice the sinister look in her eyes. “<i>Now, what can I do for you, darling? And my, don't you look delicious today..</i>“");
            corruptMenu();
        };
        
        var turnAway : Void->Void = function() : Void
        {
            clearOutput();
            outputText("Looking away from the path you turn away, not intending to find out just how the corrupted siren would react to your appearance. Turning away from the tower’s path you continue your climb in search of other things.");
            doNext(SceneLib.highMountains.exploreHighMountain);
        }
    }
    
    //Bad end- if pc visits corrupt Minerva more than three times as a full harpy morph and have a vagina (Fenoxo defines; most likely requires harpy wings, harpy legs, harpy arms, harpy  tail, feather hair, human face, human skin, human or elven ears, vagina) automatically trigger this scene
    private function harpyBadEnd() : Void
    {
        outputText("As soon as you enter, you feel a sinister presence. You don't have to wait long to find out what it is as, within moments, something grabs hold of you. Looking around frantically for whatever beast has grabbed you, you finally manage to spot Minerva grinning at you. “<i>Well, well, another little harpy has found her way into my home, I hope you like it, 'cause you're gonna be here forever, little one, forever birthing my offspring and being fucked over and over by myself and my daughters.</i>“ the large corrupted siren croons with a sinister glint in her eyes, even as she rips your [armor] clean off your body. “<i>Hmm... odd...that junk looked familiar somehow.... oh well.</i>“\n"
                + "\n"
                + "You open your mouth to protest and tell Minerva who you are, but before you can get a single word out, her thick tentacle dicks rise and are thrusted against your body, her hips pumping and rubbing the hot throbbing shafts against your naked form. The small tentacles that sprout from her perverse members immediately react, squirming as if they had minds of their own and stinging your body over and over. Each sting injects a potent payload of corrupted aphrodisiac into your body, the powerful arousing cocktail quickly making short work of your resistance and making your body flush hotly with arousal. Between your legs, your pussy quickly becomes inflamed with desire, growing wet and slippery for your siren lover.\n"
                + "\n"
                + "Minerva grins and licks her lips with her long, demonic tongue, as if she can literally taste her victory. Seeing you’re too aroused to really fight back, she carries you deeper into her home, where she binds your wings and arms so you have no way of escaping. With your ability to fight and escape cut off, she begins savoring the latest addition to her harem. Her strong hands are running roughly over your body, hungrily inspecting every last inch of you, groping your breasts, hips and ass. The harpy loving mutant woman relishes every inch of your harpy-like curves, before she shoves you down against the stony ground, ready to begin your complete downfall.\n"
                + "\n"
                + "The large herm wastes little time lining up her twin dicks with your [vagina] and [asshole] before pushing in, Caring little for your comfort, she steadily works her thick lengths into your body's holes. Inch after inch feeding into you, the little tentacles stinging you over and over on the inside, flooding your bloodstream with more of her potent aphrodisiac and draining what little resistance you had left.\n"
                + "\n"
                + "It is then that she starts to rape your over-aroused body, taking you hard and fast, ramming her twin tentacled dicks into you brutally. The inhuman broodmother stuffing every fat inch into your poor overstretched body again and again, treating you like any other of the many harpies she had chained down in her tower. To her, they, and now you, are nothing but siren breeding machines, less than whores, living sex toys to be violated again and again for the pleasure of her and her daughters.\n"
                + "\n"
                + "The relentless violation doesn’t stop even as Minerva herself comes with explosive force inside you, filling your womb and bowels with highly corrupted addictive sperm. The drug-like substance quickly makes its way into your body, filling your mind with numbing softness that only further muddles your already-scattered, broken thoughts. The corrupted being, desiring to reinforce your relative positions, pulls you off her squirming cocks before yanking you up and onto your knees, forcing you to suck her off. Thankfully for you, she only made you take one of her twin dicks into your mouth, then your throat, feeding the full length of her massive shaft down into your body, before forcing you to pleasure her yet again. Minerva didn't stop until she had you eagerly sucking, pushing your mouth down again and again, your aching cum, hungry body thirsting for another huge load. The corrupted siren would not disappoint your needs, with her next orgasm she  came hard again, copious thick blasts of tainted cream flooding into your gullet and drenching your body in her addictive fluids.\n"
                + "\n"
                + "Minerva took great pleasure in breaking you, fucking you senseless over and over like her other harpies, keeping you full of corruption-rich cream and potent aphrodisiac venom for days on end. Being stuffed with the fluids and fucked so hard and good by such powerful pleasurable cocks wearing down your mind until you were a broken husk. There was nothing left of who you once were. All there was left when Minerva was done, was just another siren-cum-addicted baby factory for Minerva and her brood to violate and impregnate.\n"
                + "\n"
                + "Your body was chained with the other harpy slaves, force-fed cum and corrupted fruit as your only food sources, your body wracked with pleasure as you were mated with by sirens near constantly. The world mourned for you, your good deeds being slowly forgotten just as you had forgotten your old life, your life before the sirens. Now all you could think of is happily sucking, fucking and breeding for your corrupted masters.\n"
                + "\n"
                + "They almost never let you rest properly, if it wasn't Minerva herself raping your mind and body it was her daughters. The corrupted sirens grew up very quickly, reaching maturity in days. The young sirens took turns with you in pairs, one double stuffing you from behind, while a second would force one of her cocks down your throat and between your milk swollen tits. Like their mother, they take great pleasure in violating you over and over. Their violations only deepening your already severe dependence on their drugged cum and arousing aphrodisiac venom.\n"
                + "\n"
                + "No matter how much they fucked you, came in you and made you drink their sperm you could never get enough. Your body needed them,  always hungering for the cocks of your siren masters to be stuffing every hole you hand. Your broken, siren addicted mind couldn’t be happier with how things turned out, even as you are made to give birth for the rest of your life and swell the numbers of sirens that now seek to dominate the land.");
        player.sexReward("cum", "Vaginal");
        EventParser.gameOver();
    }
    
    //Okay, no options AFTER lethicite. So I'll leave it be in comments.
    /*
    //PC 5+ combat victory over Minerva
    //-fifth consecutive after combat victory text
    //-requires 1 lethicite fragment
    private function victoryAfterFiveWins():void {
    outputText("Once again the strong siren falls to her knees, the fierce broodmother brought to her knees by your power proving yourself to be her better. Looking up at you, you can see her eyes are filled with the same desires she always has when you prove yourself, lust, hunger, the compulsion to have to breed with her and make strong offspring together, her vivid eyes betraying the feelings that have been growing as you beat her each time. This time however there is something more. “<i>You’ve proven time and again that's your better than me, that your strongest, that you're the dominant one. I want you, your dominance, your ferocious power, I want ");
    //what about genderless?
    if (player.isMale()) outputText("your young, I want you to rut me, ride me and fill my womb with your seed over and over.");
    else if (player.isFemale()) outputText("to have you, I want to fuck you and plant my seed inside your belly again and again.");
    else if (player.isHerm()) outputText("all of you, I want to pin you down, fuck you till you scream and bless you with my young, i want to ride you, hold you down till you fill my womb with your virile sperm and give me your strong daughters.");
    outputText("</i>“ the siren’s demeanor changing, growing more frustrated.\n"
    + "\n"
    + "Growing she looks up at you. “<i>This isn't how it should be, my power, my fertility. no one can match me, I am the superior breeder, I’m supposed to be the best... But here you are, standing over me again. I want to be the strongest, the most potent breeder there is, but your power calls to me, your dominance lights such fire inside me. It should be me marking your body and claiming you with my seed, not like this...how are you so strong, what makes you so much better than I?</i>“\n"
    + "\n"
    + "With the corrupted siren like this, now is the perfect time to prove yourself her better, to show Minerva that you're the superior breeder, that you're the strongest and that she will never be as dominant as you. Looking down at her, you consider your options, remembering the lethicite you have in your possession, you could tempt the siren with greater power, a chance to best you and prove herself to be strongest, most powerful breeder, and by beating her down once again even with all that on the line, solidify your superiority over her.\n"
    + "\n"
    + "Considering you just dueled with the siren, you decide not to tell her you have some just yet.  Instead you tell her what such an artifact can do, the power it could give Minerva, that she could be the most potent and fertile breeder in all of Mareth.  The corrupted herm looking at you analytically, could your words be true, why would you tell her about such a thing that would empower her so. “<i>There is such a thing? This lethicite, you know where to get some, and you would be willing to find some for me? why?</i>“ she asks, slightly suspicious of your reasoning. Why give Minerva something that could tip the balance of superiority in her favor.\n"
    + "\n"
    + "Smiling you play the romantic, telling her that this is troubling her, that you just want ease her mind, that helping each other is what lovers do. Your sentiment brings her usual sharky grin, the siren rising from her position and slides her hands up your body. “<i>Well, since you're so eager for me to be the perfect, most potent and fertile breeder in all the land, how about we have some fun.  After all, you did win our duel, you proved your power, your ferocious dominant power.  You know how that gets me so hot for you, my snug snatch so slippery, my twin towering cocks so hard and ready.  My body still calls for you, lusts to mate with one strong enough to beat me.</i>“  She says, pressing her body against yours before kneeling down again, her hands slowly running along your body as she slips back into a more submissive, lusty posture.  Legs open, throbbing pillars of potent breeding flesh, huge virile balls so full of seed, her slippery silky snatch, tight soaking wet and begging for attention. So needy, so on display for you, she will have you, however you see fit to take her.");
    //Sex menu//
    }

    //Lethicite
    //available AFTER the previous function?
    //Tooltip: Loss will result in bad end, be ready to fight for your life
    //- bring up the offer of lethicite after 5 consecutive victories
    //- have at least 1 fragment of lethicite
    private function lethiciteConversation():void {
    clearOutput();
    outputText("Remembering your earlier conversation you tell the corrupted siren that you have been doing some research on this lethicite stuff, the power it could give her and how you, her mate, will help her get that power. Grinning ear to ear Minerva struts toward you, her flared fertile hips swaying back and forth enticingly as she strides toward you, her hands slipping around you as she presses her corrupted body against yours. “<i>Oh do tell, tell me all about the beautiful, powerful, avatar of fertility i will be.</i>“ she purrs to you, her tongue slowly licking your neck. The siren's excitement couldn't be more clear, what with how achingly hard she already is and from the slick juices running down her thighs..\n"
    + "\n"
    + "Snickering at her reaction you manage to push the horny corrupted herm away from you so you can tell her about your research and to your surprise Minerva is completely attentive, wanting to know everything she can about the lethicite and what it could do for her. You begin to tell her all about the </i>“effects</i>“ of the lethicite; that women of every kind would beg her to get a taste of  her twins pricks, pleading that she impose them upon her spires of fertility, pumping load after load of ultra virile siren-cream into them. Making their bellies swell with it and even begging for more after they are bloated and thoroughly impregnated.  Those that she leaves out would fight over the leftover spunk that spills from overfilled cunts, lapping up all the wasted seed that was not stuffed into a needy waiting womb.\n"
    + "\n"
    + "\n"
    + "Your tale continues, going on and on, telling Minerva of the future that was so close at hand for her, with your help of course. Your words only seem to make her more horny than before, clearly her mind filled with fantasies of all those that would serve her and all the pussies she would conquer, wombs she would plunder and impregnate. Your words flow over the siren like water over fertile soil, the needy herm sucking up every word. Going into great detail you tell her just how she would affect those around her; if she'd present them her body they would swarm, eagerly. They would please any important part of her precious body with their tongues, showering them with kisses, playing with those full jugs on her chest, toying with her nipples and begging for a sip from your delightful milk stored in them. Her horny harem would tend to her overfilled nuts, gently licking and worshiping the hyper fertile lifegiving balls, tenderly caress both of her bulging cumveins. Males and females alike would fight to be allowed some privacy with the tight dripping snatch between her legs, it’s a pity that all they might get is the allowance to plant their mouths on it. Tending to her clit, running around her swollen labia lick and kissing every inch of the most fertile pussy on whole Mareth, drinking in her herms over-sexual scent.\n"
    + "\n"
    + "As you go into great detail of the possible effects of using the lethicite you can see just how your words affect the siren; as she listens attentively you can see Minerva shift and squirm, twin pillars of fertility between her legs standing like a pair of totem poles with how hard they are, thick globs of musky pre dribbling down their lengths, the thick heady scent of Minerva’s feminine  juices mixing with the pheromone laden musk of her cocks.  The siren's hands slowly stroking the swollen spires, each one throbbing visibly with every beat of her powerful heart. “<i>Oooohhh oh yesssss... I want it! I want it so bad... The power, the fertility, to have them all beg on their knees for me to fuck them, to make every female and herm carry my beautiful siren daughters inside them.  Oh, fuck... think of it, the world filled with sirens, every unworthy male a servant, every strong male and herm made to impregnate my daughters, every pussy and womb filled by siren cocks and made to birth more of my daughters. I would be a goddess!</i>“ she siren broodmother says, her mind consumed with fantasies of power and visions of herself ruling over all as her and her daughters take over.\n"
    + "\n");
    if (player.cor < 60) outputText("While the fantasies Minerva entertains could be fun you know you have to temper her lust and dominant nature. If you challenge her now and take away her chance to gain that power, show her that only you are worthy of it and assert yourself and the one that is truly the dominant one, the superior breeder.  Through such action you could make Minerva serve you and your cause, help you overthrow the demons.");
    else outputText("While a world filled by strong sexy sirens and ruled by a veritable goddess of fertility, a world filled with sex and breeding sounds like a piece of heaven, you would rather take that fate for yourself, put yourself on that throne. If you challenge her now, take away her chance to gain that power and show her that only you are worthy of that power, that fertility and assert yourself forever as the dominant one, as the truly superior breeder. You could make Minerva serve you, help you get what you want and have her give you all the offspring you could both want.");
    outputText("\n"
    + "\n"
    + "Now is your chance, your chance to lay claim to Minerva once and for all, to make yourself her superior.  Reaching out you grab to throbbing bloated tip of one of her dicks to get attention, the action drawing gasp and long throaty moan from the corrupted siren. Her vivid eyes looking at you through the haze of lust, her hands slowing to a stop now that her attention is on you. “<i>Ooohh... I was so close, now why would you interrupt me like that?</i>“ she questions as you let go. Stepping back you reach into your bags and pull out the shimmering gemstone like lethicite from your bag, showing it off to the siren and telling her just what you're holding.\n"
    + "\n"
    + "Minerva’s lust clouded eyes look at the crystal for a moment before suddenly they clear as if suddenly sobered by the fact you had lethicite right there with you. “<i>Is that? That's it, isn't it? Thats lethicite. Ohh... I can feel its energy from here. You had it all along and yet you teased me, how mean.</i>“ she says playfully before rising from her seat, a predatory look in her eyes as she looks at the softly shimmering gemstone. “<i>Well lover, give it here, let me see it, after all you said you would give it to me right?</i>“ Minerva says as she reaches for the near fist sized crystal.\n"
    + "\n"
    + "Grinning you pull your hand back from her. “<i>ah ah ah... not so fast, I never said I would just give it to you.</i>“ You say, waving a finger at the surprised siren.  You had no intention of simply handing the lethicite over to Minerva, after all she made you fight her and prove your worthiness, why shouldn't she fight for this.  Drawing your [weapon] and smirk you make your challenge you state that you will give it to her if she beats you in one last fight for superiority, one last battle for the big prize, winner takes all.\n"
    + "\n"
    + "Despite never turning down a challenge the fact that you took the lethicite when it was so close to her brings sour look to Minerva’s face.  Running a hand through red black hair, Minerva lets out a growl. “<i>Now why did you go and do that, make me fight for it. Fine, I’ll enjoy this, I’ll take the lethicite from you by force if I really have to.  It will be mine, and then I will be a goddess, all will bow to me and beg to be taken by me.</i>“ the corrupted broodmother says as she takes hold of her halberd, readying herself for battle. Looking at her, you can tell by the serious look that she isn't going to play around this time, Minerva won't hold back, though with how aroused she is she may be more vulnerable to her lust.");
    }
    */
    
    private function nagaHugs() : Void
    {
        clearOutput();
        outputText("You ask if Minerva would like to embrace you for a moment.  She pouts and replies, with a disdainful glare  “<i>Are you so deprived of stimuli that you need simple physical contact from me? A better question:  ");
        if (camp.companionsCount() == 0)
        {
            outputText("Why haven’t you got a harem of your own?");
        }
        else
        {
            outputText("Don't you have a harem of your own?");
        }
        outputText(" You could hug them to your hearts content.</i>“  She lets out an annoyed sigh, “<i>very well, lover, if we must.</i>“  A smile spreads across your face as you get your long serpentine body ready to give the Siren the hugging of her lifetime.\n"
                + "\n"
                + "Her arms wrap around your shoulders as she leans against you.  She whispers, “<i>Are you happy now? Actually, I’m feeling kind of antsy, what do you say for some sex?</i>“  Proving her point, you feel one of her large tentacled cocks prod your thigh.  Ignoring her lustful advances, you lean into the embrace of the purple siren and press her lips hard against yours in a passionate kiss.  Now’s the time to strike!  Wrapping your arms around her, you gently lean back to lower yourself against the moss.  She breaks the kiss with a squawk of surprise, her feathery wings flap awkwardly while her legs kick in vain as the siren struggles against your embrace.\n"
                + "\n"
                + "The struggling ceases when you hug her hard, the redhead realising your fall was merely playful in nature.  You grin as you wrap your tail snugly around your siren lover, carefully avoiding damaging her wings as you coil around her body.  Soon enough, her form is soon constricted snugly inside your coils, her large breasts squashed against your own [breasts].\n"
                + "\n");
        if (kidsCount > 0)
        {
            if (kidsCount == 1)
            {
                outputText("Minerva calls you to take note of her daughter.  “<i>Perhaps you’d like to get our daughter involved? As a character building, family experience? It’s up to you though, frankly, I’d rather keep you all to myself.</i>“  Your gaze wanders around the spring, finally finding the siren lazily dozing in the pond’s black ooze.  Her ample bosom heaves with her chest as she takes slow deep breaths, the purple tips of her cock poking out of the bubbling pit, clearly showing the lust inducing effects of the spring.  “<i>She looks like she’s enjoying herself. You could call her over I suppose, but do you really want to disrupt her?</i>“  Minerva clucks, pressing herself hard against you so you can feel all of her erections against your stomach.");
            }
            else if (kidsCount < 4)
            {
                outputText("Minerva calls you to take note of her daughters.  “<i>Perhaps you’d like to get one of our daughters involved? It’s up to you though, frankly, I’d rather keep you all to myself.</i>“   Hearing sounds of slapping skin and pleasured gasps, you look over and find one of Minerva's harpy fuck-toys, bouncing on top of your slut of a daughter, both of them lost in pleasure.  A second siren cunt is watching the spectacle while perched in a tree, seemingly enjoying the sight of her sister’s cock being swallowed by the enslaved slut, rubbing her fingers against her dripping fuck-hole.  “<i>It looks like one of our daughters isn’t busy fucking. You could call her over I suppose, but do you really want to disrupt her concentration?</i>“  Minerva clucks, pressing herself hard against you so you can feel all of her erections against your stomach.");
            }
            else
            {
                outputText("Minerva calls you to take note of her daughters.  “<i>Perhaps you’d like to get one of our daughters involved? They seem to be having quite the little romp going on. It’s up to you though, frankly, I’d rather keep you all to myself.</i>“   Hearing sounds of slapping skin and pleasured gasps, you look over and find six, very happy looking faces.  Minerva’s daughters seemed to have devised a sex competition, between four of them, are two of their mother's harpy fuck-toys.  Each harpy is being double-teamed by the sirens, racing to see which team can make the harpy climax first. One team is fucking the poor harpy’s cunt and mouth, while the other is going at their feathered slut’s ass and pussy.  “<i>It looks like our daughters are already busy fucking. You could call one of them over I suppose, but do you really want to disrupt their clever little game?</i>“  Minerva clucks, pressing herself hard against you so you can feel all of her erections against your stomach.");
            }
            doYesNo(threesome, no3some);
        }
        else
        {
            doNext(no3some);
        }
        
        var threesome : Void->Void = function() : Void
        {
            clearOutput();
            if (kidsCount == 1)
            {
                outputText("Minerva calls out to her daughter, “<i>Come and have some fun, little one. We’ve got some fucking to do.</i>“  She merely opens one eye, barely taking notice of her mother's words.  Her indifferent expression quickly changes into a lustful grin as she takes notice of your intimate embrace.  Quickly rising out of the pool, you note her features.  She’s not exactly little, if you had to judge, she’s about six feet tall.  Her outward appearance is much like Minerva’s, a little smaller, but just as curvy.  However her skin has a much lighter tone than her mother's, being a nice blue.");
            }
            else if (kidsCount < 4)
            {
                outputText("Minerva calls out to her daughter, “<i>Come and have some fun, little one. We’ve got some fucking to do</i>“  She lazily gazes over to the two of you, still half-concentrating on the scene below, her slick fingers proof she was close to climax before she was interrupted.  Seeing that a better opportunity to get off has arisen, she jumps down from her perch and saunters over.  You note her features as she approaches.  She’s not exactly little, if you had to judge, she’s about six feet tall.  Her outward appearance is much like Minerva’s, a little smaller, but just as curvy.  However her skin has a much lighter tone than her mother's, being a nice blue.");
            }
            else
            {
                outputText("Minerva calls out to her daughter, “<i>Come and have some fun, little one. We’ve got some fucking to do.</i>“  “<i>But we’ll lose the game!</i>“  pouts the siren fucking one of the harpies’ face. “<i>Who cares if you lose, you’re still going to be fucking anyway, come and join the two of us. Your " + player.mf("Father", "Mother") + " here is a much better ride than those overused sluts could ever be!</i>“  Pausing the abuse of the poor harpy-slut’s face, she glances over to the two of you and the intimate embrace you have around her mother.  Quickly abandoning the competition, she rushes over to join, leaving her sister to fuck the harpy by herself.  As she jogs over, you note her features as she approaches.  She’s not exactly little, if you had to judge, she’s about six feet tall.  Her outward appearance is much like Minerva’s, a little smaller, but just as curvy.  However her skin has a much lighter tone than her mother's, being a nice blue.");
            }
            outputText("\n\n");
            sceneHunter.selectGender(male3some, fem3some);
            
            var male3some : Void->Void = function() : Void
            {
                outputText("You unwrap your tail from Minerva, releasing her from your tail hug, so your siren daughter can slide in between the two of you.  “<i>Wait a moment, dear. I have a better idea.</i>“  She motions for the younger siren to sit on your lap, her back resting against your chest.  Minerva mounts your tail, facing her daughter.  Her long tongue hangs out of her mouth as she lewdly licks her lips and presses herself against her daughter as you wrap the two of them in a scaly embrace.\n"
                        + "\n"
                        + "Minerva thrusts herself forward even more so that her two stiff cocks are pushing hard against her daughters pair.  The 4 sets of tentacles twist and grip around the cluster of corrupted cocks, squirming around each other as they begin to excrete their potent aphrodisiac drug-filled payload.  The younger siren croons with pleasure.  The sudden tentacle ministrations cause her to throw her head back in sheer bliss.  Pleased at her daughter’s display of slutty behaviour, Minerva leans forward, forcing the long tongue into her offsprings mouth and into a deep very unchaste kiss.\n"
                        + "\n"
                        + "Seemingly forgotten in the sirens greedy mutual masturbation, you decide to move things along.\n"
                        + "You push yourself forward a little, allowing your [cock] to slide in between your daughter’s sapphire-coloured bulbous buttocks, before reaching around and taking hold of her large melon-like breasts.  You start thrusting and watch your cock disappear into the blue gelatinous-like mounds.  Finding her nipples, you begin to tease and twist the blue nubs, eliciting a small moan from your spawn.\n"
                        + "\n"
                        + "Your precum-soaked [cock] starts to glide in and out of her cheeks with ease.  Feeling the slick cock sliding through her butt-cheeks, she breaks her mothers kiss and gives her a nod.  Grinning, Minerva declares, “<i>Well then, now that we are all properly ready, I think it’s time we started</i>“.  Placing your hands on the hips of your selfish daughter, you gently ease her blue labia over the tip if your [cock], before slowly guiding it in.  The cilia lining her walls spring into action, massaging your [cock] as it penetrates the refreshingly cool, tight hole.\n"
                        + "\n"
                        + "Hilting yourself inside her snug snatch, you pause your lunge to relish the feeling of the inuman cunt, its walls a much tighter fit than Minerva which can be said to be arguably better.  Your [cock] throbs filling with more blood than you thought possible as it reaches a new length.  It seems the cilia have an aphrodisiac cargo just like her dicks and are very eager to envenom their mate!  You push your chemically enhanced cock into her pussy, driving it hard as fast just how they love it, and wait for your siren partners to make their moves.\n"
                        + "\n"
                        + "Your daughter pushes back against you, partly so that she can present her two peni for penetrating her mother and partly because she’s lost in the pleasure that is filling her.  Minerva lines herself up with the twin blue tipped cocks, her cunt already dripping with salty fem-juices.  She lowers her shark-like form, penetrating her wet vagina and tight ass with her daughters thick erections, a long moan escaping from the blue sirens lips.  Grinning, your violet siren lover forces herself down further, the double dongs filling Minerva’s tight squeezing depths.  Your cerulean daughter shudders from the sudden consumption of her members, the triple sense of fucking too much for her, her face clearly showing her utter delight at the incestious union, her eyes rolling up, toes curling and tongue rolling out as she breathes a deep throaty moan.\n"
                        + "\n"
                        + "Minerva continues plunging her daughters huge twin cocks into her holes, her two red cocks displaying the obvious pleasure she is feeling.  You start alternating thrusts with the busty mother while your mindfucked daughter mindlessly bucks her hips, her body lost to sheer thrill.  “<i>Lover</i>“ Minerva drones.  “<i>My dicks aren’t getting any attention.  Why don't you give me some extra love?</i>“  Complying, Minerva happily licks her lips as you twist the tip of your tail around her envenomous red cocks, the tentacles that ring the base and tip, binding the two together separate and begin fondling your tail-tip, stinging the special toxic substance into your scales, causing you to shiver in pleasure.\n"
                        + "\n"
                        + "The over-fucked siren trembles with her second orgasm.  Cum erupts from her two members, filling Minerva’s needy holes with her distended balls, stuffing both her mothers holes with thick incestious sperm, while her cunt spasms around your [cock], blissfully milking you until you release your own pent-up seed into her.  Noting Minerva hasn’t had her own yet, you carefully coil the very tip of your tail up to one of the large purple heads and tenderly prod it into the unsuspecting siren’s urethra.  Almost immediately, a wave of her blighted batter bursts from her nobs, shooting up and then all over the three of you.  Minerva’s twitching pussy causes her daughter to climax again, jamming more jism into her full womb and filling her ass with her significant virility, her gut slight paunched from the considerable amount of semen that was just injected into her.\n"
                        + "\n"
                        + "The three of you lay there in your own love for a moment, not bothering to move until your orgasm induced high fades.  You start to slowly loosen your sperm drenched coils to free the two sharpy’s, exhausted by their lust for sex.  Your daughter seems to have passed out, exhaustion taking her into a deep slumber.  Minerva takes you by the hand and slowly leads you away from blue siren, leaving her to rest and taking you to another private spot in the spring.  Minerva looks at you with heavy lidded eyes, still intensely aroused, even after that draining session.  “<i>That was lovely, [name],“  she saunters, “<i>  I can see that you’re still aroused, judging by the look of your nethers.  Perhaps you’d be interested in another, more involving, position?  Or perhaps there was something else?</i>“");
                player.sexReward("vaginalFluids", "Dick");
                cheatTime(1);
                corruptMenu();
            }
            
            var fem3some : Void->Void = function() : Void
            {
                outputText("You unwrap your tail from Minerva, releasing her from your tail hug, so your siren daughter can slide in between the two of you.  “<i>Wait a moment, love. I have a better idea.</i>“  She motions the younger siren to lie face down against your laying form, but instead of being face to face, her red thighs laying to the sides of your head with her two erections poking at your face.  Minerva returns to her position next to you and you coil your tail once more, this time you wrap the two of them in a scaly embrace. Your corrupted lover’s body being pulled next to yours, joining the view of your spawn’s fuck bits.\n"
                        + "\n"
                        + "The blue sirens blue-tipped cocks dangle in front of you, the tentacles that line them writhe in excitement from the impending pleasure.  Gently, you take one of the sapphire-coloured tips into your mouth and begin to softly suckle the head, the tentacles that crown it begin working to fill you with  their aphrodisiac payloads, filling your lips with a tingling warmth that makes you giggle, as you begin to swallow more of you younger sirens’ members into your wanting maw.\n"
                        + "\n"
                        + "Taking your initiative as a sign to begin, your two siren partners begin their ministrations.  Minerva begins working her long tongue, moving the undulating appendage past her daughters cunt and wrapping around her bulbous cum bloated sack and remaining achingly hard penis, while your daughter begins moistening your [cunt] with her own demon tongue, readying your snatch for Minerva’s enormous members and teasing your [clit] to make every lick electrifying as your sensitivity builds.\n"
                        + "\n"
                        + "“<i>Stop that and start sucking, your mama’s dicks are painfully hard! Use that sweet little mouth of yours and make them feel better.</i>“  Minerva croons.  The youthful siren obediently stops her licking and begins sucking on one of Minerva’s corrupted cocks, the tendrils mimicking the venomous injections of lust that her daughter is doing to your face.  Minerva smirking and remarking on how good her little slut’s mouth feels on her cock, giving her encouraging names like “<i>Mommy’s little cock sucker</i>“ before finally thrusting forward, Minerva spears her other pussy packing cum cannon into your eager cunt, the tentacles that line it stinging your sensitive walls, flooding your body with the potent lust-drug causing you to purr happily, giving the shaft down your throat a vibrating blowjob, your mind and willpower numbed by the toxins rushing through your blood.\n"
                        + "\n"
                        + "Matching the blighted siren’s thrusts, you feel yourself hilt on Minerva’s sizeable cock, your poor lusty cunt stuffed full of corrupted siren meat.  “<i>Now that you’re full on one side lover, it’s time to fill the other,</i>“ she gasps, before driving herself forward, filling the throat of your poor siren daughter resting beneath her and forcing your daughter to fill your own gurgling mouth with more of her tender erection, causing it to release a delightful rush of pre to flow down your throat, into your waiting belly.\n"
                        + "\n"
                        + "The two of you upon sensing the azure sirens imminent orgasm, both of you double your efforts on the poor girl, you're sucking hard while twirling as much of your tongue around her throbbing meat without swallowing, working with you Minerva retracts her tongue from the sapphire cock and plunges it deep into her daughter's dripping hungry cunt instead, causing the young siren to shudder in delight and suck down more her mother’s violet cock into her mouth, much to Minerva’s satisfaction, releasing her own burst of syrupy pre into your thirsty hole and her daughters gagging gullet.\n"
                        + "\n"
                        + "Your drug-hazed mind clears for a brief moment, but not before Minerva spears the entirer pussy packing lenght into your body, the painfully thick dick stretching your poor snatch tightly around her.  The abrupt pause allowing to line up the tip of your snake tail with Minerva’s unused drooling fuck-hole, your tail coiling and twisting into her unsuspecting vagina and stuffing her with your thick coils, making her spill more of the clear gooey fluid out of her engorged dick-tips.  Your two siren lover’s cool rods throb against your warm insides, the cock-tentacles groping your inner-flesh with electric passion as they squirm and sting you.\n"
                        + "\n"
                        + "The two sirens match paces and the soon air is filled with arousing, wet, slurping sounds as the blue siren’s, as well as your own, throat, is fucked with deep punishing thrusts.  Minerva’s daughter reaches her climactic end first, her hungry slippery cunt contracting against her mother’s perversely prehensile tongue, feeling her cock expand in your throat as it prepares to release its seed.  You arrive second, your walls spasming around Minerva’s violet cock, milking it for its juicy payload, while your tail thrashes and writhes in Minerva’s own snatch, clamping down on it as she too finishes.  Thick corrupted cream erupts from both their cock’s at the same time, the fat cumveins that feel their dicks bulging tightly as their dence pasty payload is unleashed, filling the siren’s daughters throat with thick sweet-salty jism and drenching your face as your throat and pussy receives its reward.  Your hungry mouth gulping down each cheek bulging gush of heavy cream your daughter’s fat babymaker blows deep into your needy gullet, all the while your ready womb eagerly swallows up Minervas belly busting flood of heavy sperm packed spooge.\n"
                        + "\n"
                        + "The three of you lay there in your own love for a moment, not bothering to move until your orgasm induced high fades.  You start to slowly loosen your sperm drenched coils to free the two sharpy’s, exhausted by their lust for sex.  Your daughters voices her pleasure, before the weary girl wanders off.  Minerva looks at you with heavy lidded eyes, still intensely aroused, even after that draining session.  “<i>That was lovely, [name],</i>“  she saunters, “<i>  I can see that you’re still aroused, judging by the look of your nethers.  Perhaps you’d be interested in another, more involving, position?  Or perhaps there was something else?</i>“");
                player.sexReward("cum", "Lips");
                cheatTime(1);
                corruptMenu();
            }
        }
        
        var no3some : Void->Void = function() : Void
        {
            clearOutput();
            outputText("You feel a slight pressure against your belly, telling you that Minerva is definitely enjoying the tight closeness between you.  Or it could be just the fact that she’s constantly full of lust, and that her two throbbing erections are just normal.  The venomous tentacles sliding over your scales, injecting you with her potent aphrodisiac.\n"
                    + "\n"
                    + "Oh, no! If she keeps this up, the two of you are going to be glomping in a puddle of increasing lust.  You can already feel the effects of her tingling lust poison.");
            if (player.cockTotal() > 1)
            {
                outputText(" Your dicks begin to fill their lengths, your tips threatening to breach the protective slit that encases your genitals.");
            }
            else if (player.hasCock())
            {
                outputText(" Your dick begins to fill its lengths, your tip threatening to breach the protective slit that encases your genitals.");
            }
            if (player.hasVagina())
            {
                outputText(" You feel your nether lips begin to moisten, slowly coating your natural protective gential slit with feminine juices.");
            }
            if (player.isHerm())
            {
                outputText("\n\nThere doesn’t seem to be a way out of this situation without a sexual act.  You have bits of both genders, what would you like to do?\n"
                        + "You could jerk her off and penetrate her with your tail?\n"
                        + "Or perhaps you could let her penetrate you?");
                menu();
                addButton(0, "Use Tail", useTail);
                addButton(1, "GetPenetr.", getPenetrated);
            }
            else if (player.hasCock())
            {
                useTail();
            }
            else
            {
                getPenetrated();
            }
            
            //=========================================
            function useTail() : Void
            {
                outputText("\n\nUnwrapping the end of your tail from the squeezing, scaly tail glomp that you are giving Minerva, you slowly start loosening your snake-like coils, allowing a lot more room for movement, while still containing the shark-harpy in your loving, snakery grasp.  Knowing that she won’t let you penetrate her with your penis without proving your worth in a fight, you’ll just have to provide the violet Siren with some alternate release, and since she can’t be knocked up by your tail, you figure that your dick-substitute will be satisfactory.\n"
                        + "\n"
                        + "Slowly, you begin sliding the undulating appendage through the wrapping, spreading her legs as it works its way to your intended target.  When it reaches the wet slit of her nethers, your carefully prod it, trying to coax your corrupted lover into accepting your pseudo-tentacle cock. Suddenly, you feel a slight tension building around your tail, the Sirens thighs giving it a crushing grip of their own.  “<i>Nice trick, lover, but no. I have a better idea.  You can penetrate me with that tail of yours on one condition; you gotta jerk me off with it first.</i>“\n"
                        + "\n"
                        + "You nod, her offer sounds reasonable, besides, she’s still firmly inside your coiling embrace. You continue sliding your tail forward, teasing the sirens female parts before moving on to her male parts.  You twist your tail-tip with impressive hand-like dexterity, moving your tail like a corkscrew around her overly-large endowments, the copious amount of pre-cum leaking from them providing just enough lubrication for the Siren to feel each of your smooth scales slide up and down her throbbing erections as you wrap them in a pleasure grip, her pulsing tentacles engorging with blood, wrapping & squeezing themselves around each of her dicks as well as filling your own body with the lust increasing poison, your [cockplural] expanding to their full length"
                        + ((player.cockTotal() > 1) ? "s" : "")
                        + " and pulsing with every beat of your heart.");
                if (player.hasVagina())
                {
                    outputText(" Your female parts follow suit, your protective slit opening to reveal your drooling [vagina].");
                }
                outputText("\n"
                        + "\n"
                        + "Your slick tail-job comes to an end when your coils and both of your torsos become drenched in sticky white herm cum.  “<i>Well, well, you managed to get me off.  I think you’ve earned the right to fuck me silly now.</i>“  She says, quickly composing herself.  You retract your sperm covered appendage from around her cocks and slide it down to her horny cunt.  Finding her snatch slick with need, you gently push your cum lubed tail against it, the end slowly penetrating her vag with surprising ease.\n"
                        + "\n"
                        + "Her refreshingly cool cunt seemingly invites the thick penetration of your scaly tail, the wriggling tentacle-like receptacles tickling your scales as you thrust further into her depths.  A moan escapes from the Sharpy’s jaws and she attempts to push her hips back against your tail-cock, eager for more cunt-busting thickness.\n"
                        + "\n"
                        + "The movements ultimately fail however, the rest of your body is still pinning her against you.  “<i>Oh, don’t stop there!</i>“  she gasps as her struggles to penetrate herself on your thick tail continue, her slick body making lewd squelches from the friction against yours.  Complying, you push yourself as deep as you can, until the sheer width of your tail has stretched her cunt to its maximum size.\n"
                        + "\n"
                        + "Almost an entire foot of your snake-tail is now buried inside her stretched hole, your sensitive false-member being milked like a penis, the walls of her snatch contracting around it, the flesh still being caressed by the little feelers.  You begin to twist your flexible appendage, pulling it out partway and then lunging back into the pleasure addicted Siren, bringing lyrical moans from her pouty black lips\n"
                        + "\n"
                        + "Even while bound within your tight confining coils, Minerva doesn't just lay there as you tail fuck her.  The numerous long stinging tentacles that line the bases of her twin dicks writhe and wrap around your own hard [cocks].  The surprisingly dexterous tendrils caress and tighten around your sensitive maleness, working to jerk you off, even as they sting you full of her aphrodisiac venom.  “<i>Ahhh... how does that feel lover?  Never can get enough of my venom can you?</i>“  The corrupted siren says, as she gives you a special tentacle job\n"
                        + "\n"
                        + "You feel your [cocks] strain against your body, the aphrodisiac engorged member/members bloating in size. ");
                if (player.hasVagina())
                {
                    outputText("Your [vagina] puffs up from the lust drug being pumped into your body, your [clit] swelling to its full length. ");
                }
                outputText("Minerva’s own two dicks follow in suit, expanding past their natural lengths, even though she just came a few moments ago.  The sirens increased arousal seems to pump the cilia lining her fuckhole into overtime, massaging your sensitive tail with a new vigor, squeezing your scaly appendage, unaware that no seed will spill from it.\n"
                        + "\n"
                        + "A wave of pre escapes your [cocks]");
                if (player.hasVagina())
                {
                    outputText(" and your cunt follows suit");
                }
                outputText(". The tentacles continue their unrelenting stroking, much like the kneading of Minerva’s erections with your tail.  The poison, still being pumped into you is unwittingly bringing you to your climax, your bloated [cockplural] finally releasing your pent-up jism, your warm sticky cum sprays across your [breasts].  ");
                if (player.hasVagina())
                {
                    outputText("Your vagina begins spasming, your femsex trying to milk something that isn’t there, as your electrifying orgasm continues.  ");
                }
                outputText("Your tail spasms inside the sharpy as you cum, leading to her own climax.  Her slick-hole locks your tail inside, gripping it hard while her own two endowments join your in ecstasy, spraying another large load over the both of you, even if this is her second release,  you two still get soaked in twin sprays of her thick sticky fertility.");
                player.sexReward("vaginalFluids", "Default");
                player.sexReward("no", "Dick");
                sharedEnd();
            };
            var getPenetrated : Void->Void = function() : Void
            {
                outputText("Unwrapping the end of your tail from the squeezing, scaly tail glomp you’re giving Minerva, you slowly start loosening your snake-like coils, allowing a lot more room for movement, while still containing the shark-harpy in your loving, snakery grasp.  Knowing that she’s not going to be satisfied until she’s pumped you full of sperm, you’ll just have to provide the violet Siren with the release she desires, though perhaps you can get some payback by stuffing her own cunt with your tail at the same time.\n"
                        + "\n"
                        + "You voice your intention to let her penetrate you.  Smiling, the sharpy presses her lips against your neck, and slides her demonic tongue down to your bust.  ");
                if (player.isPregnant())
                {
                    outputText("“<i>It’s a shame you’re already pregnant.  I’ll still fuck you right now, but make sure you come back later so I can stuff you full of siren babies.“<i>");
                }
                else
                {
                    outputText("“<i>Excellent, let’s see if this batch of batter will knock you up with some lovely little siren sluts.</i>“");
                }
                outputText("Slowly, you begin sliding your undulating appendage through the wrapping, spreading her legs as it works its way to your intended target.  When it reaches the wet slit of her nethers, your carefully prod it, trying to coax your corrupted lover into accepting your pseudo-tentacle cock. Suddenly, you feel a slight tension building around your tail, the Sirens thighs giving it a crushing grip of their own.  “<i>Nice trick lover, but no.  I have a better idea.  You can penetrate me with that tail of yours on one condition; you let me fuck you first.</i>“\n"
                        + "\n"
                        + "You nod, her offer sounds reasonable, but you know that once she starts fucking you, she won't mind you thrusting your snake-tip into her folds.  You twist your coils to line up your [vagina] with one of her large thick dicks.  She thrusts forwards and slowly sink into you. The lack of any foreplay is countered by the aphrodisiac filled tentacles that begin stinging you, quickly filling you with the desire to be stuffed by Minerva’s dick and pumped to brim with her vile siren seed.\n"
                        + "\n"
                        + "A pleasurable grunt from your lover shakes you out of the poison-induced daze and you realise that the purple sharpy has already hilted her throbbing erection into your [cunt].  Deducing that its probably her corrupted aphrodisiac to blame for the brief loss of time, you decide that now would be a great time to take your tail and wedge it between the corrupted slut’s violet lipped labia.  You slither the tip of your tail  around her wet thighs and lead it up to her dripping cunt.  You teasingly poke and prod her there, your rough scales gliding against the shiny smooth pussy hiding behind her corrupted red sack.  Her natural lube drenching the usually dry tail tip.\n"
                        + "\n"
                        + "Minerva coos as you continue to tease her female bit, the sexual tension being built there is released though her cock as she continues to move her cock in your wet snake slit.  Pushing forward, your tail easily slides into her soaked snatch, the cilia lining her inner walls already massaging your flexible appendage as you penetrate her deeper and deeper.  Indulging both her sexes in their lustful needs with your snake wrap of love.\n"
                        + "\n"
                        + "She tries to further impale herself on your tail-cock, having trouble however, keeping her anemone cock buried in your warmth in the process.  It’s twin’s stinging tentacles are stretched in all directions across your underbelly and filling you with more fuck crazy drugs, throbbing in desire as it’s brother gets all the attention.  You feel bad for the “<i>little</i>“ guy and tell your lover that her other cock could use some attention too, she’s all too happy to oblige your request.  The shark-harpy does her best to maneuver the second cock next to the one hiding in your snake hole, but your tight coils make it slightly challenging.\n"
                        + "\n"
                        + "You feel her guiding the other cock around your cunt, it’s hardness poking into your soft underbelly until it finally finds your stuffed fuck-hole.  It takes a bit of stretching from your [cunt] and squeezing from her purple cocks but soon your cunt is contracting around both of them, rubbing them against one another, both of sets of the tentacles inside you working together to grope your walls, while the feelers around the base of her duo of cocks ");
                if (player.hasCock())
                {
                    outputText("wrapped around the base of your [cocks], your length" + ((player.cockTotal() > 1) ? "s" : "") + " slowly filling");
                }
                else
                {
                    outputText("are nicely secured against your snake flesh");
                }
                outputText(". Your entire body becoming a burning sensation of sensitivity and easy pleasure.\n"
                        + "\n"
                        + "Your cunt is making more than enough drug fueled fuck juice to accommodate Min’s freaky cocks ");
                if (player.hasCock())
                {
                    outputText(" and your throbbing [cockplural] drool bubbling pre from the tip.  Your erection larger than normal due to the effects of the drug");
                }
                outputText(".  Both of them slickly plunging into your depths and stretching your cunt wider than it should, but you don’t care, the twins cocks feel absolutely divine!  You feel the purple slut’s cunt tightening on your sensitive tail, reminding you that you have a part to play in this fucking embrace.\n"
                        + "\n"
                        + "You wiggle your tail inside her, your tough scales grinding against each of the smooth crevices of her snatch.  The siren, almost moaning musically in time with each of your thrusts.  You push more of your fuck tail into her ravaged sex, ramming hard until you bottom out, a whole foot of your tail buried inside.  If only your tail was thinner, perhaps you’d be able to stuff even more into her wanting cunt.  Even as her cunt is stretched as wide as it can around you, the corrupted Sharpy’s lust demands more.  She begs you to continue “<i>Come on lover!  Give me MOOOOOOORE!!!!</i>“  she sings in ecstasy, as she pistons her hips like a sex starved demon. Her twins thrusting into you, feeling them throb and pulse against each other, stretching your cunt wider as they gain extra length from the natural leaking aphrodisiac.  Your cunt squeezes back against the expanding invaders, forcing them together, but their enlarging sizes continue to push against your contractions.  The feeling of being doubly penetrated is finally too much, as your cunt begins spasming around Minerva, milking her for cum you’ve been longing for.\n"
                        + "\n"
                        + "You turn and twist your tail, causing Minerva's smooth cunt walls to crease as she buck her hips and her body shakes.  She must be coming up on her triple orgasm!  You can already feel light streams of pre being shot into your [cunt].  She makes a long moan, that sounds like the slut is holding a high note that echoes across the mountain, as she drenches your tail with her girl-cum while shooting twin jets of cum from her cocks deep into your overstretched cunt.");
                if (player.hasCock())
                {
                    outputText(" Your [cocks] joins in, lazily spraying their own cum across your torso, due to the lack of any proper stimuli.");
                }
                player.sexReward("cum", "Vaginal");
                if (player.hasCock())
                {
                    player.sexReward("no", "Dick");
                }
                sharedEnd();
            }
            var sharedEnd : Void->Void = function() : Void
            {
                outputText("The two of you lay there in your own love for a moment, and you don’t bother to move until your orgasm induced high fades.  You start to slowly loosen your snake appendage to free the sharpy, exhausted from Minerva’s lust for sex.  She voices her pleasure, she looks at you with heavy lidded eyes, still intensely aroused, even after that quick romp.  “<i>That was lovely, [name],</i>“ she saunters, “<i> I can see that you’re still aroused, judging by the look of your nethers.  Perhaps you’d be interested in another, more involving, position?  Or perhaps there was something else?</i>“");
                cheatTime(1);
                corruptMenu();
            }
        }
    }
    
    //3-1= talking scene 1 - talks about back story pt1 to pt3
    //-repeteable
    //Scenes occur in order. starting with part 1 and reset after part 4 is told. talking is still somewhat random but backstory scenes will trigger in order.
    private function corruptTalkBackstory() : Void
    {
        clearOutput();
        //PART 1
        if (flags[kFLAGS.MINERVA_BACKSTORY] == 0)
        {
            flags[kFLAGS.MINERVA_BACKSTORY] = 1;
            outputText("Telling Minerva that you want to sit down and talk with her merely draws a bored sigh from her. “<i>Talking? Really? Why do that when you could indulge in far more pleasurable pastimes</i>“ She says as she draws a finger across your cheek, her twin tentacled members rising at the implication of her words. Seeing that you won't be tempted this time, Minerva sighs and sits down on the soft moss before gesturing to you. “<i>Well, tell me then; what do you want to know?</i>“ Sitting across from her, you ask about her past, how did she come to find be like she is and find this place.\n"
                    + "\n"
                    + "Upon asking about Minerva’s past she sighs and rolls her eyes.“<i>Geez, that stuff? How boring. Looking back at it, I shouldn't have fought back and just let the demons take me. Oh, the pleasures I could have had. Though, I probably would be the gorgeous sexy woman I am today... I mean, look at me; you couldn't get any more perfect.</i>“ The siren proclaims with a grin before looking you up and down wistfully, clearly thinking of other things. “<i>Well, fine...I guess I should start at how I got here. I guess I'm like you, came from the other side of one of those portals. I suppose I was a sacrifice of some kind since there was an ambush waiting for me on the other side. It was very close, but I managed to get away, but not without getting hurt.</i>“ She says, gesturing to the long scar on her stomach. Thinking of that scar and how large it was you wondered how she survived it's a wound like that. “<i>That little devil buried its way into me and sealed itself up inside my belly. I was horrified at the time, but thanks to it, I eventually became this fertile, virile vision of perfection.</i>“ Grinning ear to ear the corrupted siren reaches down and starts to stroke her already-rock-hard shafts. The parasite may have been what started it, but it’s all thanks to your intervention that made this transformation a reality.\n"
                    + "\n"
                    + "Licking her lips Minerva continues; the masturbation seems to be spurring her on. You yourself went through a very similar entry into this world, though you so far haven’t turned into something like the well-endowed siren. “<i>Of course, those tasty demons chased me all the way to the lake... mmmm, if I saw them again, I’d show them just how much I appreciate their attempt to enslave me... I’d show them how to do it right...</i>“ She notes with sadistic glee, her strokes quickening, clearly thinking of how she would reduce the demons into cum addicted sluts for her own harem. “<i>Sometimes I wonder how things would have turned out had the demons not attacked me. Where would I have ended up, if I wasn't in such a hurry to get to safety... I probably would have been grabbed up by some beast and used as a sex slave. That may have been fun...I think I like this better; now I have a harem of harpies to fuck, ");
            if (kidsCount == 1)
            {
                outputText("I have a daughter to serve me in every way I demand, ");
            }
            else if (kidsCount > 1)
            {
                outputText("I have daughters to serve me in every way I demand, ");
            }
            outputText("and I even have you, my dear ‘champion’.</i>“ She says before laughing at how funny it was; you made her into a corrupt, horny monster and you’re supposed to be the champion.\n"
                    + "\n"
                    + "The siren lets out a groan as she continues masturbating to her memories and fantasies, perhaps even imagining what things would have been like if they were different. After a minute Minerva continues her story. “<i>Since the demons stayed away from the lake, I obviously stayed there for a while, at least a few days, catching fish in the lake to live. Fortunately, the lake was not safe either; full of those simple-minded anemones and savage shark girls. I had many delicious encounters with those sharky sluts.</i>“ Minerva looks down at her mostly shark-like body, one of her hands sliding up her shark-skinned belly to grope one of her breasts. “<i>I'm supposed to be female, but one of those anemones got to me... their tentacles aren't nearly as potent as my own, but it was still effective, and it just kept stinging. I couldn't fight back for long before it started to have sex with me, and I'll admit that at the time I enjoyed it. With all that aphrodisiac in me, I was having the time of my life. I should fly down there, catch one of them and give them a taste of their own medicine</i>“\n"
                    + "\n"
                    + "Minerva shudders and groans, her twin cocks pulsing as they unleash simultaneous gouts of thick, pure white jizz, the copious streams splattering across the floor, nearly hitting you. A number of thick cum lances even land on Minerva herself; she keeps on cumming her usual massive load until the ground is sticky and her chest and face are drenched in her corrupted seed. “<i>Mmmm.... that was fun. Such delicious memories. How about you head off back to... wherever it is you stay? I have to clean myself of all this tasty tainted cream.</i>“ Seeing as she is going to be busy you say goodbye to the dangerous corrupted siren before heading back to camp.");
            doNext(camp.returnToCampUseOneHour);
        }
        //PART 2
        else if (flags[kFLAGS.MINERVA_BACKSTORY] == 1)
        {
            flags[kFLAGS.MINERVA_BACKSTORY] = 2;
            outputText("Telling Minerva that you want to sit down and talk with her merely draws a bored sigh from her. “<i>Talking? Really? Why do that when you could indulge in far more pleasurable pastimes</i>“ She says as she draws a finger across your cheek, her twin tentacled members rising at the implication of her words. Seeing that you won't be tempted this time, Minerva sighs and sits down on the soft moss before gesturing to you. “<i>Well, tell me then; what do you want to know?</i>“ Sitting across from her, you ask about her past, how did she come to find be like she is and find this place.\n"
                    + "\n"
                    + "Upon asking if Minerva could continue her tale she sighs and rolls her eyes .<i>“That again? well, I suppose it won't be so bad, I was getting to the good part. “</i> the corrupted siren says with a horny grin, her twin dicks already starting to rise.\n"
                    + "\n"
                    + "“<i>Alright so after the fun time with that cute anemone and getting my tasty tentacled cock from the resulting birth I fled from the lake; at the time I didn't want to run into any more of the creatures there so I tried to survive more inland.</i>“ She chuckles and once again looks down at herself before reaching down and cupping her huge swollen balls. “<i>It worked out wonderfully as you can tell. Well I found this farm and it seemed alright but I didn’t want to take any chances, and I was really, really hungry at the time so I just stole some of the peppers that the woman grew there, these bulbous ones, they smelled so good so I scarfed them down like a hungry animal.</i>“ Minerva moans and gave her balls a squeeze, making her shiver and bite her lip. “<i>Silly things, I had no idea at the time they would make me grow big virile balls, and since I ate so many they got really big, though not like these fat monsters.</i>“ she said squirming a little, her cocks at full hardness as she groped her sperm filled nuts and started to stroke her dicks once again\n"
                    + "\n"
                    + "“<i>Mmmm....anyway... since the food inland seemed, at the time, to be a worse option than staying around the lake, I mean I didn't want to turn into some giant-balled freak, though looking at me now, a fucking sexy huge balled broodmother, mmmm...</i>“ She said as she started to speed up her strokes, thick precum started to ooze down her cocks. “<i>Don't you think so?</i>“ Minerva asks with a wink and grin before continuing her story. “<i>So I headed back to the lake, which was the best choice I made, but at the time it was for the food. A few days passed without any incidents until that is I swam into some of the shark-girls that inhabit the lake, they reaaally took a liking to my new male equipment.</i>“ Minerva says proudly, extending her two-foot-long tongue and licking the fat head of one of her dicks in emphasis.</i>“ They were stronger than I was at the time, fast and fierce; they forced themselves onto me over and over. Using me for their pleasure and making me impregnate them with those fat balls I grew and the cock I had birthed.</i>“ The siren shivered at the memories of sexual violation by the shark-girls, clearly reveling in her newest sexual fantasy.\n"
                    + "\n"
                    + " “<i>I think they really took a liking to me, since they force-fed me these soft things that looked like teeth but they changed me. You remember how I used to look, my skin got all grey and blue, I grew a tail like them and even grew a fin on my back, but that's gone now. Turned me into something like a tiger-shark, which actually made things worse for me at the time; there are others in that lake, these more aggressive striped shark-girls with big dicks and balls.</i>“ She bit licked her lips and squeezed her balls, drawing a long groan “<i>Sometimes I fantasize about if that tigershark had made me a part of her harem. mmm I should find that shark and show her what she missed out on before fucking her into a mind broken cum whore.</i>“\n"
                    + "\n"
                    + "“<i>Yessss...that tigershark, there was this one that didn't like the fact I was around and had knocked up those sharks, I guess it thought I was trying to wedge in on its harem, and really, really didn't like it. those horny sharks, after the harpys I’m going after the shark-girls and take them all for my harem.... So anyway, it, she foolishly decided she was going to add me to her harem, as you can see it didn't turn out like that. I was tired from the other sharks and this one was much more aggressive. She grabbed me and this time I was on the receiving end. The tigershark was so rough. I guess she wanted to teach me a lesson as she raped me as hard as she could before dumping this insane load of sperm into me... mmmmm... so much hot cream.</i>“ Minerva groans lustfully as she leans back and pumps her twin tentacle cocks harder and faster. “<i>So much that my stomach got all big like I was already pregnant...but I know that now I would blow a load that would drown that slutty shark.</i>“ Minerva said proudly, before she lets out a loud long slutty moan. her two foot tongue lolling out as her twin dicks throb and bulge as twin torrents of steaming jizz burst from her body. the thick tainted cream splattering across the floor and her body, painting her body white with her own potent fertility. It's clear to you that her balls can really churn out the sperm.\n"
                    + "\n"
                    + "“<i>Aaahhh... mmmmmm... well with it enjoying its orgasm I struggled and managed to get away. </i>“ she says before her tongue starts licking up her cum. “<i>So tasty....So in the fight, it dropped one of those ‘teeth’ the other sharks had used on me, but this one was glowing. I grabbed the thing and swam and swam until I reached the shore. I ran into the forest and just... I felt like giving up at the time. The world had been trying to kill me or rape me since I got here hehe..... I took that tooth and ate it, getting these lovely sexy stripes of mine</i>“ The siren said as she smiled and put a hand to her belly. “<i>It turns out that I had in fact gotten pregnant from that tigershark and I decided to keep going strong. I didn't have to wait very long though, about 12 days after she came in me, I was so swollen with a baby I gave birth. I gave birth to a beautiful adorable baby shark-girl.</i>“ She said with a smile as she strokes her tummy. for the moment reveling in the maternal memories before she grins devilishly, remembering something else about her daughter. “<i>That little slut...hehehe she grew up so quickly, and when she was fully grown, damn was she a good fuck...</i>“\n"
                    + "\n"
                    + "Minerva grinned and licked her lips again, clearly getting aroused from the memories again. It “<i>When I saw her... The way she squirmed in my arms and looked at me. All I could feel was a sense of pride and maternal instincts. I kept her, I suckled her and watched as she grew in my arms, as she drank from me her body swelled to the size of a young girl, maybe 12 years old, too young to fuck yet but she was cute. It was amazing to watch, I was happy to have her in my arms... I do miss her, my first born daughter.</i>“ she actually smiled for a moment before looking at you. “<i> I actually thank you for talking to me. These memories will keep me occupied for a while, so why don't you run along and get back to you ‘championing’</i>“\n"
                    + "\n"
                    + "Seeing as she is too busy to be bothered with you - she seems to be ‘reminiscing’ about her lost shark-girl daughter. Getting up from the ground you shrug and head back to the camp and leave the masterbating siren to herself.");
            doNext(camp.returnToCampUseOneHour);
        }
        //PART 3
        else
        {
            backstoryPart3();
        }
        
        //================
        function backstoryPart3() : Void
        {
            flags[kFLAGS.MINERVA_BACKSTORY] = 0;
            if (flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] == 0)
            {
                flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] = 1;
            }
            outputText("Telling Minerva that you want to sit down and talk with her merely draws a bored sigh from her. “<i>Talking? Again? Why do that when you could indulge in far more pleasurable pastimes</i>“ She says as she draws a finger across your cheek, her twin tentacled members rising at the implication of her words. Seeing that you won't be tempted this time, Minerva sighs and sits down on the soft moss before gesturing to you. “<i>Fine, tell me then; what do you want to know?</i>“ Sitting across from her, you ask about her past, how did she come to find be like she is and find this place.\n"
                    + "\n"
                    + "Upon asking if Minerva could continue her tale she sighs and rolls her eyes .</i>“What really? that again? well I suppose it won't be so boring. hehe, I was just at the part with my darling daughter</i>“ the corrupted siren said with a lecherous grin\n"
                    + "\n"
                    + "The red-headed siren picked up her story again where she last left off, once again seeming to enjoy her memories. “<i>I do so miss her... my beautiful...sweet darling daughter, my sexy little girl...</i>“ She says with a giggle continuing her story. looking fron you could clearly see her dicks hardening, clearly she is going to start masterbating again soon. “<i>When I was about to give birth to her, my new instincts told me to seek out water, I didn't want to go back to the lake again and rist those nasty other sharks trying to get at my little sweety, I managed to find a river and ended up giving birth to my daughter there so it would be just us. With her born and so young, I didn't want to just travel around and risk my beautiful daughter’s health. So we stayed at the stream for a while.</i>“ Minerva stopped for a moment, closing her eyes as if she was picturing it in her head, the time spend with her daughter, her tongue licking her lips as if in anticipation.\n"
                    + "\n"
                    + "After a moment or two of reminiscing Minerva opened her eyes again though she seems disappointed. “<i>We stayed there at the stream for months. It was just us, mother and daughter, together and alone. The stream even had fish in it, plenty of fish to feed just the two of us. It seems safe for us there and being a shark-girl she was growing up we needed to be by the water. She really grew up fast though. In a matter of months she was about an adult’s size, ready and ripe for the picking. Though she was much smaller than me, she was the size of the shark-girls and her father, my traits not passing on at the time.");
            if (kidsCount > 0)
            {
                outputText(" Ohhh, if they had, hehehe, she would have been a fucking sexy siren! Gods, I would have just ruined her!");
            }
            outputText("</i>“\n"
                    + "\n"
                    + "“<i>I had no idea that she would grow so quickly; after getting to preteen size I thought that she would just grow normally from that point, but there she was. Only a couple of months and a sexy full-grown adult. It was amazing, but I suppose it was a little sad, I had hoped she would be young for a while longer so I could be her mother more....</i>“ Minerva looks down, the corrupted siren actually looking a little saddened by this. “<i>I miss her, I really do. Sometime soon, I think I'll take a trip and find her. I’ll bring her back here and show her how her mother has fared.</i>“ Minerva said with a growing grin, it’s obvious how that would turn out but it seems that Minerva genuinely misses her daughter, even irreparably corrupted Minerva still has strong maternal feelings.\n"
                    + "\n"
                    + "She was silent for a moment, clearly thinking about her lost daughter in both a sexual way and in a way a mother would worry about their child. “<i> here was an incident between us. Shark-girls have strong libidos as it is but with my daugher an adult she was ready to mate and breed, I had noticed it for a few days. the way she would look at me, watch me when we bathe, cuddle extra close to me when we slept. I knew what she must have been feeling but at the time, I wanted to think it was nothing. Then one night she made her move, clearly she couldn't wait any more and she jumped me as I awoke to find the sweet with her lips wrapped around my cock and sucking like a champ. Her tongue licking and lapping at my fat shaft as if her life depended on it. Mmmm... she did such a good job, little slut must have been practicing...</i>“ Minerva says as she licks her lips and spreads her legs, the twin towers of cockflesh swelling with arousal as she describes her daughters acts to you. The siren’s hands reaching down to stroke and play with herself as she tells you all about it.\n"
                    + "\n");
            if (player.cor < 50)
            {
                sceneHunter.print("Check failed: corruption too low!");
                outputText("Looking like she is about to start again you put your hand up and speak up, telling her you really, really don't have any interest in listening to her tell you how she had sex with her daughter. “<i>What, seriously? That's the best part of this story and you want me to skip it?</i>“ she asks incredulously as she looks at you with astonishment. “<i>Fine.... fine, you big party pooper, I’ll skip ahead a bit since you have that stick up your ass... pansy</i>.“");
                doNext(finalF);
            }
            else
            {
                outputText("Grinning lecherously you nod your head, paying complete attention to Minerva and telling her to go on and continue her story. Hearing how eager you are only seems to make Minerva more excited. “<i>Oh you dirty [man]. You really want to hear about how I fucked my slutty daughter don't you. Oh how delicious!</i>“ She says with a grin before laughing and continuing her story, her hands already pumping and stroking one of her dicks while the other squeezes and massages her huge balls.\n"
                        + "\n"
                        + "“<i>So there she was, sucking and bobbing her head up and down, her tongue licking around my tentacled cockhead as her hands massauged my fat nuts. Sneaky devil must have used one of those goblin lust potions on me; even though I tried to fight it, her mouth and hands felt so good.</i>“ letting out a groan Minerva shivers and slides that prehensile tongue across her lips. “<i>Her hungry red eyes looking up at me as she pulled off my cock and licked me from base to tip, she was loving every second of it too, telling me how much she loves her mommy and how much she has wanted me. I bet that little bugger parasite had something to do with her speedy development and her desperate hunger</i>“\n"
                        + "\n"
                        + "“<i>As soon as she said that she kissed my tip and started licking, I just couldn't hold out and blew my load right there. Fuck there was so much, just a monster load, gush after gush splattering all over her body, painting her face, chest, even some flew up and landed on her ass.</i>“ biting her lip now it looks like Minerva is getting close already and you yourself were feeling the effects of her heated descriptions. ");
                if (player.isMale())
                {
                    outputText("Your [armor] growing tight as your [cocks] swells inside, showing how aroused you’re getting from her story.");
                }
                else if (player.isFemale())
                {
                    outputText("Your [armor] growing damp from your vaginal juice oozing from you as a clear sigh of your growing arousal.");
                }
                else if (player.isHerm())
                {
                    outputText("Your [armor] growing tight as your [cocks] swells inside while your vaginal juice oozes from you [pussy] as clear signs of your growing arousal.");
                }
                outputText("\n"
                        + "\n"
                        + "“<i>She looked so good painted with my sperm I just had to give her more. I grabbed that slut and pushed her down, she just giggled and waved her cute little ass at me and spread her legs. She wanted it so bad, my own daughter wanted her mommies cock stuffing her so much. I was so turned on at the time too, I was painfully hard, my balls swollen even though i just came. Despite how developed she was just so much shorter than me, her sweet little cunt looked so small, but she was so wet. I grabbed her beautiful ass, spread her lips and shoved in hard! Gods was she tight, it was so hard to squeeze my cock into her, but she took it so well. She squirmed and whined and clutched at the ground as I ground into her and slowly squeezed every fat inch into her. ooohhh fuck!</i>“ The corrupted siren groans out as she arches her back and blows her load over the ground and herself. The thick white cream splattering wetly on the stone and painting Minerva’s face with her own virility. Panting and clearly enjoying herself as she uses her two foot long demon tongue to lick her own sperm off her face.\n"
                        + "\n"
                        + "“<i>Ahhh... so good...mmmm.... I really need to find my daughter again...so shall I continue?</i>“\n"
                        + "\n");
                doYesNo(corContinue, corStop);
            }
            
            //=================
            function corContinue() : Void
            {
                clearOutput();
                outputText("“<i>Mmmm, good...</i>“ she says as she licks the last of my ball butter from her face. “<i>So good...now then... it took a good minute to work every inch into her, the size difference made it so deliciously tight inside her. Her belly had this delightful long thick bump going up her tummy from how much I was stretching her. I barely gave the ‘poor’ girl a chance to get used to it before I started to fuck her into the ground. The grunting and moaning and the wet squishing sounds of our incestious passion filling the air. I bent her over and held her against the ground as I rammed every inch of tentacled cock into her slippery cunt. My hands ran over her body, grabbing her firm tits and pinching her hard nipples as I pounded her. So eager, so needy, she wanted it so badly and I gave it to her. Over and over for hours I fucked her, I must have filled her womb with jizz four times at least, she was so bloated with my cream, she looked like she was already about to give birth. mmmm....you know, I’m sure she did have to not too long after, with how much I pumped into her, I bet I have a cute granddaughter.</i>“ The thought makes the corrupted woman giggle.\n"
                        + "\n"
                        + "“<i>Oo cute, so plump and swollen with my sperm and so young and fertile. Ooohhh if only I have kept her with me, you would have found me with all these darling shark-girls! Hehehehe.... unfortunately I didn’t bring her with me. I had some foolish notion that I had to be cured.</i>“ she snorts and shakes her head.");
                doNext(finalF);
            };
            
            var corStop : Void->Void = function() : Void
            {
                clearOutput();
                outputText("Mineva sighs disappointedly but looks at least a little satisfied. “<i>Alright, alright, well let's skip ahead a bit if you insist...</i>“");
                doNext(finalF);
            }
            
            var finalF : Void->Void = function() : Void
            {
                clearOutput();
                outputText("“<i>Let's just say I had to leave and continue on my own. I was having a hard time then; my body was getting more corrupted by the day, I could feel it creeping at the thoughts getting closer and closer to making me turn into a monster... I must have run into a dozen of those  cute green sluts and naughty red little cretins as I traveled, not at the same time of course... thankfully my ravishing new shark-like body was stronger, sleeker than before, I was able to beat them all down when one of them tried to attack me. I don't know why but I headed for the mountains.</i>“ Minerva said looking over at the defiled spring.\n"
                        + "\n"
                        + "“<i>Of course now I know its fortunate that I did, had I not, I would never have been found by you and would never have realized my potential.</i>“ She says with a dangerous sharky grin “<i> By then my corruption was a growing and ready threat inside me, at this point it was changing me, it turned my normal human feet into these sexy double-jointed clawed beauties and my tongue into this oh so sexy beast of a tongue</i>“ Minerva says before opening her tongue and extending what looks to be a two foot long demonic tongue, pulling it back inside she continues. “<i>thankfully I was growing close to ‘help’, so I kept climbing, kept trudging along. it didn't take more than a few days for my food to run out. It had to happen of course when I was reaching some of the highest points of the mountains. I could have tried climbing back down but, would probably have passed out from hunger by then and fallen off. Luckily, I didn't have to decide, a trio of harpies has found me clinging to the side of the mountain. With me having to hang on it was easy for the natural-born flyers to pluck me from the side and fly off, though thanks to my size they had to work together to carry me off to some harpy nest. Like everything else in this world, it was easy to tell what they wanted from me. As soon as they dropped me down they were right ontop of me again, pulling my clothes off and kissing me with this weird gold lipstick.</i>“ Minerva let out a shiver at the thought of the experience.\n"
                        + "\n"
                        + "“<i>I have no idea what they put in that stuff buts good stuff, in record time all I could think of was fucking them into submission and seeding their wombs! It was like the shark girls all over again but this time I was the aggressor.  I'm not sure how long the effects of those kisses lasted, at least a few hours judging by how sore my balls were, by the time my head was clear enough to try and make a break for it the three harpies seemed to have had their... fill of me...and i filled them soooo good</i>“ She says clearly proud of how thoroughly she fucked those harpies. “<i>Anyway. since they were done took the chance to get away. Thankfully those harpies had food, bags full of these big gold colored seeds.</i>“\n"
                        + "\n"
                        + "“<i> I was so hungry I didn't care if they changed me. So I dug in, eating the walnut sized seeds one after another until I couldn't eat anymore.</i>“ bringing her wings in Minerva gently strokes her feathered limbs. “<i> I grew these very soon after, sprouting right from my back as my arms got covered in these sleve-like feathers. It hurt to grow them but it didn't matter to me. I was full of food and had a way to get around quicker. Still sore from the growing I tried my new wings out, taking off into the air to explore for a way to stem my corruption.</i>“ Judging from the tone of her voice you could tell she was getting close to the end of her tale.\n"
                        + "\n"
                        + "“<i>I must have flown for hours; the seeds I ate getting burned off fairly quickly, leaving me starving again... By the way, why is normal food so hard to come by around here?</i>“ she asked seriously, as if it had been on her mind for a while. Shrugging your shoulders you really had no answer for her, though you had been wondering that yourself. “<i>Well, I finally could go no further, exhaustion, hunger and corruption catching up with me, I crashed onto a cliffside. I could feel its warm all consuming grasp closing around me, it was so tempting to give in and let it happen. As fate would have it, I landed on the rocks just outside this tower, I hadn't seen it while midair because of the mist.</i>“ smiling a little the siren stroked the soft moss that grows from the ground.\n"
                        + "\n"
                        + "“<i>If I was going to become a monster I at least wanted to have some shelter, so I went inside the tower. That's where I found this place. This... oasis of life, though it looks much better since I had my way with it. I guess though that it was built as some kind of sanctuary though it clearly fell into disrepair. This place turned out to be my salvation. Since you came to find me here you set me free, now I have new purpose, a new goal.</i>“\n"
                        + "\n"
                        + "She smiled before kissing your cheek. “<i>Thank you for listening, to my story, I know it was a long and hard thing, but it was a heart pounding tale.</i>“ she says with a snicker. “<i>Now then, I have many harpies and daughters to fuck and breed. I’m sure you have lots of ‘championing’ to do.</i>“ She says before getting up and heading over to where she keeps her harpies.\n"
                        + "\n"
                        + "With Minerva off tending to her breeders you sigh and head off, back to camp, blueballed by the erotic story Minerva told you.");
                dynStats("lus", 30, "scale", false);
                doNext(camp.returnToCampUseOneHour);
            }
        };
    }
    
    //3-2= talking scene 2 - talks about the spring
    //-repeatable
    private function corruptTalkSpring() : Void
    {
        clearOutput();
        outputText("Telling Minerva that you want to sit down and talk with her merely draws a bored sigh from her. “<i>Talking? Really? Why do that when you could indulge in far more pleasurable pastimes</i>“ Minerva says as she draws a finger across your cheek, her twin tentacled members rising at the implication of her words. Seeing that you won't be tempted this time, Minerva sighs and sits down on the soft moss before gesturing to you. “<i>Well, tell me then; what do you want to know?</i>“ Looking the corrupted siren up and down before casting your gaze around your can't help but be drawn to the bubbling, syrupy, blackish ooze of the defiled spring. Looking back to Minerva you ask about the spring, enquiring about its nature\n"
                + "\n"
                + "Asking about the spring draws a sinister grin from Minerva. the corrupted herm kneeling down and running a hand through the thick dark liquid. “<i>Ahh the spring, despite how glorious it is now, how sweet and spine tingling the waters are now, I actually know little about it. It WAS some kind of pure and holy spring before Ihad my way with it and fixed it, pumping my corrupted cream into it till it became this wonderful thing.Tasting this concoction, bathing in it give you such a rush, makes me so hard and readying to fuck babies into a dozen fertile females or herms.</i>“ she says before bringing her hands up and taking a drink from it s‘water’ “<i>Mmmm... so thick, so sweet... so deliciously corrupt...</i>“ Licking the remnant from her lips Minerva rises and approaches you, her wide hips swaying, her twin cocks already achingly hard and ready thanks to the defiled spring water.\n"
                + "\n"
                + "Pressing her body close to yours pushing her breasts against your face and her cocks against your belly(if pc is under 5’5feet: Playfully picking you up into her arms holding you against her, one of her towering spires of tentacled cockmeat sticking out from between your thighs and acting as a support for your body as she hold you.) “<i>Say... how about we take a dip right now? common, indulge a little, it will be fun. If not, we could always fuck.</i>“ she says, her twin dicks throbbing at the mere mention of sex.");
        menu();
        addButton(0, "Bath", bath);
        addButton(1, "Sex", sex);
        
        //================================
        
        function bath() : Void
        {
            clearOutput();
            outputText("Grinning at your acceptance Minerva brings you to the edge of the defiled waters, the nude siren letting go of you before jumping into the thick dark soup, lounging in the bubbling stuff and letting out a relaxed sigh. “<i>Mmmm, come on in, baby, its perfect...</i>“ she says before licking her pouty dark lips enticingly and beckoning to you.\n"
                    + "\n"
                    + "Looking down at the syrupy stuff with a tinge of nervousness, somewhat hesitant to immerse yourself in the corrupted waters. Seeing how much Minerva enjoys it though wins out and you step into the thick ooze, the warm slippery stuff making your skin tingle wherever it touches, sending a lustful heat through your body and a shiver up your spine. Settling into the bubbling liquid, you let out a moan and relax.\n"
                    + "\n"
                    + "Seeing how relaxed you are, Minerva decides to have a little fun with you, gathering up some of the thick goop into her hands before splashing you with it, caking your face in the dark fluid. sputtering you shake your head and glare at the corrupted siren who merely grins at you as if challenging you to fight back. Not being one to turn down such an obvious challenge you fight back, tossing and splashing Minerva with her own corrupted spring water, starting a battle the likes of which you have never encountered.\n"
                    + "\n"
                    + "Splashing, thrashing and surprisingly enough, playing in the spring, each of you drenching each other in the thick corrupted stuff and flirtatiously teasing each other all the while. After much playing and teasing the two of you relax, basking in the arousing warmth and sensations of the corrupted waters for a long while before you finally rise from the syrupy stuff and decide its time you headed out.\n"
                    + "\n"
                    + "“<i>Awww... leaving little old me all alone without even offering to have sex? how cruel?</i>“ Minerva teases before waving you off. “<i>Fine, fine. Go on and do your ‘championing’ if you ever get bored of that do come back, I’ll make sure you have a proper home and purpose</i>“ Stepping out of the thick slick goo you shake and wipe off as much as you can before you leave, making sure to stop off at a stream to wash yourself off properly before returning to camp.");
            dynStats("lus", 10, "scale", false);
            doNext(camp.returnToCampUseOneHour);
        };
        
        var sex : Void->Void = function() : Void
        {
            clearOutput();
            outputText("Pouting at your rejection of the offer to bathe together, Minerva’s mood soon turns more aggressive, pulling you into a deep hungry kiss. “<i>Well, since you don't want to have a bath, lets settle for some quality alone time.");
            corruptSexMenu(false);
        }
    }
    
    //3-3= talking scene 3 - talks about her shark-girl daughter
    //- requires that backstory has been told
    private function corruptTalkDaughter() : Void
    {
        clearOutput();
        outputText("Telling Minerva that you want to sit down and talk with her merely draws a bored sigh from her. “<i>Talking? Really? Why do that when you could indulge in far more pleasurable pastimes</i>“ She says as she draws a finger across your cheek, her twin tentacled members rising at the implication of her words. Seeing that you won't be tempted this time, Minerva sighs and sits down on the soft moss before gesturing to you. “<i>Well, tell me then; what do you want to know?</i>“ remembering your past conversations with Minerva you remember her mentioning that she had birthed a shark girl daughter at one point in her life, it seemed like a sensitive topic with her though. Really wanting to know more you ask to know more about this daughter of Minerva’s\n"
                + "\n"
                + "The corrupted siren looks at you sharply when you ask about her firstborn daughter, a lecture grin spreading across her face “<i>Ooohh. so you want to hear about her huh? What am Inot enough for you, you want my first daughter as well?</i>“ she snickered before her grin shrinks, now clearly troubled. “<i>Well... I don't know where she is... if I did I would have brought her here to be with her family, well with her mother at least.</i>“ Even though Minerva was a very corrupt being it seemed she still cared deeply for her lost daughter.\n"
                + "\n"
                + "Reaching out you place a hand on her shoulder to give the corrupted herm some comfort, it was certainly a strange thing, you had never seen a corrupt being act like this. The lucid moment doesn't last long however, that sharky grin once again sliding onto her face. “<i>I would give her such a warm reception, oh that hot little bitch, I’d show her just how much I missed her alright.</i>“ she says before biting her lip, her dicks rising to attention with the obvious fantasies running through Minerva’s mind. “<i>Mmmm... after the obvious hugging and happy reunion we would reminisce, I’d tell her how sorry I was for leaving her, that she can take her place by my side again and that we can fuck all the time like we should. Oh, I bet she would love that, after how she was last time I saw her I wouldn't be surprised if she wanted to get right back into it</i>“\n"
                + "\n"
                + "Shaking your head at the notion, somehow doubting that Minerva’s daughter would be so eager to be made into her mother's breeder. Knowing where this conversation is going to go you wave her off deciding you would rather not hear about all the incestious things Minerva would do with her shark-girl daughter\n"
                + "\n"
                + "“<i>What? You're leaving already?! I was just getting to the good part!</i>“ Minerva says with amusement as you leave the tower and head back to camp. Knowing her she is probably going to be busy thinking of her daughter.");
        doNext(camp.returnToCampUseOneHour);
    }
    
    //SEX SCENES!!!!!!!!!
    //PC Chooses Sex from Minerva’s Options:
    public function corruptSexMenu(output : Bool = true) : Void
    {
        if (output)
        {
            clearOutput();
            outputText("You tell Minerva that you’d like to have sex with her, this time. Licking her lips, Minerva approaches you, her hips swaying in an exadurated maner, her twincocks bobbing back and forth before pressing against you. “<i> Well, well, can't get enough of Minerva, can you? How could you when you know I’ll give you the ride of your life</i>“ she draws a fingers across your jaw as she pushes her chest out to you, her tail curling around your leg.</i>“ How do you want it? ");
            if (player.hasCock())
            {
                outputText("You can ride my ass all you want, or would you rather play with my pets?</i>“");
            }
            if (player.hasVagina())
            {
                outputText("Want me to stuff your cunt and ass, or ride you and ruin your hot body for anyone else?</i>“");
            }
        }
        menu();
        addButton(0, "Anal", sexAnal);
        addButton(1, "GetBlowjob", sexBlowjob);
        addButton(2, "AddictOral", sexCumAddictedOral).disableIf(cumAddiction() < 3, "Maybe if you lost to the corrupted siren a couple of times in a row...", "???");
        addButton(3, "GetDommed", sexGetDommed).hint("No weird affects here!");
        addButton(4, "NagaHugs", nagaHugs).disableIf(!player.isNaga(), "You're not a naga.");
        addButton(14, "Back", corruptMenu);
        addButton(5, "Pre-Cor", minervaSexWrapped).hint("Pre-corruption Minerva sex scenes. Need to be adapted properly, but I'll leave it here for the purpose of scenehunting.");
    }
    
    private function minervaSexWrapped() : Void
    {
        minervaScene.minervaSexMenu(false);
        addButton(14, "Corrupt", corruptSexMenu);
    }
    
    //4-1= sex scene 1 male/herm:  Anal
    //any -pc pushes Minerva down onto her chest ass up and fucks her ass = needs penis
    private function sexAnal() : Void
    {
        clearOutput();
        outputText("You give a smile and place a hand on Minerva's thigh, gently pushing to indicate she should get down on all fours. The red-headed siren looks at you for a moment before giving you a kinky grin, before getting down onto her hands and knees, your intentions obvious. ");
        if (minervaScene.pregnancy.isPregnant)
        {
            outputText("The pregnant herm makes sure to be careful of her swollen belly, taking care not to push it against the ground. ");
        }
        outputText("Spreading her legs a little, Minerva lowers her chest down and pushes her curvy rump up, presenting her ass to you.\n"
                + "\n"
                + "You smirk and step forward, reaching out to appreciatively squeeze her firm, plump rump, then draw back a hand and give a playful slap to the nearest of her spankable cheeks. The sudden spank drawing a sharp squeak of surprise from the shark-like harpy, looking back at you with a lecherous leer and a throaty growl, clearly enjoying a hint of rough stuff. Lifting her long sharky tail out of the way, she sways it side to side before curling it gently around your neck and pushing her rear back, bumping against your hips as a sign that she’s ready.\n"
                + "\n"
                + "Unfortunately, you are not yet ready for her, wanting to tease the herm a little more.  Running a hand between her legs, you feel her cool wet sex, the slipperiness of her arousal, spreading to your fingers, the touch sending shivers of pleasure through the waiting eager siren.  “<i>Teasing me still? So mean... are you going to make me beg for it?</i>“ she says with a lusty grin on her face, her tone clearly playful enjoying the sexual tease.  Bringing your hands up, you grab the juicy violet and red cheeks of her ass. If you're going to be fucking her butt, you want to get it good and sensitive.  Squeezing and kneading the firm squeezable rear, your hands work it like touch stubborn dough, getting it ready for the next stage.  Your hands let go, rising from the ready rump before coming down on her, spanking her hard and drawing a surprised squeak of pain and kinky arousal. “<i>Yes! punish me! Give the big bad broodmother the spanking she deserves!</i>“ she shouts, your rough actions working the siren into a lusty fever.  Your hands spanking the herm over and over, painting handprint after handprint across the firm round cheeks, each naughty hit making Minerva more aroused, more ready for you to take her.  “<i>Nnnnn... I can't take it, getting me so HOT! I feel like i'm going to burst!</i>“ She says, almost pleading for you to finally take her.\n"
                + "\n"
                + "Well, no sense in keeping the lady waiting, right? You slip down the lower parts of your player.Clothes until your crotch is bare, exposing your [cocks]"
                + ((player.hasVagina()) ? "[cunt]" : "")
                + "to the open air. Feeling Minerva’s bare ass rubbing against you helps coax your shaft into erectness, and you begin to teasingly drag it through the cracks of her juicy round rump, hesitating to actually penetrate her until you are good and ready. Your teasing draws a lust moan from the corrupted siren, her hips thrusting back against you to bump your hips, her tail gently squeezing you to tell you that she wants you to give it to her hard. “<i>Give it to me!, fuck the busty sirens tight ass, pounded this needy bitch</i>“\n"
                + "\n"
                + "Deciding you’ve teased her enough, you drag your [cock] down through the crack of her ass one last time, then align your cockdescript head with her asshole. You ask her if she’s ready for this. Looking back at you Minerva licks her lips, that long prehensile tongue slurping her pouty black lips alluringly. “<i>You have no idea, give it to me, fuck me hard and fast like an animal, I want it rough.</i>“\n"
                + "\n"
                + "Drawing your hips back, sinking fingers into her squeezable butt, you begin to push forward into her back passage. It’s surprisingly cool, maybe because of the shark essence in her blood, slick enough to let you slip in easily, but gripping tightly around your [cock], the inner walls gripping you and letting you feel dozens of tiny, smooth bumps lining the muscles inside. Minerva’s walls ripple and massage you as you finally bury yourself to the hilt inside her, groaning in pleasure at her anal embrace.\n"
                + "\n"
                + "Minerva bites her lip and pushes her hips back as you push in, doing her best to keep her body relaxed until you’re all the way inside before clenching her muscles around you rhythmically. The siren starts slowly shifting her hips around, trying to make it feel good for you as you slowly stretch her unused anal passage. “<i>Oh yeah... thats it fuck my tight ass. I’m going to make this feel so good.</i>“ She says before pushing back and grinding her hips against yours and squeezing you. Between her legs Minerva’s tentacled cock pulses with her immense need, her tentacles squirming over the length and jerking herself off as you pound her ass.\n"
                + "\n"
                + "You draw yourself back, dragging your cock.Descript inch by inch through her grinding, squeezing, walls, then thrust yourself firmly back inside her. You repeat the process again, and then again, picking up speed as you pull back and push forward over and over again. The sirens lyrical moans slowly start to fill the air. Her body rocking with your thrusts, pressing and grinding her pierced nipples against the ground as you pound her tight slick rear. Her longest tentacles manage to reach back and grab hold of your cock.descript, feverishly stroking you as you thrust into her, the naughty little things oozing their aphrodisiac venom into your cock instinctively. You cry out, shivering as the potent venom immediately streams through your body, setting your blood boiling with lust, and you start to piston into her ass with ever-increasing speed. More and more toxin floods you, combining with the incredible sensations of her ass-walls gripping and squeezing you to turn you into a mindlessly rutting beast.\n"
                + "\n"
                + "Your suddenly increased pace and new brutal thrusts cause the siren to grit her teeth and clench the soft moss beneath her. A long throaty groan is pulled from her, clearly enjoying the rough treatment you’re giving her. Fuck yes! That’s more like it! Rut me like the hungry fuckbeast you are! Ram my tight ass and fill me with your sweet cream!</i>“ the corrupted herm practically screams, her tail’s hold tightening around you as she clenches her already tight ass, the cool slick walls constricting around you so tightly.\n"
                + "\n"
                + "You can’t take it anymore, the pressure is too much and, with a cry, unleash your seething, frothy seed into the siren’s waiting bowels. The intense, rough fucking and the feeling of your sweltering seed flooding her bowels sets her off as well, the sirens orgasm bursting around you, her tight, slick inner walls squeezing you as her own endowments blows their load between her legs, her copious spermy flood making a slick, thick puddle on the ground beneath her.\n"
                + "\n");
        if (player.cumQ() < 1000)
        {
            outputText("You gush into her until you are totally spent, her innards swallowing your load without the slightest effort. </i>“Ahhh... please, let it all out, give me every drop you can muster</i>“\n"
                    + "\n"
                    + "Panting from the rough ass fucking she just received the corrupted herm lets out a satisfied purr. “<i> Thats what I like to see, hard brutal fucking like that makes me so hot.</i>“ she says as she yanks you down onto her body with her tail. “<i>You manage to be a satisfying lover after all.</i>“ She says teasingly before using her tail to pull you away from her just long enough to pull you out of her ass so she can turn around. “<i>I think you have earned a little something extra by bringing me such pleasure</i>“ Pulling you down she stuffs your face between her breasts. “<i>Hmmm... perhaps another time you will have the courage to try and impregnate me “<i> The corrupted siren teases as she hugs you against her body as if you were her favorite toy.");
        }
        else if (player.cumQ() < 5000)
        {
            outputText("Your unnatural orgasm pours into her guts, flooding her interior with sticky cum. By the time you give out with a gasp of effort, ");
            if (minervaScene.pregnancy.isPregnant)
            {
                outputText("her already-distended belly is starting to scrape against the ground, her filled womb and bloated innards combining into one huge bulge.</i>“G-god....fuck, so full... I feel like I'm gonna burst.</i>“");
            }
            else
            {
                outputText("her stomach is visibly bulging, swollen from the cum you have filled her with]</i>“Oooohhh... fuck...so much... I feel like I have a baby in there.</i>“");
            }
            outputText("\n"
                    + "\n"
                    + "Gritting her teeth for a moment as she squeezes down on you before letting out a sigh. “<i>Ahhhh... you pumped a good hot load into me didn’t you. I feel so warm inside. You know how to fuck a woman when you really get into it, so hard, so brutal, my ass is going to be sore for a while.</i>“ Clearly satisfied by your performance the corrupted siren uses her tail to pull you off her just long enough to pull off of your throbbing dick and turn around. Now that she is no longer plugged some of your copious load flows down her ass, wetting her thighs with your cream. Not letting you go just yet Minerva pulls you back down and stuffs your face between her breasts, hugging you like you were some toy. “<i>I think you earned yourself a small reprieve, don't you hun?</i>“ she jokes “<i>Though, maybe next time you can work up the nerve to try and take my hot needy pussy; it’s so hard to find a worthy mate to get me pregnant.</i>“");
        }
        else
        {
            outputText("Your freakish orgasm continues seemingly without end, cascades of jizz pouring into her bowels and through them to her stomach. “<i>Oh gods...oh gods... so, so much... how are you cumming this much!?</i>“ You keep cumming though, the sheer quantity resulting in a build-up of pressure that sends yet more of your spunk spurting out from her curvy backside. Finally, you are finished, and Minerva’s belly ");
            if (minervaScene.pregnancy.isPregnant)
            {
                outputText("is so hugely distended she’s practically wallowing on it, the cum-bloated, baby-filled orb visibly pressing against her arms and legs. </i>“Uuuuuu.... oh gods... I’m gonna burst! It’s too much.</i>“ She says as she coughs, some of your swimming pool-like load splattering onto the ground from her coughs. “<i>Gods, I can taste it, I can taste your cum</i>“");
            }
            else
            {
                outputText(" is so swollen she looks like she could give birth any moment now, the creamy sperm inside her softly sloshing around. “<i>Fu...fuck... h-how...so-so much cum... </i>“ Minerva says as a trail of white slowly drips from her drooling mouth before she swallows it back. “<i>I-I think I can taste it. I've never felt so full in my life...</i>“.");
            }
            outputText("\n"
                    + "\n"
                    + "With her body gurgling in protest Minerva coughs up some of your thick spunk; you managed to stuff her corrupted body so much it had reached her mouth. “<i>Mmmm you came so much I can taste it, you really can show a herm a good time, can’t you? I bet you could fill a bathtub with all that sperm.</i>“ She says licking her lips at the perverted thought. Gripping you with her tail and pulls you off, uncorking the pressure of her body and letting much of that hot spunk gush from her body to soak her thighs and ass in slippery cream. “<i>Ahhh... it’s a shame you’re not a siren, love; I may have just let you put all that spunk in my hungry pussy. Such a virile mate would be hard to come by.</i>“ She says teasingly before pulling you down onto her cum stuffed body, stuffing your face between her tits. “<i>You have earned the right to rest with the siren broodmother I’d say.</i>“");
        }
        outputText("  You allow Minerva to hold you against her curvy lustful body, recovering your strength from the draining sex you just had. Eventually, though, your strength returns and you gently pry yourself free of her, telling her that the sex and her company was wonderful but you need to return to camp.\n"
                + "\n"
                + "The corrupted siren grins up at you as she lazes on the floor, one of her hands playfully circling around one of her breasts. “<i>Do return again soon, if next time is just as good I'll be quite pleased. Don't worry though, I have plenty of harpies and daughters to play with so I won't be lonely at all.</i>“ You smirk at that and comment you’re certain she’ll manage to keep herself occupied. With that, you turn and start the long hike back to camp.");
        player.sexReward("no", "Dick");
        doNext(camp.returnToCampUseOneHour);
    }
    
    //4-6= Corrupt Minerva cum addicted oral: written by space
    //replaces oral when 3-5 points of addiction
    public function sexCumAddictedOral() : Void
    {
        clearOutput();
        outputText("You look over your corrupted beauty, her big  red breasts with the pierced purple nipples, down her fit red stomach. Her two cocks stand erect above her big crimson sack that hides her purple wet fuck-hole behind it. Guess there’s never a time where this slut isn’t horny, such a nice pleasure palace she has down there, but like all palaces: Someone is always looking to plunder them of treasure. ‘Milk’ would be a more fitting analogy as you lick your lips, yearning for the taste of something sweet, gooey and salty. You " + ((player.isNaga()) ? "slither" : "crawl") + " to Minerva and nuzzle her purple thighs with light kisses of affection, the purple harlot is amused by your actions. You’re almost acting like a little animal, trying to get the attention of their master. “<i>So you wanna pay your respect to your “<i>master</i>“? Well I’m not one to reject such a generous offers of affection, so here you go.</i>“ She parts her thighs, allowing your drooling mouth easier access to her wonderful fun bits.\n" + "\n" + "With so many parts to lick and suck on, you don’t know where to start! You eye her long cocks, each pulsing with desire and love. Her bloated sack rests just under her cocks, waiting to fill a needy hole with seed, And you can’t forget the pussy that’s hidden behind there, leaking with a strong craving of want, that you can see a trickle of it flowing down her leg. So many choices on where to start, you feel like a slut in the middle of a group fuck!\n" + "\n" + "After some much lustful thought, you decide to start with the cocks. The smell their emitting is too pleasant to not suck on. You grip one in each of your each hands, oh geez, do you start with the left or the right cock? Again, you pause, brow furrowing in concentration, trying to figure out which one would be better to begin with. Your focus breaks however, when the tentacles of the left freakish cock latch onto your face pull you towards it while flushing your face with lusty aphrodisiac, you let the tentacles guide your hot mouth onto her cock. You nuzzle and kiss it’s tip. Your lips can feel the pulsing blood go through it as you taste a bead of bitter pre, then you feel the tentacles pull you down over them. Your mouth engulfs the entirety of the wide purple head, including all of the thick tentacles circling the base of the head.  They wiggle in your mouth, rubbing the insides of your cheek and the ridge roof of your mouth. Releasing more liquid lust down into your stomach.\n" + "\n" + "You swallow down more of her length, making lewd gagging sounds as you shove every inch down your throat, drool slurping down her shaft and off her ball-sack while the cock-head tentacles are now tickling your throat. The set of tentacles at the base are now latching onto your head and face. Both of your insides and outside are being filled with this mind-numbing drug, you don’t even notice your hand reaching over to her other red-cock, stroking it while both sets of drug dealers latch onto that hand, lightly guiding your warm grip upon the massive shaft. Your hand gets slippery with every stroke towards the head, milking out beads of pre-cum that spill over. The sour fluid flowing down her red shaft, and all over your hand and into its palm. Your hand starts making the sound of slick flesh rubbing tight against one another, mixed in with the sounds of your sick-cock gagging and the singing moans of the seiren.\n" + "\n" + "Minerva's pulls & twist  on her studded nipples “<i>Oh come lover, you got two hands. Plunge those fingers into my fuck hole.</i>“ You slide your fingers underneath her testes and shove them up, past her violet puffed netherlips, a little squirt of fuck juice being squeezed out by your intruding fingers. “<i>There you go, keeping working those hands & mouth of yours moving. I’m-I’m almost there you little slut!</i>“ You barely even register what she said, your mind, clouded from the aphrodisiac, the only thing you know is to continue sucking on this tasty cocky, stroking its brother and fingering her deliciously tainted flesh hole.\n" + "\n" + "Minerva’s body withers in the waves of pleasure and “<i>sings</i>“ a long note that raises in pitch as she comes closer to cumming. When her voice is as high as you think it can go, you pop her corrupted cock from your mouth-cunt and slide your fingers from her teased snatch, taking a grip on the just-sucked on cock with them. The tentacles latching onto your hand, just like the ones on your other cock pumper, and you stroke both the cocks with excitement.\n" + "\n" + "You feel the left one about to cum first, you point it directly at your face and let it spill all of it’s hot and sticky seed all over you. The threat of drowning in cum is present, as Minerva’s cock cakes your face in jism, your eyes already glued shut and your nose clogged. You open your mouth just so you won’t drown in the stuff, swallowing every glob that lands in your maw.\n" + "\n" + "The sweet release from leftie makes the right one about to blow, you quickly  tighten your grip on the cum tube, denying it’s release for the moment. Only once you feel the shoots of the first cock die down to a weak trickle do you let that cock go and aim the bloated one at your face.\n" + "\n" + "A 2nd coat of paint is nice, you think as you relax your grip and let her paint you with corrupted love. Another huge load of batter is shot onto your face. Flooding the area and making huge streams of the white seed flow onto your [breasts].  You brush off what globs are settled on your eyelids and use your tongue to lick off the cum that surrounds your mouth. Once you can see normally, you give Min a cummed-face smile. “<i>That’s a good look for you.</i>“  she teases while her hands grope her tit and play with her pussy. “<i>Mmmmmmm... you look good enough to eat.</i>“ she moves in close to your face and licks a blob of cum off your cheek. It’s tickles a little, making you giggle.\n" + "\n" + "She continues to lick her vile cum off your face with her long demonic tongue, even being polite enough to lick the cum that dripped your chest. You give her a few kisses whenever her mouth is close enough to yours and when the Sharpy is finally done, the two of you dive into a sloppy make-out. The taste & smell of salty cum plaguing both your mouths and you two just love it.  You pull away from each other and you look into your corrupted fucker’s crimson eyes. She makes the remark “<i>If you ever want another facial, I’ll be more than happy to help a cum-dumpster like you.</i>“ she rubs your cheek and sends you on your way.");
        player.sexReward("cum", "Lips", false);
        if (!player.fiendishMetabolismNFER())
        {
            cumAddiction(1);
        }
        doNext(camp.returnToCampUseOneHour);
    }
    
    //4-6= sex scene 6: Blow job!
    //Minerva sucks off male/herm = needs penis
    private function sexBlowjob() : Void
    {
        clearOutput();
        outputText("Thinking about just what kind of heated, heart pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features, starting with her long legs, flared, wide hips. Your eyes travel past the thick growing twin tentacled dicks, before going up her scarred toned belly and up to the siren’s E-cup breasts before finally reaching her face. Grinning to the purple and red herm you decide what you want from her. your eyes soon falling onto her succulent, full glossy black lips and the long demonic tongue that was hidden inside. Grinning and thinking of all the things that tongue could do you decide you want some nice oral pleasure\n"
                + "\n"
                + "Hearing that you want some oral pleasure brings a playful if sinister grin to Minerva’s face, the corrupted herm licking her full luscious lips with her long demonic tongue “<i>oh, you want Minerva to pleasure you with mouth do you. Well I would be happy to show you how much pleasure a siren can give, hope you don't mind my teeth, even I wouldn't bite so, don't worry your pretty little head</i>“ Undeterred by her sharky features you know she would not harm you like that. Guiding her over to one of the fallen pieces of stone before sitting down and "
                + ((player.isNaga()) ? "lounging against the rock you spread open your protective slit and let your [cocks] free" : "spreading your [legs] and open the crotch of your [armor], letting your [cocks] free")
                + ".\n"
                + "\n"
                + "Grinning and giving one of her dicks a quick squeeze, Minerva looks down at you before kneeling, placing a hand on your hips she takes hold of your [cock biggest] and start to slowly stroke it, her eyes looking up at you as she leans in and starts to gently lick your hardening flesh with the tip of her tongue. Under her careful deliberate actions, your masculinity is quickly brought to full attention. ");
        if (player.biggestCockArea() >= 60)
        {
            outputText("Minerva’s eyes widen and her mouth opens in shock as your dick grows and grows and grows, quickly dwarfing her own sizable package. “<i>Hehe, well, someone is hung like a fucking monster I see, not that this will be a problem for me.</i>“ She says with a confident smirk before giving the fat monster cock a long slow lick, clearly pleased by your size. “<i>“Gotta say I’m a bit of a size queen, the bigger your cock the better a breeder you are, to an extent.</i>“");
        }
        else if (player.biggestCockArea() >= 34)
        {
            outputText("Minerva’s eyes widen as your dick grows and grows, quickly growing larger than her own sizable package. “<i>Well well well, a big boy, aren’t you, hehe this will be fun after all, be a nice tasty snack, won't you?</i>“");
        }
        else if (player.biggestCockArea() >= 21)
        {
            outputText("Minerva’s eyes widen as your dick grows more and more before her eyes. “<i>Well it’s decent at least, a bit average by this world's standards, but don't worry I’ll make sure to make you feel so good, you will be coming back for more.</i>“");
        }
        outputText("\n"
                + "\n"
                + "Taking a relaxing breath Minerva dives right back into it, her long tongue slithering out to lick your hard sensitive flesh, wrapping around the tip and giving the most sensitive part of your dick a good squeeze. The heat quenching chill of her wet tongue feeling so good on your hot hard prick, the tight squeeze pulling a gasp from your mouth, your hands moving over her head and into her dark red hair, suddenly relieved that she can't envenom you this way. Wanting to show you what she’s made of, your siren lean in, dragging her cool wet tongue up your dick from base to tip before planting a kiss right on the [cockhead biggest] of your throbbing needy dick.");
        if (player.hasBalls())
        {
            outputText(" Her hand on your hip moving down between your legs, moving to gently caress and massage your cum filled balls and give you more pleasure, her hands  wanting to work your balls up and give her a good load at the end.");
        }
        outputText("\n"
                + "\n"
                + "Holding the kiss for a moment, your siren lover slides her tongue out, slowly teasing around the tip. Her eyes look up at you for a moment before a playful smirk slips onto her face, her tongue extending like from her mouth like an eel, the long appendage coiling around your length like a snake around its prey before constricting around you tightly, sending shudders of pleasure through you. The oral embrace feel so tight, wet and cool around your comparatively hot dick, the tip of her tongue teasing the underside of your hard flesh");
        if (player.hasBalls())
        {
            outputText(" before licking and teasing your heavy sack");
        }
        outputText(".\n"
                + "\n"
                + "With your tongue firmly captured by her tongue Minerva leans down, opening her mouth wide and taking you inside the cool wet confines of her mouth even as her tongue squeezes you and slides around your warm sensitive flesh. Looking up at you with a playful twinkle in her eyes as she starts to suck and squirm her tongue around on you, the long prehensile appendage switching between licking over your throbbing cockmeat and squeezing it in a snake like embrace.\n"
                + "\n"
                + "Puckering her glossy black lips, Minerva starts to bob her head, taking more and more of you with each bob of her head");
        if (player.biggestCockArea())
        {
            outputText(", taking more and more of your huge cock inside her mouth and soon taking it deep down her throat, with a little difficulty her slightly angular nose presses against your crotch, every inch of your dick trapped inside her cool, wet mouth and throat");
        }
        outputText(". Slurping and licking your package she sucks and starts to bob her head up and down, working your length with everything she can. Looking down behind her, you can clearly see her shapely rump swaying back and forth, clearly not minding the sexual act.\n"
                + "\n"
                + "The furiously teasing tongue action coupled with the powerful sucking, working to leave you braced against the rock, groaning in sweet pleasure as Minerva works your dick, practically worshiping your masculinity, her tongue licking and wrapping around you as she sucks and pulls you deep inside, with how good her mouth is your glad she can't invenom you like this or you're sure she would reduce you to a pile of quivering lust.");
        if (player.hasVagina())
        {
            outputText(" Extending her tongue as long as she can Minerva slithers it out of her mouth and down to your womanhood, her demonic tongue licking around the slipery puffy lips before snaking its way inside to pleasure you there as well, licking and squirming against your walls and making you gasp and quiver under her attentions.");
        }
        outputText("\n"
                + "\n"
                + "Panting and groaning you know you can't hold out for long. Your hands sliding into your lover’s red orange hair, your sudden gasping and holding her head warning her of your impending orgasm. ");
        if (player.hasBalls())
        {
            outputText("Your [balls] lurch and swell, rising up as you reach your climactic explosion. ");
        }
        outputText("Gripping Minerva’s head tightly you let out a long deep moan, your [cock biggest] bloating with each ejaculation. Eager to please Minerva does her best to drink down every drop you give her, her hands gripping you and pressing her nose against your crotch, puckering her full black lips around your base.\n"
                + "\n");
        if (player.cumQ() < 100)
        {
            outputText("Feeling your orgasm burst inside her, Minerva’s long tongue licking up every drop as she sucks hard, determined to milk as much as she can from you, not lasting too long, your orgasm died down, leaving you tanking as Minerva slowly pulls her tongue back inside and licks her lips, pulling off your saliva soaked dick. “<i>I guess that it, you really should work on your production. Your barely worth a snack, luckily for you your pretty tasty</i>“.");
        }
        else if (player.cumQ() < 1000)
        {
            outputText("Feeling your orgasm burst inside her, Minerva’s long tongue licking up every drop as she sucks hard, your load a little bigger than she thought it would be, your warm seed filling her mouth and completely drenching her tongue in the sticky stuff. Lasting about a minute, your powerful breathtaking orgasm dies down as your siren lover swallows one last time, her tongue licking you just to make sure before poping off your slavia drenched dick. “<i>mmm... not bad, personally I could blow a much, much bigger load than you, but i guess this will have to do. You would be a much better breeder if you improved yourself to put out more of this yummy seed of yours.</i>“");
        }
        else if (player.cumQ() < 5000)
        {
            outputText("Feeling your orgasm suddenly burst inside her, Minerva’s long tongue licking up every drop as she sucks hard, your load a much bigger than she thought it would be, flooding her mouth and puffing out her cheeks as she struggles to swallow and gulp down your thick copious load. Lasting well over a whole minute, your stomach filling orgasm finally ends, Minerva popping off your cum hose with a deep sigh, some of your pearly cream dripping down her chin before being licked up by that delightfully long tongue of hers. “<i>Ahhh... you're good for a drink at least, you're not quite a match for my sperm factories but hey, it's not like it's a compi-... you know it is a competition, heh. Come on now, don't want to fall too far behind me do you?</i>“");
        }
        else
        {
            outputText("Feeling your orgasm suddenly burst inside her, Minerva’s long tongue licking up every drop as she sucks hard, your colossal load far more than she was expecting. Like a great flood your sperm gushes into her sucking mouth, very quickly overfilling Minerva despite her constant swallowing and attempts to contain it, her stomach quickly bloating under the intense flow. Choking on the thick heavy creamy filling her throat Minerva squeezes her eyes shut, not about to be shown up by you, the corrupted siren concentrates, squeezing down on your dick as she swallows gulp after heavy gulp of your thick copious load, working your pulsing shaft like a pro, she sucks down every hot drop that you give her.\n"
                    + "\n"
                    + "Lasting for what has to be several minutes you let out a long satisfied sigh as your sperm fountain for a cock is finally released from Minerva’s sucking mouth. The filled up siren letting out a very satisfied sigh as she pats her greatly bloated, sperm stuffed belly. Shooting you a playful sharky grin, Minerva lips her pouty black lips. “<i>Well, have to say I’m impressed, there are few that could pump put that much, and such thick potent cream as well. You’re a virile one that's for sure, I might not even mind sucking you off more often.</i>“");
        }
        outputText("\n"
                + "\n"
                + "Deciding to relax for a while after your sexual adventure you curl up on the soft moss with Minerva, both of you just basking in the warmth that the spring gives off and softness of the moss, content with each other's presence. Unfortunately you know you have to go, the call of your duty to this land is too great and despite the comfort of this place you must go. Pulling away from the siren you promise to return and visit her soon. “<i>I will always be here for you my love, always.</i>“");
        player.sexReward("saliva", "Dick");
        doNext(camp.returnToCampUseOneHour);
    }
    
    public function corruptWin() : Void
    {
        clearOutput();
        if (monster.HP <= 0)
        {
            outputText("With your final blow to the siren you send her silver halberd flying from her hands, the metal weapon skittering across the ground as Minerva herself falls onto the soft moss, her sharky skin covered in sweat and bruises as she drops to her knees, looking up at you with wide eyes. “<i>I didn’t know you were so strong, so fierce and dominant. </i>“ she says with a throaty growl and a lick of her lips. Her eyes betraying the lust she feels for you now that you have shown how strong you are. Looking at the corrupted siren you can't help to notice the look in her eyes has changed, its softer, like her mind is less consumed by corruption.");
        }
        else
        {
            outputText("With a long throaty moan Minerva drops her weapon to the ground. Despite her resistance to lusty combat you have managed to overpower even her through your sheer sexyness, your unstopable beastial magnitizim. “<i>So hot.. oh gods... I need it... I need you so much...</i>“ panting hard Minerva looks up at you, her eyes glazed and foggy with the raw sexual need. Ger twin spires of virile breeding flesh looking to be painfully hard, her fertile thighs soaked in her feminine juices, the scent of her arousal hanging heavy in the air. Looking at the corrupted siren you can't help to notice the look in her eyes has changed, while misty with her lust, its softer, like her mind is less consumed by corruption.");
        }
        outputText("\n\n");
        if (player.isMale())
        {
            outputText("Sliding a hand between her legs Minerva slowly starts rubbing herself. The siren letting out a soft groan before moving onto her hands and knees, her legs spread for you as she uses her hand to spread her slippery ultraviolet colored pussy, showing you how ready she is for you. “<i>Take your prize, take your siren like the big strong breeder you are, fill my soaking cunt with your sperm and breed me,</i>“ she growls to you as she shows off her puffy needy pussy to you. “<i>Breed your siren like a dominant male should, plow me hard make my belly swell with your beautiful strong daughters. Once they are born, ravish them, make them swim in your spunk, knock them up over and over again, but never forget that that none of them could ever please you they way my needy tight cunt will make you feel. Milking every last thick creamy drop of your fertile seed out of your [balls]</i>“, the horny herm is shuddering and moaning just from the kinky illicit thoughts running through her mind, clearly your victory over her has had a powerful effect on her. With her nearly begging you to breed her and give her strong daughters how could you say no?");
            doNext(corruptWinFuckHer);
        }
        else if (player.isFemale())
        {
            if (!player.canGetPregnant())
            {
                outputText("Spreading her thick fertile thighs apart Minerva’s reaches down  and takes hold of her fat twin shafts, slowly stroking them as she looks up at you. “<i>Do you like them? the finest of siren cocks so hard and ready for you. Would my lover grant me the honor of fertilizing you with my strong siren seed. Our daughters would be so strong, so beautiful and virile.</i>“ the corrupted herm says as she strokes herself and puts her body on display for you, as she strokes thick syrupy blobs of thick musky precum drip from her tips, a testament to her potent fertility. The siren broodmother is strong, her seed very potent, she would make a fine breeding partner for you. “<i>Just imagine how wonderful our daughters would be, how much fun it will be to play with them or even bless them with the honor of getting to have sex with you, their strong fierce mother.</i>“ With such a potent breeder so ready for you and telling you about your future daughters how can you say no to such an invitation?");
            }
            else
            {
                outputText("Spreading her thick fertile thighs apart Minerva’s reaches down  and takes hold of her fat twin shafts, slowly stroking them as she looks up at you. “<i>Do you like them? The finest of siren cocks so hard and ready for you.  I know you have blessed another with the honor of fertilizing you, I will pleasure you like no other can, I’ll fill your body with such arousal and give you all the pleasure you could ask for.</i>“ the needy siren says as she strokes her twin spires of iron hard breeding flesh, as she strokes thick syrupy blombs of thick musky precum drip from her tips, a testament to her potent fertility. The siren broodmother is strong, her seed very potent, she would make a fine breeding partner for you. “<i>Perhaps next time, you will allow me the honor of fertilizing you and giving you a beautiful siren daughter to play with as well.</i>“ With such a ready and eager lover so on display for you, how could you say no? Even if she can't knock you up this time you could still get the ride of a lifetime from her.");
            }
            doNext(corruptWinRideHer);
        }
        else if (player.isHerm())
        {
            outputText("Looking up at you with some measure of reverence, Minerva leans back on her tail. Her thick fertile thighs spreading wide for you as she reaches down and starts stroking her twin dicks, thick dollops of musky syrupy precum bubbling from the tips as she strokes them “<i>yesss, so powerful, so dominant and strong.</i>“ she eyes traveling up and down your form, visually undressing you and looking over your every curve. “<i>So fertile and ready, please love, won't you give me the honor of fertilizing you with my seed, my thick virile sperm will give us such beautiful daughters? I'll show you such pleasures as I fill your womb so full of strong siren seed.</i>“ she says before letting out a throaty growl, her constant slow strokes drawing thick globs of pre from her body, the near stream of thick lube a testament to her incredible fertility.\n"
                    + "\n"
                    + "Licking her lips Minerva slides her hands lower, cupping the massive sperm filled balls and lifting them, giving you a glimpse of her soaking puffy pussy. The siren rolling onto her hands and knees before spreading her legs, a pair of long tentacles slipping around her balls to her needy cunt, spreading her lips and letting you see the quivering cilia covered walls of her ultraviolet snatch. “<i>If you deny me the honor of fertilizing your womb, perhaps you would bless me with your own seed, fuck me hard, dominate me and fill my quaking hungry womb with your virile spunk. impregnate me and bless me with your strong beautiful daughters.</i>“ the submissive siren says seductively as her tentacles slowly stroke tight slippery entrance, her huge heavy balls and massive twin dicks hanging beneath. “<i>Please, lay claim to my body don't care which part of me you choose to enjoy yourself with. Once our cute little herms are born imagine all the naughty things we both could do with them.</i>“ she says in a husky lust filled voice, every action a practiced attempt to seduce you. “<i>Gods, just the mere thought of playing with you and our daughters  makes me crave you even more... hurry darling and make your choice...I can't take it any longer!</i>“ With all of the siren's sexuality on display for you, each part of her begging to be used by you how can you say no? With her so eager which part of her will you lay claim to?");
            menu();
            addButton(0, "Fuck Her", corruptWinFuckHer);
            addButton(1, "Ride Her", corruptWinRideHer);
        }
    }
    
    private function corruptWinFuckHer() : Void
    {
        clearOutput();
        outputText("With a grin you prepare to take your well-earned prize, slowly freeing yourself from your [armor] and tossing them aside like so much trash, your body exposed, your growing arousal free from its confines.  Licking your lips you start your inspection, your hands reaching out, running over her round firm rear, giving her a testing squeeze before pinching the red and violet orbs, the playful pinch drawing a sharp gasp from the siren.  Moving down her curvaceous body you slide your hands over her, your touch light, teasing even as it brings little shivers from Minerva. Running down her wings and back you come to her face, the red and violet herm looking up at you with vivid eyes filled with a mixture of reverence, hunger and what looks like actual love, a kind of emotion that seems foreign to beings so corrupted or at least twisted into a perversion of its normal incarnation.\n"
                + "\n"
                + "Running your hands across her cheek the siren opens her dangerously toothed mouth, her long tongue slithering out and teasingly licking your hand, the corrupted herm smirking up at you as she teases you before pulling her tongue back in. “<i>Do you approve of your prize, does my beautiful fertile body please you, it hungers for your touch, the touch of one so strong and dominant. Can't you smell how ready, how needy I am already?</i>“ she asks, looking up at you as you move on, moving around her body and back behind her. Looking over her shoulder you can see the growing hunger in her eyes, just knowing how much she wants you turns you on even more aroused. Grabbing hold of her ass again you give her a hard squeeze before giving the herm a firm spank, your hand rippling the firm flesh of her rump and drawing a throaty growl from the horny siren.\n"
                + "\n"
                + "Dipping a hand in between her legs you feel just how wet and ready she is, her cool cunt quivering under your touch, her slippery juices oozing over your fingers.  Curiously you bring your fingers to your lips, slowly licking Minerva’s arousal from them, as if to match the spring she is so attached to and the fruit she consumes too often her juices are sickly sweet, like a rich tangy musky syrup. Licking your hands clean you nod in approval, the corrupted broodmother’s body is work of art, her form could not be more delicious, more perfect.  As if to tell how your approval you reach down and shove a pair of fingers into the clinging violet cunt, the cilia covered walls squeezing down almost desperately around your fingers.  At your sudden teasing intrusion into her overly sensitive body ripping a long moan from the siren as she pushes her hips back against your hand. “<i>Ooohh... please... please don't tease me, I need it so bad, I need you inside me. Mate me, rut me like a beast and stuff my needy cunt, breed me like a bitch in heat.</i>“ she nearly cries out, her voice like a lyrical moan of pure lust.\n"
                + "\n"
                + "Grinning down at Minerva you stride back around to her front, not yet ready to take your needy siren, fully intending to tease her and get her body all knotted up with arousal before finishing her off. Taking hold of your [cock], you stroke it slowly as you come to her head, the siren looking up at you with wide eyes as you present your dick to her. Looking down at her, you tell her she must pay tribute to her superior lover before she gets the honor of being fucked and bred by you. Gulping and licking her lips Minerva leans up, her head brushing against your maleness");
        if (player.hasBalls())
        {
            outputText(", her face rubbing against your [balls], taking a big wiff of your sack she groans, her tongue slipping out to lick your fertile nuts before kissing them");
        }
        outputText(". Moving up, she slowly licks and kisses her way up your [cock] before reaching the tip, her tongue slithering out from her lips to coil around your prick like a snake.\n"
                + "\n"
                + "Letting out a groan from the sweet pleasure you run your fingers through Minerva’s thick red black hair, holding onto her head as she starts to worship the cock of her lover, the cock that will breed her and put a daughter in her belly. Eagerly she laps at your shaft, slowly licking you over and over as she drinks in your heady musky scent. “<i>Oh sweet nirvana, your scent, so strong, so musky and virile. Just your scent is getting me so hot, my cunts getting so wet already.</i>“ She says with lusty groan before leaning up and wrapping her plump glossy black lips around the tip of your prick, her cool wet mouth slowly sinking down lower and lower, her eager mouth slurping up every inch of your masculinity.\n"
                + "\n"
                + "Slowly her head bobs up and down over you, slowly blowing you and savoring the taste of your prick. ");
        if (player.hasBalls())
        {
            outputText("Minerva’s hands run and down up your thighs before moving to your sperm filled nuts, her hands gently caressing you and softly squeezing your balls as she licks and worships your cock. ");
        }
        outputText("Slowly pulling off, she kisses your way down before drawing her tongue from base to tip and giving your [cockhead]  a long puckered kiss. Letting out a long groan you pull her off you, giving the sirena  gentle pat and praising her for being such a good cocksucker for you. Pleased with your praise she leans down again, shaking her ass in the air and looking up at you with hungry eyes. “<i>Please, I want it, I can't take anymore, I need your virile cock deep inside me, fuck me and breed me full of your daughters!</i>“ the corrupted broodmother pleads as she looks up at you.\n"
                + "\n"
                + "The sirens body calls to you, begging you to rut her, breed her and impregnate her. Every motion, every sound and call from her, just another way to tempt you into indulging in the sweet ecstasy she would provide you.  Her hunger, her words, her strong heady scent working wonders on you, your [cock] swollen up with your arousal so ready to plow the needy slut before you. Moving back around you take your rightful position at her round ass and slippery ready snatch. Slowly, teasingly you bring your [cock] to bear against her quivering entrance, gently to rub the [cockhead] against her swollen puffy pussy, purposefully teasing Minerva and drawing your well deserved victory out and making your lover coo and moan with ever-growing need.  Finally you decide to end her “torment“ and claim the lusty herm as yours, grabbing tight squeezing hold of her fertile child bearing hips and ramming forward into her slippery vice of a snatch. Your powerful piercing thrust ramming the full length of your throbbing masculinity into Minerva’s quivering quaking body, ripping long throaty moans from her as her cunt clenches tightly, her cilia squirming around you as they at once get to work stinging all along the length of your pick and flooding your body with her mind-bending fuck-drug.\n"
                + "\n"
                + "Barely a few seconds pass before the powerful aphrodisiac takes hold of you, filling your body with burning lust and need, your cock swelling up as your sensitivity grows alongside it.  Your length and thickness bloating more and more as she stings you until your prick packs her pussy so full and stretched by you that the horny herm’s toes curl and back aches with ecstasy. Your teasing touches combined with the sheer arousal at the prospect of being taken and bred by such a dominant, powerful, virile being brings the siren to her first body shaking orgasm.  The lust siren’s body shakes and shudders under you, her cunt clenching tightly around you as she cums, her orgasmic juices gushing over your fat venom bloated length.  The veritable river of feminine juices only serving to lube you up even more for what will be a brutal fuck, with all the venom flowing through you and clouding your mind you can barely contain your need to rut the fertile fuck-hole your swollen dick stuffs.\n"
                + "\n"
                + "Unable to hold yourself back a moment longer you let out what could only be described as a beasial roar as you ram your massive pick into the tight welcoming hole, your brutal thrusts shaking the poor corrupted siren even though her orgasm had only just ended.  Despite how hard you pound her Minerva only seems to love the rough treatment, her delighted moans soon filling tower. Pushing back against you the siren grips the ground hard, her demonic foot claws and hands digging into the ground so that you can take her as hard as you need. “<i>YES! fuck fuck... yes! rape me, rut me, breed me! s-such a worthy mate, fuck me as hard as you can!</i>“ she nearly screamed with pure delight, consumed by her need to be impregnated by you.\n"
                + "\n");
        if (player.hasBalls())
        {
            outputText("Between your legs your heavy sack swings with each thrust, the potent siren venom filled crotch tentacles snaking around the sirens own massive bloated sack before latching onto yours. The squirming tentacles doing their perfectly designed job, stinging you the tiniest of barbs that cover their tips, sending arousing, gentile swelling siren toxin right into your scrotum. With the venom pulsing through your [balls] and filling them with fertility, swelling the nuts bigger and bigger as more and more venom reaches them, the bloated sperm factors so heavy and over productive now, there is no way you're not going to utterly stuff Minerva’s womb with every drop you can muster.\n"
                    + "\n");
        }
        if (kidsCount == 1)
        {
            outputText("The sound of such lust filled sex draws the attention of your corrupted daughter, the curvy young siren looking on with awe as you furiously pound Minerva from behind, your massive venom bloated cock and balls driving the broodmother mad with pleasure. Your daughter can't help herself, it's clear she wants to join in and have a turn being fucked by you, but she knows it's not her place to get in the way of her parents. The siren happily takes a seat nearby, her hands eagerly running down her body before starting to masterbate, jacking her siren cock and sliding fingers into her soaking colorful cunt.");
        }
        else if (kidsCount >= 2 && kidsCount < 5)
        {
            outputText("The sound of such lust filled sex draws the attention of your corrupted daughters, the curvy young siren’s looking on with lust and awe as you furiously pound Minerva from behind, your massive venom bloated cock and balls driving the broodmother mad with pleasure. Your horny daughters anxiously look on, clearly wanting join their parents in pleasure they so feel, even though they want to take part they know it's not their place to interrupt you when you won the right to take the siren broodmother is such a way. Your eldest and clearly most aroused daughter bites her glossy black lips before turning on one of her sisters, grabbing the other siren and forcing her sibling into a deep unchaste kiss. As soon as the first kiss was started all bets were off, a small orgy of lusty siren sex burst near to you, your daughters kissing and eagerly taking turns fucking each other. One pair a runty red siren and a tall black and violet beauty are going at it like animals, the much smaller red siren being uttering impaled upon her much larger sisters massive dark dick as she jeers at her playfully.");
        }
        else if (kidsCount >= 5)
        {
            outputText("The sound of such lust filled sex draws the attention of your horde of corrupted daughters, the cluster of curvy young siren’s looking on with lust and awe as you furiously pound Minerva from behind, your massive venom bloated cock and balls driving the broodmother mad with pleasure.  Your horny daughters anxiously look on, clearly wanting join their parents in pleasure they so feel, even though they want to take part they know it's not their place to interrupt you when you won the right to take the siren broodmother in such a way. With such a lusty fuck it's not long before your daughters snap.  Turning on each other the young sirens jump their sisters, the group dissolving into a pile of squirming, thrusting, sucking sex and lust, an orgy of siren flesh as your daughters give in to their incestious insticts.  With them so close and so very active the air soon fills with the sounds of flesh slapping together and the thick heady scent of pure carnal lust permeates the air.  One particular pair of daughters, a short red runt and a tall black and violet beauty are working together, the pair spitroasting one of their double dicked sisters on their cocks, the black beauty stuffing every inch of her massive shaft down her ‘victims’ throat while the red runt screws her sisters brains out with an animalistic pace and strength.");
        }
        outputText("Leaning down over your prize, you put all your weight against Minerva, forcing her chest against the ground and pushing her into a more submissive position, letting you take her as hard as you can and do as you please with her lusty cum craving body. If anything Minerva grows even more aroused from you taking charge like this, your show of dominance acting like a sweet aphrodisiac to the siren, her moans and lyrical cries of utter elation growing louder, mixing with the hard slapping of wet flesh. “<i>More, more, more! I want it! I want every you can give!</i>“ With how aroused she is, how hard you screw her, how loud her cries are, it won't be long before your needy bitch cums underneath you, her body so open and ready to accept your superior seed to fill her belly and give her a strong daughter. Between her legs her unused cocks swing and slap against her belly and chest, her tentacles slithering over the lengths, stroking and jerking each of the huge siren cocks off to add to her own unstoppable pleasure.\n"
                + "\n"
                + "In fact only a scant few seconds pass, a few more body quaking thrusts from your engorged [cock] before reaching her explosive end, her thrashing tail wraps around your pistoning waist, yanking you hard against her and constricting you, holding you against her body with all her might as she cums. Eyes rolling back, tongue flopping out of her mouth as she lets out a gurgling groan of mind blown pleasure. Her cunt clenches, her cilia squirm and writhe inside her convulsing body, the ravaged snatch of your lover squeezing down on you like a snake to its prey, the walls desperately trying to bring you off and milk every drop of your massive load into her waiting belly. Between her legs her maleness throbs and pulses with her orgasm, the fat cumveins on her cocks bulging lewdly with her pent-up, over aroused climax, great thick busts of siren sperm let loose across the ground and body, utterly drenching the broodmother in her own seed.\n"
                + "\n"
                + "Your mates explosive, pussy squeezing, dick straining climax is all that it takes to kick off your own earthshaking end, with a beasial cry you grip her hips and cram every inch into the ‘poor’ broodmother. As if to insure proper insemination of your lusty siren your hugely engorged dick swells a little more inside the siren, the thick powerful cumvein feeding your cock bulges obscinely with each colossal ejaculation that floods Minerva’s cool squeezing cunt. ");
        if (player.hasBalls())
        {
            outputText("Your massively swollen sack swelling and pulling up against your body with surprising force, and churning out gallons of venom enhanced fertility, each great gout filled with trillions of eager sperm, ready to cram themselves into every available egg and impregnate the hungry ready womb. ");
        }
        outputText("“<i>YES YES! Pump me full! stuff me, impregnate me, give me your babies!</i>“ Minerva’s body shakes with each gush of cum filling her belly, her cunt clenching with crushing tightness to make sure as much gets trapped inside, with each powerful throb of your body her womb fills, her belly swelling almost instantly under the pressure and growing bigger and bigger as you unload into your mate.\n"
                + "\n"
                + "“<i>ugghhhhh! ahhhh! so...so much...</i>“ Minerva groans out with a blissful, lust consumed face as her body is utterly stuffed with your cum, her belly so swollen by your spermy domination and wanting nothing more than to continue being bred by such a strong and fierce lover. As more and more gets pumped inside there is soon too much, Minerva over filled belly straining until great squelches of your thick creamy cum splatters out from around your overstretched connection and soaking your thighs. Finally your body seems to be spent, falling over onto the prone broodmother you keep her held down, your swollen cock keeping together for a moment longer until your calm enough to pull out. “<i>Oh fuck...my poor eggs, drowning in all that cum, you're going to give me such strong daughters.</i>“\n"
                + "\n"
                + "After a minute of rest you lean back, your hugely engorged cock slipping out of the abused well fucked cunt, Minervas quivering snatch gaping from being stretched so much. With your pussy packer free from her a veritable waterfall of spooge gushes from her unplugged body and pooling in thick globs under her. Panting and covered in sweat, you look over your work, Minerva's body has been utterly bred, your offspring will no doubt be growing inside her. Before your very eyes the thick gushes of cum slow and stop, her gaping pussy closing up despite the brutal stretching you did, her body seeming to lock in most of your load and keeping her belly utterly swollen.\n"
                + "\n"
                + "Slowly rolling onto her back Minerva looks down at her bloated belly with a look of total satisfaction and bliss, her hands reaching down and rubbing over body. “<i>oooohhh... so good... so full... mmmm...oh you sexy beast... so potent, so dominant.</i>“ She says, looking over at you with a look of surprising affection, clearly very pleased with your performance and that she is going to be carrying your daughter, or perhaps daughters. Smirking you snuffle over to Minerva, putting a hand on her stomach and marveling at your work, soon you will have a new siren daughter or daughters to play with. Looking up at you with what can only be described as perverted affection, your siren pushing you gently, getting you to lay on your back before leaning down to your still hugely engorged dick, licking her lips Minerva gives you a long slow lick before grinning. “<i>A proper mate makes sure to clean their lover after sex, can't have your beautiful cock all dirty with cum now can we.</i>“ she says with her grin still on her face before leaning in again, going down on you and slurping your dick with her two foot tongue.\n"
                + "\n"
                + "The defeated corrupted siren happily kissing her way up and down your cum drenched [cock], reached your base again she slithers her tongue from her lips and draws and long slow lick all the way to your tip before giving your cockhead a long slow kiss with her puckers black lips. slowly, teasingly her lips split as she opened wide, her lips fitting like a snug glove over your bloated masculinity, her cool wet mouth working itself down your sticky shaft, going lower and lower. As your lover lowers herself onto your pick her tongue licks circles around and around its fat swollen length, the sweet pleasure flowing through you as she works your sensitive dick, long groans and shudders of sweet pleasure are pulled from your lips as she works her own lips like a good mate should.\n"
                + "\n"
                + "Bobbing her head up and down over your throbbing dick, her tongue licking over every inch it can reach, her hands stroking and pumping the length that's not swallowed up by her hungry mouth and throat. Panting hard you find yourself growing close to a second orgasm, your siren really working to please her superior lover. ");
        if (player.hasBalls())
        {
            outputText("Her hands fondle your heavy nuts, the fertile balls mostly back to normal by now, though they are still a little swollen with her venom and ready to blow your load down Minerva’s throat. ");
        }
        outputText("Feeling you on the verge of another climax only makes Minerva suck harder, lick faster and pump her hands over your hot iron hard cock, the broodmother hungering for your second potent climax.\n"
                + "\n"
                + "Grabbing hold of her head you let out a long groan as you cum, pulling her head down and cramming a few extra inches down Minerva’s tight throat right before your cock throbs, your engorged cumvein bulging as your thick creamy load bursts inside her, gushing down the sirens throat like a fountain. The cock worshiping siren swallowing hard, hands holding your hips tightly as she chugs down every drop you give her. Closing her eyes Minerva moans as she holds onto you, happily drinking from you until your flow slows and finally stops. Even with her belly even more swollen than before Minerva strokes continues to stroke you, her hands massauging your thick cumvein to milk every last drop from you before slowly pulling off your now cleaned cock. “<i>mmmm... so rich and creamy, truly yours is some of the finest cockmilk in all the land, hehe i'm honored to be allowed to drink from such a delicious stud.</i>“ She says with a lick of her lips. Leaning in she gives your fat venom swollen dick a big kiss on the head before crawling over you.\n"
                + "\n"
                + "“<i>come here stud... you earned the right to cuddle with the broodmother, for giving me such a good fuck and insuring i'm going to have strong beautiful daughters, you deserve a rest.</i>“  With a chuckle you take her up on her offer, taking your place with the well impregnated broodmother you settle down for a well needed rest, your venom bloated [cock] pressing against her well fucked body.\n"
                + "\n"
                + "Nearly an hour later you awaken from your sleep, your body entangled with Minerva’s own, the siren’s hands rubbing her belly with clearly maternal gentleness. Giving her belly a pat you rize and gather your things, and prepare to leave. Looking up at you Minerva licks her lips as she watches you dress. “<i>make sure you come back, such a stud like yourself, you earned the right to take me whenever you like until this darling daughter is born.</i>“ Smirking you look down at her, lifting her chin with your hand and promising to show her that no one else in this world is more worthy of taking her and knocking up the siren broodmother.\n"
                + "\n"
                + "With that said you gather your things and head out, returning to your quest.");
        player.sexReward("vaginalFluids", "Dick");
        player.sexReward("saliva", "Dick");
        minervaScene.tryToImpregnateMinerva();
        cleanupAfterCombat();
    }
    
    private function corruptWinRideHer() : Void
    {
        clearOutput();
        outputText("Smirking, you stride over to the posing siren, her huge twin shafts standing proudly on display for you, her hands stroking the thick pillars of breeding meat to tempt you. Standing before the horny herm you reach down and grab ahold of one of her throbbing dicks, drawing a moan from Minerva as you squeeze the bloated head. Looking down at her, you grin and tease your broodmother with your touches, your hand slowly stroking before you decide to rub your victory in a little. “<i>now why would I let you stick those in me if I’m the one who beat you? now if lost I can see you doing whatever you wanted to me, but you didn't, so why don't you give me a reason to give you the honor of stuffing those big pre-slicked dicks up into my body.</i>“ you ask playfully just to egg the herm on a little.\n"
                + "\n"
                + "Looking up at you with eyes full of want she pushes her hips up, her hands stroking her twin dicks slowly and forcing thick globs of musky pre from their tips for you to smell. “<i>For one so strong, I'll give you all the pleasure you want, I'll stuff both your holes so full, I'll fill your body with my aphrodisiac and give you the ride of your life.</i>“ she says before licking her lips, you can feel the dicks throb with every beat of her powerful heart, the thick tentacles that line the bloated purple heads curling around your fingers, though not yet stinging you. “<i>I will show you pleasure that only a siren can show, and I am the greatest siren.");
        if (player.canGetPregnant())
        {
            outputText(" My seed is strong, so virile and potent we would have very strong daughters, so beautiful and fierce, just like their mother.");
        }
        outputText("</i>“\n"
                + "\n"
                + "Looking down at the siren you chuckle, the siren is a strong opponent, and judging from how the harpies are almost constantly pregnant with her sirens that her seed is indeed as powerful as she totes. The offer of mind-blowing pleasure and arousal does sound tempting as well. Giving her twin spires a squeeze you let go, your hands soaked with her musky pre, the heady scent of her cock nectar, stirring a deep heat in your loins, clearly the fluid is packed with pheromones as well, truly only a being meant to breed and impregnate many mates would be so equipped.\n"
                + "\n"
                + "With your lust growing, your body heating from your victory and from the herm so eager to please you, you decide to indulge in what the siren has to offer. Stripping yourself of your [armor] you slide a hand between your legs");
        if (player.hasCock())
        {
            outputText(". You stroke your [cocks], slathering it in the siren’s musk before moving down");
        }
        outputText(", stroking and rubbing your [pussy] slowly, rubbing Minerva’s syrupy pre into your cunt and mixing it with your own juices. stepping closer to the siren you push her down, if you're going to indulge you going to be the one on top, after all you are the superior one here. Looking up at you Minerva grins and licks her lips, enjoying you display of dominance as you tell her that you're going to be the one doing to riding around here.\n"
                + "\n"
                + "Grabbing hold of the two finest siren dicks there are and you stroke them slowly, teasingly squeezing their heads, thick dribbles of pre oozing out and showing off your lovers potent virility. Your hands run along their lengths, wanting to test the siren and show her you're the one in control. Looking to the gently cooing herm you grin and move around her as you grip her dicks, presenting your hot [pussy] to the siren, looking over your shoulder you look down at her, telling Minerva to put that tongue of hers to work and pleasure her superior lover. Looking up at your cunt Minerva leans up, her hands grabbing hold of your [ass] and slithering her tongue out, to lick you and draw a moan from you as her long tongue slowly slides over your sensitive nethers, hoping that if she does a good job you will allow her inside your delicious body.\n"
                + "\n"
                + "With Minerva licking you so eagerly you decide to reward her for obeying you so well and being so ready to please you. Leaning in you lick the tip of one of her twin dicks, the huge bloated head comply soaked in the sirens pre, your tongue running along the head of the bright purple knob, licking up all that musky fluid and letting it flare your arousal. Beneath you Minerva lets out a moan at your touch, loving how you lick her huge hard pricks, her tongue licking you over and over, running up and down over you, the tip teasing along the outside and flicking your clit.");
        if (player.hasCock())
        {
            outputText(" Sliding forward, Minerva draws her tongue down, ");
            if (player.hasBalls())
            {
                outputText("her tongue licking your [balls] and slurping the fertile nuts before continuing on, ");
            }
            outputText("that perversely prehensile appendage slithering around the length of your [cock] and giving the tip a kiss before pulling back and returning to your saliva soaked femininity.");
        }
        outputText("Pleased with the sirens attentions you lean in, taking the bloated head of one of her dicks into your mouth, your tongue licking around the fat purple head and sucking the pre from her big thick cumvein. Popping off her cock you push your hips back, shoving your [pussy] against Minerva’s face, commanding her to pleasure you more before you take her twin’s for a ride. At the promise of getting your pussy the siren doubles her efforts, her demonic tongue licking your face, flicking and licking over your sensitive cunt before jamming its way inside you, the tongue thrashing around inside your snatch and ripping sweet cries from your lips.  Pleased with her work you consider just making her eat you out but the prospect of being so utterly filled by those twin towering pricks of hers is too tempting.\n"
                + "\n"
                + "Lifting your hips back only seems to work so well, Minervas long dexterous tongue deeply imbedded inside you, your clenching cunt pulling off like it had been some kind of mouthborn tentacle dick, the long slippery thing slowly retracing and slipping out of you, apparently having delved deeper inside you then you had thought. With a lusty moan you lick your lips moving back before taking position over Minerva’s twin twenty inchers, your pussy lips and puckered anus kissing each of the bloated purple heads teasingly, Minerva’s crown tentacles squirming in anticipation, ready to sting you and pump you full of mindblowing siren venom.\n"
                + "\n"
                + "Rubbing your holes against her, you tease Minerva just a bit more, savoring your ability to make the herm moan and look so needy, to have a strong fertile herm like herself at your mercy. Biting your lip you finally decide its time, with a grunt of effort you start to push down, slowly spreading your holes wide around the two intruding members. With some effort the thick heads both pop into your body, the sudden tightness and stretching pulling a long groan from Minerva and a deep gasp from yourself. As soon as the heads pop in side Minerva’s tentacles go to work, squirming inside your holes and stinging your [pussy] and [ass], the slippery stingers pumping your walls full of the potent siren venom, the chemical cocktail rushing through your genitlals and rear; increasing sensitivity and the elasticity of your precious holes so as to not stretch you out");
        //if vaginal/anal is loose, lower looseness until normal.
        if (player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_TIGHT || player.ass.analLooseness > AssClass.LOOSENESS_TIGHT)
        {
            outputText(" and, in fact, help your poor stretched holes recover some of their lost tightness");
        }
        if (player.vaginas[0].vaginalLooseness > VaginaClass.LOOSENESS_TIGHT)
        {
            --player.vaginas[0].vaginalLooseness;
        }
        if (player.ass.analLooseness > AssClass.LOOSENESS_TIGHT)
        {
            --player.ass.analLooseness;
        }
        outputText(".\n"
                + "\n"
                + "“<i>Oohhh yess... squeezing my cock head so good inside, how do you like that first dose of venom, I promised I would show you a good time.</i>“ she says with a throaty coo. Your body feels like its on fire, your nerves growing so sensitive, your cunt and ass growing so hot and wet from the arousal. Letting out a long moan you tense your hips, grinding yourself down and down, sinking inch after inch of Minerva’s two massive dicks deeper and deeper into you, stretching out your holes and delving deeper and deeper into your body. As you take more and more of the two fat siren dicks an outline grows up your abdomen, the outline of Minerva’s dicks  pushing up and up. With a heavy lusty groan you press your [ass] against Minerva’s thighs, grinding against her and squeezing your inner muscles around the body stuffing invaders.\n"
                + "\n"
                + "Leaning down you rest your hands on the red pillowy tits of your beaten lover, your hands squeezing them hard as you grit your teeth and squeeze your inner muscles as hard as you can around your siren lover and ripping long groans and gasps from Minerva. The siren looking up at you and lust clouded eyes, completely unable and unwilling to stop you domination of her body, her hands slide up your hips, her grip on you light but clearly desiring to grip you tight and take you. Licking your lips and groan and shudder as you start to move, slowly starting to ride the siren, your hips pumping up and down and double stuffing yourself on Minerva over and over, her crown tentacles squirming inside you, stinging you  every now and then, her crotch tentacles slithering inside your cunt on every opportunity. “<i>Fuck yessss... your holes feel so good! you sexy fucking woman, ride me, ride my cocks like the dominant slut you are.</i>“ Minerva moans out licking her lips and watch you with lusty eyes.\n"
                + "\n"
                + "Hearing her words in your lust addled mind, you look down, grinning and pinching Minerva’s pierced nipples and pulling them hard and making the siren cry out in pain and pleasure. “<i>a slut huh?</i>“ You say before leaning back, slowly sliding yourself back up, threatening to pull yourself off completely, your siren looking up at you with wide eyes at the prospect of being denied your delicious body “<i>Nooo! I didn't mean it! not a slut, a-a queen bitch, a fierce dominant queen!</i>“ Minerva cries out in apology, not wanting to lose such a good fuck. Grinning down at her, you clench your thighs and slam your hips down, utterly impaling yourself back down upon the massive shafts once more to reward the broodmother. The sudden thrust ripping a long loud moan from Minerva, shoving her hips up in her back arching pleasure, the siren desperate for you, desperately wanting to rut and breed your beautiful body as hard as she can.\n"
                + "\n"
                + "Your lust is finally too much, the spine tingling venom pumping inside you and the delicious stretching from the twin siren dicks stuffed inside your [pussy] and [ass] is too much to bare. Grunting a gasping you start to buck and ride, your hips pushing you up and down, bouncing your ass against your siren lovers hips over and over, basking in the sweet heart-pounding pleasure of such lusty sex. Dominantly you ride Minerva, thrusting and bucking on top of the fertile herms body with wild abandon, your hands gripping her breasts like handholds as your own [breasts] bounce along with your hips. Wet slurping and squishing soon fills the air, mixing with the hard slapping of your ass against Minerva’s hips, the sound filling the air and only serving to arouse you even more.\n"
                + "\n");
        if (kidsCount == 1)
        {
            outputText("The sound of such lust filled sex draws the attention of your corrupted daughter, the curvy young siren looking on with awe as you furiously ride Minerva like she was just a toy, your tightened soaking cunt and equally tight ass, driving the siren mad with delicious ecstasy. Your daughter can't help herself, it's clear she wants to join in and have a turn being fucked by you, but she knows it's not her place to get in the way of her parents. The siren happily takes a seat nearby, her hands eagerly running down her body before starting to masterbate, jacking her siren cock and sliding fingers into her soaking colorful cunt. Her eyes locked onto her mamma’s cocks as they are squeezed into your body over and over, the young siren clearly wishing it was her cocks stuffing your cunt and ass, or perhaps wanting to ride Minerva’s dicks herself.");
        }
        else if (kidsCount >= 2 && kidsCount < 5)
        {
            outputText("The sound of such lust filled sex draws the attention of your corrupted daughters, the curvy young siren’s looking on with lust and awe as you furiously ride Minerva like she was just a toy, your tightened soaking cunt and equally tightened rump, driving the siren mad with delicious ecstasy. Your horny daughters anxiously look on, clearly wanting join their parents in pleasure they so feel, even though they want to take part they know it's not their place to interrupt you when you won the right to take the siren broodmother is such a way. Your eldest and clearly most aroused daughter bites her glossy black lips before turning on one of her sisters, grabbing the other siren and forcing her sibling into a deep unchaste kiss. As soon as the first kiss was started all bets were off, a small orgy of lusty siren sex burst near to you, your daughters kissing and eagerly taking turns fucking each other. One pair a runty red siren and a tall black and violet beauty are going at it like animals, the much smaller red siren being uttering impaled upon her much larger sisters massive dark dick as she jeers at her playfully. The other pair doing a delicious reenactment of your own pleasure, one of your daughters riding atop her sisters fat twin shafts and plunging them deep into her soaking pussy and tight little asshole.");
        }
        else if (kidsCount >= 5)
        {
            outputText("The sound of such lust filled sex draws the attention of your horde of corrupted daughters, the cluster of curvy young siren’s looking on with lust and awe as you furiously ride Minerva like she was just a toy, your tightened soaking cunt and equally tightened badonkadonk, driving the siren mad with delicious ecstasy.  Your horny daughters anxiously look on, clearly wanting join their parents in pleasure they so feel, even though they want to take part they know it's not their place to interrupt you when you won the right to take the siren broodmother in such a way. With such a lusty fuck it's not long before your daughters snap.  Turning on each other the young sirens jump their sisters, the group dissolving into a pile of squirming, thrusting, sucking sex and lust, an orgy of siren flesh as your daughters give in to their incestious insticts.  With them so close and so very active the air soon fills with the sounds of flesh slapping together and the thick heady scent of pure carnal lust permeates the air.  One particular pair of daughters, a short red runt and a tall black and violet beauty are working together, the pair spitroasting one of their double dicked sisters on their cocks, the black beauty stuffing every inch of her massive shaft down her ‘victims’ throat while the red runt screws her sisters brains out with an animalistic pace and strength. Another pair of sirens doing a delicious reenactment of your own pleasure, one of your daughters riding atop her sisters fat twin shafts and plunging them deep into her soaking pussy and tight little asshole.");
        }
        outputText("\n"
                + "\n"
                + "No longer caring for consequences you thrash your body atop the siren broodmother, giving into your bodys need to breed and mate you moan like whore as you impale yourself again and again. Reaching up Minerva grabs hold of your [breasts] holding the bouncing mounds in her hands and squeezing them hard, the siren unable to hold in her pleasure, her moans just as loud as your own. Panting hard, moaning louder, your rampant rutting pushing you closer and closer the edge, your siren lover pushing past you, her own sweet lust too strong and sending her into the endless depths of her orgasm.\n"
                + "\n"
                + "Arching her back, and letting out a lyrical cry of pure unbridled delight Minerva slides her hands down your body, gripping your hips as she cums with explosive force. “<i>Oh Fuuuuuuck! Yesss im cumming! oh gods, I’m going stuff you sooo much!</i>“  Between her legs the broodmothers massive balls lurch and swell, the heavy ultra fertile nuts pulsating with life as they blow their spermy load up Minerva’s fat thick cumveins and into your waiting body. Each thick creamy jet injecting great gouts of cool cum into your bowels and womb, with both holes plugged up by with yummy thick dicks and with her cumming so hard your belly very soon starts to swell from the sheer amount of spooge collecting inside you. “<i>Oh shiiiit! So much! My balls are gonna bust! Oh gods, go my sweet spermies, stuuuuf that sweet womb and knock up this amazing woman/herm.</i>“ With your lover cumming so hard inside you and filling your body with so much creamy goodness you can't hold back your own orgasm any longer, shoving your body down as hard as you can and curling your legs under Minerva’s you lock yourself against her as your body clenches powerfully, you're hungry inner walls squeezing and quivering around the throbbing bulging invaders as they continue to fill you oh so full.\n"
                + "\n"
                + "“<i>Tha-thats it... fill me up, stuff my womb and give your superior mate a strong beautiful daughter</i>“ you say as your mind reels in ecstasy, the mind-bending pleasure going on and on for what seems like sweet infinity, the more Minerva unloads into you the better it feels and the longer your heavenly torture continues. Thrashing and shaking, you scream your ultimate pleasure to the world, your eyes seeing stars and mind drowning in a sea of spunk and nirvana. More and More you filled with siren spooge until Minerva finally finishes, your body so bloated from her massive spermy load that you bet this much cum could impregnate dozens of harpies. (if dominated: Letting out a gurgle you gag and cough, thick milky white globs splattering across Minerva from your coughing, her creamy cum filled your guts so much it backed up all the way to your throat. it seems Minerva has only gotten more productive since you asserted yourself as her ultimate superior.) Your own personal trip to paradise fading as your own orgasm finally ends, your mind coming down from the orgasmic high as your hands run over your huge cum bulge, your body so full and heavy with thick virile siren sperm");
        if (player.hasCock())
        {
            outputText(" that there is no hope for your poor eggs, your body is utterly bred and a baby siren will no doubt grow inside you");
        }
        outputText(".\n"
                + "\n"
                + "Letting out a sigh, you look down tiredly at the siren that looks up you with a goofy, freshly cummed look on her face. “<i>What a sexy bit- I mean sexy queen bitch you are... so beautiful and full of thick potent siren cum, the best cum of all I’d say.</i>“ she says with a lusty purr as she. Looking down at you grin and retort, telling her if its so good why doesn't she lick it all up from her body, to lick it from her like a good slut that know who her superior is. Gasping and shrinking back, Minerva looks down at the oh so stretched cunt that squeezes her dick before looking at the huge cum baby of a belly, that's going to be a lot of cum. Gulping the siren nods, ready to service your cunt and lick you clean. Smirking in victory you grit your teeth and slowly pull off the two massive cocks, coming free with a slick wet pop followed by a great gush of spunk fowing down your legs and splattering all over Minerva’s lower body and chest as she moves over her, presenting your sopping cum caked cunt to the broodmother to worship.\n"
                + "\n"
                + "With thick creamy globs of her own sperm splattering onto her face Minerva leans up, closing her eyes as her perversely prehensile tongue slithers out and gently licks your snatch, slowly licking up her cum and pleasuring your still quivering quim. That delicious tongue licking and slurping its way deep into you to clean you and sending such sweet pleasure racing through your body. Leaning up she seals her lips around your hot soaking sex, locking your body into a pervers kiss, eagerly making out with your pussy and delving her tongue oh so deep into you.\n"
                + "\n"
                + "Holding that kiss for a moment, Minerva slowly pulls back and retracts her tongue, your snatch now cleaned up though your womb is still packed full of sperm. “<i>Mmmm our juices mixed together are so delightfully salacious. Perhaps I could fill you more often so I ");
        if (kidsCount > 0)
        {
            outputText("and, perhaps, our hungry sirens can quench our thirst with this lewd cocktail. I’m sure they would like to get a special taste of your combined fertility, don't you think?");
        }
        else
        {
            outputText("can quench our thirst with this lewd cocktail.");
        }
        outputText("Hehe, I made sure to keep all that cream in your womb untouched, after all we want that belly to swell with a beautiful daughter don't we.</i>“ she says with a grin. Chuckling at her eagerness to have children you give your siren a pat on the cock before gathering your things, as much fun as it's to fuck Minerva you have to return to your quest, though it wouldn't hurt to come back soon and have another go with the virile herm.");
        player.sexReward("cum", "Anal");
        cleanupAfterCombat();
    }
    
    //PC loss sex scene
    public function corruptLoss() : Void
    {
        clearOutput();
        //WRONG routing, needs a SEPARATE bad-end.
        if (cumAddiction() >= 5 && !player.fiendishMetabolismNFER())
        {
            badEndConsecutive();
            return;
        }
        if (player.HP <= 0)
        {
            outputText("Falling back from the sirens final strike, the blow sending you onto your back as your [weapon] flies from your hands and landing some distance away, thankfully for you the soft pillow like moss that covers the ground softens your fall. As you lay there panting and exhausted from the fierce spar you had with the halberd wielding siren, you head her approach you before Grabbing you by the front of your [armor] and lifting you up, a proud sinister grin on her face. “<i>Mmm...well well well, look who lost. guess we proved who is the stronger one.</i>“ she licks her lips before leaning in and drawing a long slow lick along the outside of your ear. “<i>Now you're all mine.</i>“\n"
                    + "\n"
                    + "Letting out a dark giggle she lets go of her halbard, her hands going to work and tearing your clothes from your body, stripping you naked so that she can take what she wants from you.");
        }
        else
        {
            outputText("Falling back from the sirens final strike, the lustful need is too much sending you onto your knees as you drop your [weapon] before sliding your hands into your [armor] and start fondling yourself. As you sit there panting and groaning from the fierce spar you had with the halberd wielding siren, you head her approach you before pushing you onto your back, her clawed foot resting on your genitals and grinding against you, the touch only drawing a moan from you and  feeding your deepening lust. “<i>Awww, is that it? a little arousal and you fall to your knees like a animal in heat, if you wanted my dicks so badly you should have just asked for them.</i>“\n"
                    + "\n"
                    + "Grinning her sinister sharky grin she slides her dexterous foot up before using it to tear the clothes from your body, leaving you naked but unharmed “<i>Well... don't worry, Minerva will take care of you and feed you all the siren cock you want.</i>“ The domineering herm says with a throaty growl.\n"
                    + "\n"
                    + "“<i>First lets get all this junk off you so the fun can begin.“<i>");
        }
        suckMinervaShared();
        if (player.isMale())
        {
            outputText("“<i>hehehe, sorry to be so rough on you, this is what happens when you lose to such a strong, sexy, virile herm such as myself. Perhaps next time you will fight harder and not end up sucking down a fat load like one of my harpy bitches.</i>“\n"
                    + "\n");
        }
        else
        {
            getDPShared();
        }
        if (!player.fiendishMetabolismNFER())
        {
            cumAddiction(1);
        }
        if (cumAddiction() <= 2)
        {
            outputText("Shuddering, you let out a groan as you sit there in your drug addled state, the potent addiction of siren cum seeping into your body, instilling a thirst for Minerva’s musky creamy cum.");
        }
        else if (cumAddiction() <= 4)
        {
            outputText("Letting out a groan you lick your lips, slowly playing with yourself as you think about the flavor, the thick creamy goodness of all that siren sperm filling your gut, even after such a filling, you could go for a bit more, just to let it roll over your tongue and slide down your throat again. A part of you warns you, warning you that it's dangerous to lose against such a dangerous opponent so much.");
        }
        else
        {
            outputText("Panting and groaning you lick your lips, swallowing and rolling back as you stroke yourself, the sweet drugged filled embrace of the addicted siren seed filling you utterly, the grinding need at the back of your mind calming with sweet relief as you relish the sensations your recent filling brings you. Even after just being filled you want more, you can't help but think of your next hit from Minerva’s dicks. Deep in your mind a part of you screams at you, telling you that you can't risk another loss, who knows what will happen if you let yourself get even more addicted to Minerva.");
        }
        cleanupAfterCombat(camp.returnToCampUseEightHours);
    }
    
    private function suckMinervaShared(loss : Bool = false) : Void
    {
        outputText("  She says playfully before grinning dangerously and quickly stripping you of your [armor] and throwing it aside, as if they were the most useless things ever. Not skipping a beat, the domineering herm yanks you down onto your knees, using her great height and corrupted strength she holds you down even as she pushes her twin spires of throbbing siren cock against your face, the hungry tentacles lashing out aggressively and stinging your lips, the venom puffing your lips out into a perfect dicksucking fuckhole. Looking up at the corrupted futa with wide eyes, her vile venom sinking into your body almost instantly and flooding you with a deep sexual hunger, ");
        if (player.hasVagina())
        {
            outputText("your [cunt] growing hot and wet with your new need, ");
        }
        if (player.hasCock())
        {
            outputText("your [cocks] growing erect and oozing pre, ");
        }
        outputText("making you squirm in her grasp. You really need to be more careful around Minerva.\n"
                + "\n"
                + "Grinning down at you with sadistic delight, Minerva licks her lips with her prehensile tongue. “<i>Now I know some males don't like the idea of sucking a big fat dominant dick, but that's too bad, you lost and now I am the superior mate here, and you're going to pay tribute to me</i>“  she says with a jagged toothy grin, her hips move slowly, her hands gripping you tightly and keeping you down as she rubs her dicks against you, stinging you again and again to take your remaining strength away. Soon your desire to fight is gone, your face red and flushed with desire");
        if (player.hasVagina())
        {
            outputText(", your pussy puffy, red and soaked in need");
        }
        if (player.hasCock())
        {
            outputText(", [cock] engorged and throbbing with desperate need");
        }
        outputText(". Letting out a panting moan you stop your struggling, your dominant lover taking the chance to force one of her hefty herm cocks into your mouth, her tentacles squirming around in your mouth, playing with your tongue and making you take her tangy pre. “<i>Mmm... you love the taste of my cock, don't you slut? You're getting so muddled now, all my venom inside you, making you so hot and needy. You're just craving Minerva’s dick, aren't you now?</i>“\n"
                + "\n"
                + "With your mouth so full of siren cock you can't speak, your words coming out as muffled moans and you try in vain to deny Minerva's taunting words. “<i>Come on 'champion', suck me, suck the corruption out on me, you are a righteous champion aren't you, so 'purify' me with that nice mouth of yours.</i>“ the corrupted siren taunts down at you. Her hands moving to grab hold of your head, as she pulls your head forward to force you to take her squirming flesh deeper into your mouth, her slithering tentacles playing with your tongue as she forces you to take inch after inch into your mouth. With how rough your dominating siren is with you, it's hard to tell why you asked for this, perhaps you like being dominated and taken by such a strong and capable breeder like this.\n"
                + "\n"
                + "Giving you a bit of a reprieve from her pulling, Minerva holds your head on her iron hard dick, the corrupted siren looking at you expectantly. “<i>Come on now, you're not going to make me do all the work, are you? Get sucking you cock hungry slut. "
                + ((loss) ? "Do a good job and I may even let you get off" : "You asked for this, didn’t you?")
                + "</i>“ she says with a sharky grin and grips your head tighter. “<i>suck, slut...</i>“ she taunts once again, it's clear she isn't going to be letting go until you suck her off. Letting out a whimper you finally comply, the wonderful venom in your blood and Minerva’s musky, tangy precum in your mouth making you feel so good; maybe you can get even more tasty things if you suck. Gulping you push forward, taking a bit more before you start to lick around the thick bulbous head of her futaflesh, playing with her tentacles while you lick and suck.  Bobbing your head against her length you start to take a little more each time, soon the head bumping against the back of your mouth. Grinning like only a shark-girl could, Minerva's grip suddenly tightens, right before she pushes her hips forward. Her forceful move pushing the fat thick mass of her squirmy siren cock into your throat, the girthy flesh visibly stretching your throat as it slides down, tentacles stinging and secreting her mind-numbing, arousal swelling chemicals.\n"
                + "\n"
                + "Even in your heavily aroused, aphrodisiac-addled state you choke on the sudden violation of your throat. You can't help but struggle and try to push off the offending flesh-spear, but as soon as you do Minerva pulls back to let you breathe only to force herself back in, going deeper than before. Inch after inch is squeezed into the tight confines of your mouth and throat, your feeble struggles and attempts to dislodge the corrupted herms throbbing flesh only seem to bring her more pleasure than before. Moans and chirps of pleasure drawn from Minerva's mouth, sounding like some perverted melody. Finally your face is pressed against her crotch, your chin pressing against her huge cum-swollen balls, the heavy soccer-ball sized things bloated and churning with Minerva's corrupted fertility. Holding you there for a moment the siren basks in the sick delight of forcing you to suck down her whole length. Just when you feel like it's going to be too much she pulls back and lets you breathe again.\n"
                + "\n"
                + "“<i>What's the matter, don’t you want this? You're the one that "
                + ((loss) ? "challenged me" : "asked to have sex")
                + ", you knew how...rough... I can be</i>“ She says with a dark smirk as she looks down at your lust ridden form. even if you wanted to stop your body was too turned on by all the lusty aphrodisiacs coursing through you. Looking at the towering spires of potent breeding flesh, you can't help but lick your lips at the sight of them. Taking a deep breath you take it back into your mouth, taking it deeper and deeper into you, even willingly deepthroating the swollen mass. Your mind hungering for what the corrupted siren can give you, hungering for her venom and her toxicly addictive cum.\n"
                + "\n"
                + "Grinning even wider Minerva slides her hands into your hair gently and hold your head. “<i>that's a good slut, you know your place, sucking off your beautiful virial siren lover and worshiping her thick cocks and big strong balls.</i>“ She says with sick delight at what you're being reduced to. Tightening her grip on you the domineering herm starts to move her hips, pushing and pulling her fat dick in and out of your throat, face fucking you. Her thrusts thankfully starting out at least somewhat gentle, her thrusts dragging her dick in and out of your body slowly, her tentacles squirming around inside your mouth and throat.\n"
                + "\n"
                + "Unfortunately or fortunately for you, Minerva doesn't stay gentle for long as she violates your mouth and throat. The corrupted siren’s grip tightening as she thrusts her hips against you over and over, her huge fertile balls smacking against your neck and chest as she pumps her hips and face fucks you harder and faster. The wet sounds of her well lubed dick sliding in and out of you can be clearly heard, the heavy smacking and sloshing of her huge sperm swollen balls hitting you over and over, mixing with her own moans and bird like coos of pleasure.");
        if (player.hasVagina())
        {
            outputText(" Being treated to roughly only serves to make you even more needy, your [pussy] soaked with your juices, your feminine fluids dripping down your thighs.");
        }
        if (player.hasCock())
        {
            outputText(" Between your legs your own [cock] has never been so hard, achingly hard, your pulsing phallus oozes your own pre, the slippery lubricant drooling down your whole length as if you were ready to blow.");
        }
        outputText("\n"
                + "\n"
                + "Pulling back and out one last time to give you a chance to breath, gasping for breath you pant and groan, your throat sore from the brutal fucking. looking up at Minerva you watch as she pumps and strokes her saliva drenched cock to keep her pleasure going. “<i>just a little more ‘champion’, just a little more and you're going to get the big thick load that you have been craving.</i>“ She says with a sinister grin and a lick of her pouty black lips. At the notion of getting a big serving of siren cream you reach out and take hold of the tentacled dick, leaning in you lick the thick throbbing flesh from balls to tip before opening wide and taking the herm back into your mouth and throat, getting a reward for your good work with a few more strings from Minerva’s tentacles, giving you a fresh dose of the arousing venom.\n"
                + "\n"
                + "With her pulsating cock once again enclosed within your tight throat Minerva takes hold of your head again and returned to her rough hard thrusting. Thankfully you don't have to wait too long to get your real reward. Gripping your head and hair Minerva squeezes every fat inch down your throat, hitting balls deep into your body just as her climax was about to blow. With them pressed so close you swear you could head all the heavy sperm packed cream sloshing around inside those massive balls pressed against you. Your eyes widen when you feel it coming, Minerva’s bloated corrupted cock swelling in your throat, making it even tighter, those huge sperm factories actually seeming to inflate a little as they pull up tight against Minerva’s body. Gritting her dagger like teeth with effort its clear Minerva is hold it back as long as she can to build up a truly monstrous load for you. The very thought of getting such a huge creamy injection made your mouth water and try to swallow around your siren.\n"
                + "\n"
                + "The act of swallowing only serves to bring Minerva more delight and push her over the edge. Gripping your head tightly she holds herself rooted deep inside your mouth and throat as she blows her massive load, furious gouts of potently addictive siren sperm blasting down your throat and flooding your hungry stomach with its refreshingly coolness. Groaning and moaning with utter delight as she fills your gullet with blast after heavy blast of dense fertile cream, the sheer amount bloating your belly and making it swell as she fills your stomach. Right next to you her other pulsating cock spills its own hefty load, more and more gushing out to drench your back in her pearly seed, not wanting to waste too much of her thick stuff Minerva pulls back a bit giving her room to aim her second cock and use it to paint your face and chest in her musky addictive jizz. Licking her lips in ecstasy she pulls back further and further, still cumming inside your body even as she pulls back to your mouth, to give you a big mouthful of your corrupted treat.\n"
                + "\n"
                + "Finally after a good minute of ejaculation Minerva pulls back, her cocks still drooling seed as she steps back, her hands stroking her twin shafts as she looks down at you to admire her work, your body caked in addiction-laden siren-sperm, your bloated belly looking swollen and heavy with the amount she pumped down your throat. Gridding a wide sharky grin she laughs at you, clearly enjoying the drugged outlook you have on your face and how you seem to bask in the high of being pumped so full of siren jizz. ");
        player.sexReward("cum", "Lips");
    }
    
    private function getDPShared() : Void
    {
        outputText("“<i>Hahahaha! oh you filthy slut, you just love it, don’t you, getting such a belly full and drenched in my seed, you just can't get enough, can you? What kind of champion lets this happen to them.</i>“ She says with a cruel laugh before leaning down and grabbing you, in your current state of mind you can't do much to fight back against the powerful corrupted creature.\n"
                + "\n"
                + "Pulling your cum soaked body closer. the corrupted siren pulls you into position, pulling you over and pinning you against the ground with your [ass] up in the air. Running her hands over your rump Minerva licks her lips in anticipation, she was plenty hard before but at the prospect of double penetrating you with both her cocks brings her to a new level of hardness, her balls already swelling up with a new batch of baby batter, ready to stuff you full and put a baby siren in your belly. “<i>Oh, you hungry whore, I’m going to fuck you so good, you're going to be so full after this but you want that don't you, you want to be stuffed so squishingly full of my yummy little spermies don't you.</i>“ she says down at you as she strokes your sticky, cum soaked backside.\n"
                + "\n"
                + "Feeling your rump for a moment, appreciating you looks before giving you a firm, flesh rippling spank. Pulling your legs open and lifting your butt up she alines her twin breeding spires with your pussy and anus. Knowing you're about to be taken you pant hard, licking your lips in anticipation of being taken so roughly and dominantly. A small part of you wants to keep fighting but in your massively aroused and drugged out mind you can't hear it, your body craving what's coming.\n"
                + "\n"
                + "Using her hands Minerva spreads her pussy lips and tight puckered anus before pressing her well lubed, twin iron hard shafts against your holes, teasing you with their presence before slowly grinding and squeezing themselves into both your holes. With each inch that's forced into you the wider and wider your stretched, the two thick spears of heavy throbbing flesh filling your body more and more as she relentlessly pusheы and grindы more and more into your hungry body. Shuddering and gripping the ground hard, basking in the immense filling you’re getting from having two 20 inch long dicks fed into you slowly, their girth a clearly three inches stuffing you like celebratory bird. Your shuddering moans echo through the chamber as you impaled upon her twin members, until finally Minerva is hilted inside you, your belly pushed out even more from the sheer amount of cockflesh squeezed into your body.\n"
                + "\n"
                + "Giving you barely a minute to becoming accustomed to the harsh double stuffing your getting, it's not long enough though, tightening her hold on your body before she starts to draw her hips back, giving you a deep empty feeling from the sheer lack of cock inside you. Groaning in disappointment you rock your hips back and forth, trying to get Minerva to fuck you and fill you up again, your lust and drug addled mind wanting nothing more than to be fucked into submission by the powerful siren. Grinning at your need, your corrupted lover gives you another hard spank, firmly imprinting her hand print right on your ass. “<i>Someone’s needy, do you want my cocks that badly, you really are a terrible slut, aren't you?</i>“ Never being one to turn down a hungry needy slut like you Minerva grips your hips and slams her twin cocks back into your body, filling your ass and cunt with her thick flesh again.\n"
                + "\n"
                + "Keeping a tight hold on your body, Minerva begins your next round of brutal sex, the dominating herm leaning down over you as she thrusts her hips into yours, spearing her two thick throbbing lengths oh so deep into your body again and again. Now that she is actually mating with you, her tempo going fast and hard, deep thrusts powering into you and jolting your body forward with each heavy collision. Each thrust send the herm’s huge hefty nuts smacking against your body, the fertile orbs positively sloshing with Minerva’s corrupted virility. Grunting and groaning over you, the potent herm ruts you hard, drawing a constant string of pleasure filled cries and groans from you as she pistons her dicks into you. With each heavy stroke of body her tentacles sting you every so often, each sting enhancing your arousal and sensitivity until your body is in a state of near constant orgasm.\n"
                + "\n"
                + "Your body shaking and quivering under the orgasmic assault, each powerful body shaking thrust setting off another orgasm from your hyper-sensitive body, each progressive climax turning you into a moaning sweating mess of sexual fluids and raw ecstasy. Your siren lover is relentless, her rough, hard, fast thrusts battering your body and stretching your body over and over and part of you wonders if you will survive this kind of treatment with your mind intact.\n"
                + "\n"
                + "Gripping your body harder, pining your chest against the ground so that each hard pistoning violation of your body grinds your rock hard nipples against the ground, the sensation only increasing the deep pleasure coursing through you and fueling the continuous aching orgasm. Though you're too dazed and consumed by your lusts to notice Minerva’s grunting and moans grows louder, her own climatic detonation growing closer and closer, the constant spasming and squeezing of your orgasming holes. The corrupted broodmother’s sloshing sack so swollen with the prospect of filling a female in hopes of impregnating you making her churn out more and more seed, the heavy swinging scrotum swollen even larger than their normal soccerball size\n"
                + "\n"
                + "Finally after a long hard fucking Minerva’s climax has come, her hands keeping you pinned under her as she grips you tightly just to make sure you can't escape her. The sirens powerful thighs ramming her twin breeding spires right to the hilt inside your body, embedding themselves so deep in your bowles and right up into your womb. Her eyes rolling up into her head as she long prehensile tongue lolls out of her mouth when her climax finally hits her, that massive pair of seed swollen balls pulling up against Minerva’s body as she blows a truly enormous load into your poor abused body. Her cocks bulging and swelling with each huge gush of copiously thick cream of pumped into your womb and ass, your belly being forced to swell almost instantly under the flow.");
        if (player.canGetPregnant())
        {
            outputText(" With so much being crammed into your womb you’re sure this much corrupted seed could knock up even the most infertile of women.");
        }
        outputText("\n"
                + "\n"
                + "More and more floods your body, bloating your stomach until you look ready to birth triplets, Minerva’s unstoppable orgasm seeming to last forever as more and more pours from her swollen nuts till you swear you could taste it in your mouth before it finally slows and stops. keeping you pinned under her for a moment longer before gently petting your sweat dampened hair. “<i>There we go... good and stuffed full of siren cum just as a fertile female should be.");
        if (player.canGetPregnant())
        {
            outputText("Be sure to get good and pregnant for me now, give Minerva a beautiful seductive siren daughter to add to my family.");
        }
        outputText("</i>“ She says as she pets you, treating you little better than as if you were one of her harpies.\n"
                + "\n"
                + "After a further moment of staying together, Minerva pulls up and off you, pulling her twin dicks from your body and letting her seed gush out in thick globules, your cunt and ass so thoroughly stuffed you're going to be leaking her seed for hours.\n"
                + "\n");
        player.sexReward("cum", "Vaginal");
        player.sexReward("cum", "Anal");
    }
    
    //4-7= sex scene 7: ROUGH
    //Tooltip - PC gets DOMMED
    //corrupt - Minerva forces the pc to suck her off then double penetrates the female/herm pc= needs vagina
    public function sexGetDommed() : Void
    {
        clearOutput();
        outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features. Her legs, flared, wide hips. Your eyes travel past the thick twin dicks before going up her scarred toned belly and up to the siren’s E-cup breasts before finally reaching her face. Grinning to the purple and red herm you decide what you want from her.\n"
                + "\n"
                + "Without a second thought you approach Minerva and slide an arm around her bare back, your other hand reaching for her shorts and slowly giving the tight bulge a squeeze and rubbing it, the tentacled organs starting to swell almost instantly now that you're touching them. Looking into her eyes as you fondle your corrupted siren, you tell her just what you want, you want it rough this time. She snickers and growls to you softly. “<i>Oh, someone’s eager for a fucking, what's the matter, can't get enough of Minerva’s cocks?</i>“  she grins and puts an arm around you, pulling you against her. “<i>Well, since you know what you want, how about we have some fun.</i>“\n"
                + "\n"
                + "Gently pushing you back from her Minerva slides her hands up and down her body eroticly, her hands touching her bulging shorts before undoing them and striping them off, her swollen anemone-like cocks nearly bursting out as soon as they are free from their tight prison. Now that her male organs are free of their confines they rapidly swell to their maximum throbbing 20 inch length. Your eyes can’t help but be drawn to the tentacle-endowed flesh, which is squirming with her obvious excitement. She lifts her tubetop, releasing her E-cup breasts for your enjoyment. Her hands reach down and grip her twin cocks, slowly stroking them and waiving them for you teasingly\n"
                + "\n"
                + "“<i>Now lets get these clothes off you and lets get started.</i>“");
        suckMinervaShared(false);
        getDPShared();
        //No peach - no dialogue :(
        outputText("Left on the ground, you're lucky one of Minerva’s daughters doesn't have her way with you while you're passed out. Groggily your eyes open a good eight hours later, your body drenched in siren cum and soaking in a large pool of the thick white cream. Exhausted you manage to pull yourself together and head back to camp, getting cleaned up at a river along the way and finding a corrupted peach hidden in your bag as some kind of gift.");
        doNext(camp.returnToCampUseEightHours);
    }
    
    //combat loss bad end
    //-loose to Minerva 5 times in a row
    //-female/herm and male
    //-connect to end of combat upon 5 consecutive loss instead of being taken to loss sex scene
    private function badEndConsecutive() : Void
    {
        clearOutput();
        if (player.isFemale())
        {
            if (player.HP <= 0)
            {
                outputText("It’s too much, the corrupted siren is just too strong for you, beating you into a heap on the floor of her lair, looking up at the much stronger herm, you know already where this is going to go.  Shaking her head in disappointment Minerva strides toward you, her hips and tail swaying as she walks. Leaning down she reaches for you and yanks you up by front of your [armor] “<i>you are such a disappointment you know that? Some champion you turned out to be, first you turn me into this, and you're not even strong enough to subdue me.</i>“ she taunts you as she shakes you a little.");
            }
            else
            {
                outputText("It’s too much for her, Minerva’s lustful assaults getting the better of you and turning you into a horny wet mess on the floor, your [armor] soaked with your juices. You can't help but slide your hands into down and fervently start to masturbate, your fingers sliding up into your hot soaking cunt. Shaking her head in some disappointment Minerva strides toward you, her hips and tail swaying as she walks. Leaning down she reaches for you and yanks you up by front of your [armor] “<i>you are such a disappointment you know that? Some champion you turned out to be, first you turn me into this amazing creature, and you're not even strong enough to resist me.</i>“ she taunts you as she shakes you a little.");
            }
            outputText("\n"
                    + "\n"
                    + "After a moment she grins and licks her dark lips. “<i>Losing again and again, you know, I think you want to lose, what is it? Have you gone and gotten yourself addicted to Minerva’s cum and venom? Why you're no better than one of those chained up harpy sluts. Maybe I should just finish the job and keep you here with them?</i>“ Minerva says before laughing and stripping you of your [armor], exposing your naked body to air. Dragging your defeated body over towards the defiled spring and dumping you on the moss.\n"
                    + "\n"
                    + "Standing over you Minerva strokes her hardening twin dicks, the two thick spires swelling and quickly becoming their usual intimidating size at the prospect of adding you to her harem of eager slaves. “<i>C’mon now, you know how this is going to go. You can feel it, can't you, the burning hunger inside you, telling you to submit and accept your fate as one of my hungry cocksleves.</i>“ The dominant herm says as she strokes her twin dicks and looks down at you with an aggressive grin. You had been trying so hard to resist the feeling as you fought Minerva over and over, each loss to the siren making you crave defeat ever more, telling you to submit to her so you could gorge yourself on her addictive cream.\n"
                    + "\n"
                    + "Licking your lips as you look up at the siren you gulp and look away resisting once again, your defiance only seeming to amuse Minerva. Slathering her hand in her sticky musky precum Minerva leans down and brushes her hand across your face, giving you a big dose of her scent just to tease you. The thick heady smell of her fluids sends a shiver up your spine and makes your mouth water even while deepening the special thirst you feel, the craving growing needier than ever. “<i>You like that smell, don't you, it calls to you, telling you I have just what you need to sate your thirst, come on, submit to your better, your siren master.</i>“ She says as she pulls you close with her slick hand, bringing you to her cocks and rubbing your face against their fat bloated purple tips, the finger thick tentacles squirming against you and stinging you. The hot sensation of her venom once again entering your body makes you gasp with need, hands shaking you turn your head opening your mouth and taking the head of one of her huge cocks into your mouth, the last of your willpower gone.");
        }
        else
        {
            if (player.HP <= 0)
            {
                outputText("It’s too much, the corrupted siren is just too strong for you, beating you into a heap on the floor of her lair, looking up at the much stronger herm, you know already where this is going to go.  Shaking her head in disappointment Minerva strides toward you, her hips and tail swaying as she walks. Leaning down she reaches for you and yanks you up by front of your [armor] “<i>You are such a disappointment you know that? Some champion you turned out to be, first you turn me into this, and then you're not even strong enough to subdue me.</i>“ she taunts you as she shakes you a little.");
            }
            else
            {
                outputText("It’s too much for her, Minerva’s lustful assaults getting the better of you and turning you into a horny wet mess on the floor, your [armor] soaked with your juices. You can't help but slide your hands into down and fervently start to masturbate, Your hands desperately freeing your pants straining erection before you start to jerk off your [cock]");
                if (player.hasVagina())
                {
                    outputText(", your fingers sliding up into your hot soaking cunt");
                }
                outputText(". Shaking her head in some disappointment Minerva strides toward you, her hips and tail swaying as she walks. Leaning down she reaches for you and yanks you up by front of your [armor] “<i>you are such a disappointment you know that? Some champion you turned out to be, first you turn me into this amazing creature, and you're not even strong enough to resist me.</i>“ she taunts you as she shakes you a little.");
            }
            outputText("\n"
                    + "\n"
                    + "Grinning at you, clearly thinking of something she drags you along, your body too weak to fight back. Finally stopping at a chest she pulled out a few items before tossing you to the bound-wing harpies. “<i>Hold them down, keep them still and you will get a good reward from your mistress</i>“ she tells the harpies who excitedly hold you in place. Holding a bag in one hand she strokes her dicks with the other while he nudges your crotch with her foot. “<i>You call yourself male/herm, pathetic, you're not worthy of having that dick of yours, I bet you've sucked off more loads from me than you have ever put in a woman’s belly. Now these</i>“ she says as she strokes and waves her twin spires of hard bloated cockmeat at you. “<i>These are real dicks, and really balls full of fertile baby making cream, I’m clearly the superior breeder here. You know what you are? You're nothing but some cock craving, cum hungry slut that just wants more of my thick creamy siren sperm.</i>“\n"
                    + "\n"
                    + "Minerva leans down as your held in place by the harpies, reaching out she forces your mouth open before popping at least a dozen small pink eggs inside, rubbing your throat to make you swallow them. Not done with you yet Minerva pulls out a few bottles of unpurified succubi milk, opening your mouth again she drains one after another down your throat, the magical effects of the things she’s feeding you taking hold.\n"
                    + "\n"
                    + "The first thing you notice is a fiery heat pooling in your groin, your painfully hard [cocks] slowly shrinking down smaller and smaller until your male genitalia are no more, in their place though is a beautiful virgin cunt, oh so tight and ready to be deflowered by your superior siren mistress. Your body growing hot as it rounds out, growing more and more feminine and losing all traces of your former masculinity while your new pussy and womb grow ever more fertile and ready to breed. The heat shifts to your chest finally, your [chest] growing more and more, swelling out into a pair of bountiful breasts that could suckle dozens of babies.\n"
                    + "\n"
                    + "Appraising your new much more feminine looks Minerva looks you up and down, her eyes trailing over your hips, thighs, belly, breasts and finally your face and your succulent pouty lips. \"Ahhh, much better. Don't worry about that little dick you had, I have enough for both of us, now....\" Minerva trails off as she takes hold of her dicks and strokes them big dollops of syrupy precum beading right on the tip waiting for you. \"It’s time you paid tribute to your siren mistress, you crave it, don't you, my yummy sticky pre, my thick creamy cum that makes you feel so good. Be a good girl... And suck...my...fat...cocks!\" Minerva says forcefully as she pushes her dicks close to your face and mouth, the big drops of pre looking like they are just bout to drip down, their heady scene flowing into your nose and sending a deep shiver up your spine.\n"
                    + "\n"
                    + "Your eyes are locked on the big bulbous head of the herm’s twin penises, each of them a angry bright violet with a thick, marble sized bead of clear liquid dripping slowly from the tip. Shivering with need and ever-growing thirst, you try to resist, your hands visibly shaking as you slowly reach up and take hold of the thick pricks. Feeling your hands on her sensitive organs brings a sharky grin to Minerva's face, the corrupted siren nodding to the two loyal addicts and silently telling them to let you go, that you no longer need to be restrained. Now that you're free from the harpies you could try to escape, but escape is far from what you want now. The teasing, the scent and presence of what you're craving so close to you is too much, your addiction to the siren broodmother too strong to resist her anymore.\n"
                    + "\n"
                    + "Opening your mouth wide your let your tongue slide out, not wanting to waste any of that delicious precum you slowly drag your tongue across each of Minerva’s fat pricks, shuddering at the wonderful musky flavor of her thick syrupy pre as it rolls across your taste buds.  You lick them over and over before sucking on the tip of each, trying to suck the goodness from both of the hard rods. Desperate for more you open as wide as you can before engulfing one of the bloated purple heads inside your warm wet mouth, your tongue licking all around the head and sucking greedily, so hungry for more of what Minerva’s fertile cocks can offer you.");
        }
        //Shared part
        outputText("\n"
                + "\n"
                + "Seeing you now with your mouth wrapped around one of her two dicks draws a deep cackle from Minerva, declaring her victory over you before grabbing your head and pulling onto her dick. “<i>come now slut, you’ve taken my cock so many times you can easily take more than that.</i>“ she says down to you as she thrust her hips forward, forcing inch after inch down your throat until your face is pressed against her crotch.</i>“Yesss that’s it, take all over Minerva’s big dick just like a real slut, you know your place don't you.</i>“ she says as she gently strokes your face, her perverse praise giving you a strange feeling of pride in knowing that you bring your siren mistress such pleasure.\n"
                + "\n"
                + "Not even giving you a chance this time Minerva takes great pleasure in taking you, face fucking you hard and forcing you to endure her brutal love. Instinctively your hands move to her heavy soccer ball sized sack, your hands massaging the hefty sperm filled orbs with an almost reverent gentleness as if you were now paying tribute to your winged fertility goddess. Your mistress holding your head as she fucks your face, pulling her drool covered dick in and out of you, her daughters and even the harpies looking on with reverent looks as you're slowly broken in as part of her harem.\n"
                + "\n"
                + "Your oral training lasting nearly an hour until you can feel her, Minerva’s great swollen sack rippling before pulling up in a great orgasm, the dominant siren groaning and holding your head against her crotch as she blows her copious load into your belly while her other dick douses you in sperm, drenching your naked body in her seed. As she cums inside you her thick cumvein bulging with each ejaculation, her thick heavy sperm blasting right down your throat and into your stomach and giving you the drug like high you have been craving and bloating your belly from the sheer amount being pumped into your body. Slowly you can feel your mistress pulling out of you, still cumming down your throat, then your mouth, giving you mouthful after mouthful of her rich addictive cream that you gulp down gratefully.\n"
                + "\n"
                + "Pulling fully out of you Minerva strokes herself as she looks down at you as she hungrily licks the spent seed from your body. “<i>Oh you love it, don't you, you really can't get enough can you.</i>“ she says with a smirk before pulling you up, dragging you against her dicks, letting her tentacles sting you. “<i>Don't worry, after all you’ve done for me, I won't let you go, I’ll take good care of you pet. I’ll keep you full of the cum you crave and big and pregnant with my beautiful sirens for the rest of your life. Doesn't that sound nice?</i>“ she half asks, not really expecting a real answer, only getting a dumb nod before you lean down to suckle the tip of one of her dicks, earning you a gentle stroke from your mistress.\n"
                + "\n"
                + "Not finished with you yet, Minerva forces you down and begins your real training, the insatiable corrupted herm fucking your body over and over, making you suck her off, stretching your pussy and ass with her twin cocks, not barely stopping to hold herself oh so deep inside you each time she cums. By the time she’s done you’re a broken drugged out heap on the ground, your body bloated and looking like you're already going to birth triplets with the sheer amount of siren sperm packed inside you, your skin and hair and body drenched and laying in a thick creamy puddle of jizz. By now you're completely and hopelessly addicted to Minerva even if you wanted to you could not leave, to leave would mean withdrawal and death for you. You know your fate now, your home is here, led by a leash at Minerva’s side, doomed to be forever pregnant with her superior offspring and fed her potent cum right from the source every day.\n"
                + "\n"
                + "Despite your fate you couldn't be happier at being kept as the siren broodmothers personal pet, your safe, fed all the addictive cum and pumped full of aphrodisiac venom that you want, your womb used to birth daughter after beautiful strong daughter. Your mistress even allows your own daughters to take you, letting them spit roast you and fill you with their incestuous cum.\n"
                + "\n"
                + "They almost never let you rest properly, if it wasn't Minerva herself raping your mind and body it was her daughters. The corrupted sirens grew up very quickly, reaching maturity in days. The young sirens took turns with you in pairs, one double stuffing you from behind while a second would force one of her cocks down your throat and between your milk swollen tits. Like their mother they take great pleasure in taking you over and over, their repeated violations only deepening your already severe dependence on their drugged cum and arousing aphrodisiac venom.\n"
                + "\n"
                + "No matter how much they fucked you, came in you and made you drink their sperm you could never get enough. Your body needed them, always hungering for the cocks of your siren masters to be stuffing every hole you hand. Your broken, siren addicted mind couldn’t be happier with how things turned out, even as you are made to give birth for the rest of your life and swell the numbers of sirens that now seek to dominate the land.");
        player.sexReward("cum", "VaginalAnal");
        EventParser.gameOver();
    }
    
    public function corruptMinervaBirth() : Void
    {
        clearOutput();
        minervaScene.minervaSprite();
        minervaScene.pregnancy.knockUpForce();  //Clear pregnancy.  
        outputText("<b>Minerva just gave birth! No scene written for you, sorry.</b>");
        ++flags[kFLAGS.MINERVA_CHILDREN];
        if (flags[kFLAGS.MINERVA_CHILDREN] <= 4)
        {
            sceneHunter.print("But some other scenes surely can change...");
        }
        doNext(camp.returnToCampUseOneHour);
    }
    
    public function corruptPlayerBirth(womb : Int = 0) : Void
    {
        minervaScene.minervaSprite();
        player.cuntChange(40, true, false, true, womb);
        outputText("<b>You're birthing Minerva's siren kid! No scene written for you, sorry.</b>");
        if (player.hasMutation(IMutationsLib.GoblinOvariesIM))
        {
            flags[kFLAGS.MINERVA_CHILDREN] += 2;
        }
        else
        {
            flags[kFLAGS.MINERVA_CHILDREN]++;
        }
        flags[kFLAGS.TIMES_BIRTHED_SHARPIES]++;
        if (flags[kFLAGS.MINERVA_CHILDREN] <= 4)
        {
            sceneHunter.print("But some other scenes surely can change...");
        }
    }

    public function new()
    {
        super();
    }
}


