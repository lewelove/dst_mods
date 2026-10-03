# Notes for the Starve! Mod

Here I will outline ideas and notes for this mod to implement in the future.

## Characters

- Speed up global hunger drain by 20%.
- Remove ALL favorite food multipliers.

## Bees & Honey

- Bee Boxes are moved to `TECH.LOST` (crafting them requires blueprints dropped by the Bee Queen at a 100% chance).

This way we make honey an incredibly rare resource, farming of which requires defeating the Bee Queen. Because of this fact we boost all dishes made with it in health and sanity.

## Mobs Loot

- Bees and Killer Bees: 1 Stinger (10% chance).
- Splumonkeys: 1 Morsel + anything stolen.
- Shadow Splumonkeys: 1 Beard Hair + 1 Nightmare Fuel (50% chance) + anything stolen.
- Werepigs: 1 Meat + 1 Pig Skin.

## Structures Loot

- Beehives: 1 Honeycomb + 1 Honey.

## Seeds & Farming

- Regular farm plants and giant plants have their crop seeds stripped from their loot drops.
- ALL farm plants freeze their growth in the winter.

We now can multiply crops only by giant plants dropping multiple crops, and feeding them to a bird.

## Scarcity

- Regrowth times for normal berry bushes, juicy berry bushes, and banana trees are multiplied by 2.
- Ponds/shoals have their maximum fish pool capped at 3, starting fish at 3, and respawn timers multiplied by 6x.

## Design Constraints

The philosophy behind food rebalance lies in nerfing **ingredients** to make them essentially useless consumed in their raw/cooked form.

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
