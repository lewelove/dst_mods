# Notes for the Starve! Mod

Here I will outline ideas and notes for this mod to implement in the future.

## Characters

- Speed up global hunger drain by 20%.
- Remove ALL favorite food multipliers.

## Scarcity

- Regrowth times for normal berry bushes, juicy berry bushes, and banana trees is multiplied by 2.
- Regular farm plants and giant plants have their crop seeds stripped from their loot drops. We now can multiply crops only by giant plants dropping multiple crops, and feeding them to a bird.
- Birds refuse to accept any food item with health value < 0.
- Bees and Killer Bees drop 0 Honey and their stinger drop chance is reduced to 10%.
- Bee Boxes are moved to `TECH.LOST` (crafting them requires blueprints dropped by the Bee Queen at a 100% chance).
- Ponds/shoals have their maximum fish pool capped at 3, starting fish at 3, and respawn timers multiplied by 6x.
- All Spiders can drop only a single Monster Meat with 16.6% chance and nothing else.
- All Werepigs drop only 1 Meat and 1 Pig Skin

## Design Constraints

The philosophy behind food rebalance lies in:

### Nerfing **ingredients** to make them essentially useless consumed in their raw/cooked form.

No raw/cooked ingredients that have a [food value](https://dontstarve.wiki.gg/wiki/Food_Value/DST) (with exceptions and reasons listed below) can have any Sanity > 0 OR Health > 3.

Exceptions:

- All Mushrooms. Reason: We strip all Hunger from them. Mushrooms now act as pure drugs.

For the reasons of being rare and indicating use in healing recipes these ingredients are excluded:
- [Cactus Flower](https://dontstarve.wiki.gg/wiki/Cactus_Flower/DST)
- [Royal Jelly](https://dontstarve.wiki.gg/wiki/Royal_Jelly)
- [Butter](https://dontstarve.wiki.gg/wiki/Butter/DST) -> 12.5, 0, 8
- [Milky Whites](https://dontstarve.wiki.gg/wiki/Milky_Whites)
- Cooked Koalefant Trunk -> 37.5, 0, 8
- Glow Berry

Tiering dishes by how hard they are to obtain, drastically nerfing health of easy ones to be not more than 20, leaving 40 for mid tier, and 60 for top tier.
Buffing dishes that are almost never cooked due to their hardness to obtain.
