# Notes for the Starve! Mod

Here I will outline ideas and notes for this mod to implement in the future.

## Crock Pot Dish Freshness

We change fire cooking freshness logic:

fn fire_cooking_spoilage(item)
  return item.spoilage * 80%

And make freshness of a dish cooked in a crock pot calculated like this:

fn get_dish_spoilage(items)
  take item with highest spoilage -> * 80%
  take average spoilage of the rest -> * 20%
  return sum

## Scarcity

- Picking mushrooms deletes its entity from the world. We rely either on mushroom farms or world regrowth.
- Regrowth times for normal berry bushes, juicy berry bushes, and banana trees is multiplied by 2.
- Regular farm plants and giant plants have their crop seeds stripped from their loot drops. We now can multiply crops only by giant plants dropping multiple crops, and feeding them to a bird.
- Birds refuse to accept any food item with health value < 0.
- Bees and Killer Bees drop 0 Honey and their stinger drop chance is reduced to 10%.
- Bee Boxes are moved to `TECH.LOST` (crafting them requires blueprints dropped by the Bee Queen at a 100% chance).
- Ponds/shoals have their maximum fish pool capped at 3, starting fish at 3, and respawn timers multiplied by 6x.

## Food Rebalance

The philosophy behind food rebalance lies in:
- Nerfing **ingredients** to make them essentially useless consumed in their raw/cooked form.
  - No raw/cooked ingredients (except mushrooms) can have any positive sanity
  - Raw fruits have Health = 1
  - Cooked fruits have Health = 3
  - Raw veggies have Health = 0 and Sanity = -5
  - Cooked veggies have Health = 3
- Tiering dishes by how hard they are to obtain, drastically nerfing health of easy ones to be not more than 20, leaving 40 for mid tier, and 60 for top tier.
- Buffing dishes that are almost never cooked due to their hardness to obtain.

### Dishes

#### **Health 60** Tier Dishes

Every Health 60 tier dish has an **exact** recipe. It means all 4 slots must be filled with a specific food / food type.

[Waffles](https://dontstarve.wiki.gg/wiki/Waffles/DST)
- 1 Butter, 1 Egg, 1 Berry, 1 Sweetener
- 37.5, 5, 60 -> 37.5, 33, 60

[Lobster Dinner](https://dontstarve.wiki.gg/wiki/Lobster_Dinner)
- 1 Wobster, 1 Butter, 1 Sweetener, 1 Garlic
- 37.5, 50, 60

#### **Health 40** Tier Dishes

[Fig-Stuffed Trunk](https://dontstarve.wiki.gg/wiki/Fig-Stuffed_Trunk)
- 1 Fig, 1 Trunk, 2 Fruits
- 150, 15, 60 -> 75, 15, 40

#### **Health 20** Tier Dishes

[Lobster Bisque](https://dontstarve.wiki.gg/wiki/Lobster_Bisque)
- 25, 10, 60 -> 25, 10, 20

[Tall Scotch Eggs](https://dontstarve.wiki.gg/wiki/Tall_Scotch_Eggs)
- 1 Tallbird Egg + 1 Pepper + 2 Veggies
- 150, 5, 60 -> 112.5, 5, 20

[Surf 'n' Turf](https://dontstarve.wiki.gg/wiki/Surf_%27n%27_Turf/DST)
- 37.5, 33, 60 -> 62.5, 33, 20

[Waffles](https://dontstarve.wiki.gg/wiki/Waffles/DST)
- 1 Butter + 1 Egg + 1 Berry + 1 Sweetener
- 37.5, 5, 60 -> 37.5, 33, 60
