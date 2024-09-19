package classes.items.shields;

import classes.items.Shield;

class SpiritFocus extends Shield
{
    
    public function new()
    {
        super("Spi Foc", "SpiritFocus", "spirit focus", "a spirit foci", 4, 800, 
                "This small icon with a silk ribbon is inscribed with eldritch runes and reinforces a kitsune's power and magic. (+20% to Fox Fire dmg and lust dmg, +25% to magical soulskills power)", 
                "Magic"
        );
        withBuff("spellpower", +0.2);
    }
}

