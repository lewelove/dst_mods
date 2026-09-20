# Notes for the Starve! Mod

Here I will outline ideas and notes for this mod to implement in the future.

## Crock Pot Dish Freshness

We make freshness of a dish cooked in a crock pot calculated like this:

fn get_dish_spoilage(items)
  take item with highest spoilage -> * 80%
  take average spoilage of the rest -> * 20%
  return sum

## Characters

- Speed up global hunger drain by 20%.
- Remove ALL favorite food multipliers.

## Scarcity

- Picking mushrooms deletes its entity from the world. We rely either on mushroom farms or world regrowth.
- Regrowth times for normal berry bushes, juicy berry bushes, and banana trees is multiplied by 2.
- Regular farm plants and giant plants have their crop seeds stripped from their loot drops. We now can multiply crops only by giant plants dropping multiple crops, and feeding them to a bird.
- Birds refuse to accept any food item with health value < 0.
- Bees and Killer Bees drop 0 Honey and their stinger drop chance is reduced to 10%.
- Bee Boxes are moved to `TECH.LOST` (crafting them requires blueprints dropped by the Bee Queen at a 100% chance).
- Ponds/shoals have their maximum fish pool capped at 3, starting fish at 3, and respawn timers multiplied by 6x.
- All spiders can drop only a single Monster Meat with 15% chance and nothing else.

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

[Fig-Stuffed Trunk](https://dontstarve.wiki.gg/wiki/Fig-Stuffed_Trunk)
- 1 Fig, 1 Trunk, 1 Veggie, 1 Fruit
- 150, 15, 60 -> 75, 15, 60

[Lobster Dinner](https://dontstarve.wiki.gg/wiki/Lobster_Dinner)
- 1 Wobster, 1 Butter, 1 Sweetener, 1 Garlic
- 37.5, 50, 60

[Waffles](https://dontstarve.wiki.gg/wiki/Waffles/DST)
- 1 Butter, 1 Egg, 1 Berry, 1 Sweetener
- 37.5, 5, 60 -> 37.5, 33, 60

[Guacamole](https://dontstarve.wiki.gg/wiki/Guacamole/DST)
- 1 Moleworm, 1 Ripe Stone Fruit, 1 Onion, 1 Toma Root
- 37.5, 0, 20 -> 37.5, 33, 60

#### **Health 40** Tier Dishes

[Tall Scotch Eggs](https://dontstarve.wiki.gg/wiki/Tall_Scotch_Eggs)
- 1 Tallbird Egg, 1 Pepper, 2 Veggies
- 150, 5, 60 -> 112.5, 5, 40

[Beefy Greens](https://dontstarve.wiki.gg/wiki/Beefy_Greens)
- 75, 5, 40 -> 37.5, 5, 40

[Veggie Burger](https://dontstarve.wiki.gg/wiki/Veggie_Burger)
- 1 Leafy Meat, 1 Onion, 2 Veggies
- 37.5, 33, 30 -> 37.5, 33, 40

[Banana Shake](https://dontstarve.wiki.gg/wiki/Banana_Shake)
- 2 Bananas, 1 Sweetener, 1 Ice
- 25, 33, 8 -> 25, 33, 40

[Lobster Bisque](https://dontstarve.wiki.gg/wiki/Lobster_Bisque)
- 1 Wobster, 1 Garlic, 2 Ice
- 25, 10, 60 -> 25, 10, 40

#### **Health 30** Tier Dishes

[Seafood Gumbo](https://dontstarve.wiki.gg/wiki/Seafood_Gumbo/DST)
- 37.5, 20, 40 -> 50, 15, 30

[Surf 'n' Turf](https://dontstarve.wiki.gg/wiki/Surf_%27n%27_Turf/DST)
- 37.5, 33, 60 -> 37.5, 33, 30

[Dragonpie](https://dontstarve.wiki.gg/wiki/Dragonpie/DST)
- 75, 5, 40 -> 25, 5, 30

[Flower Salad](https://dontstarve.wiki.gg/wiki/Flower_Salad/DST)
- 12.5, 5, 40 -> 12.5, 5, 30

#### **Health 20** Tier Dishes

[Figatoni](https://dontstarve.wiki.gg/wiki/Figatoni)
- 56.25, 15, 30 -> 56.25, 5, 20

[Barnacle Linguine](https://dontstarve.wiki.gg/wiki/Barnacle_Linguine)
- 75, 20, 30 -> 50, 5, 20

[Honey Ham](https://dontstarve.wiki.gg/wiki/Honey_Ham/DST)
- 75, 5, 30 -> 75, 5, 20

[Barnacle Nigiri](https://dontstarve.wiki.gg/wiki/Barnacle_Nigiri)
- 37.5, 15, 40 -> 37.5, 15, 20

[Figkabab](https://dontstarve.wiki.gg/wiki/Figkabab)
- Allow twigs
- 37.5, 10, 20 -> 37.5, 5, 20

[Pierogi](https://dontstarve.wiki.gg/wiki/Pierogi/DST)
- 37.5, 5, 40 -> 37.5, 5, 20

[Creamy Potato Purée](https://dontstarve.wiki.gg/wiki/Creamy_Potato_Pur%C3%A9e)
- 37.5, 33, 20

[California Roll](https://dontstarve.wiki.gg/wiki/California_Roll/DST)
- 37.5, 10, 20

[Figgy Frogwich](https://dontstarve.wiki.gg/wiki/Figgy_Frogwich)
- 25, 5, 20 -> 25, 15, 20

[Ceviche](https://dontstarve.wiki.gg/wiki/Ceviche/DST)
- Allow ice
- 25, 5, 20

[Stuffed Pepper Poppers](https://dontstarve.wiki.gg/wiki/Stuffed_Pepper_Poppers)
- 25, -5, 30 -> 25, -5, 20

[Frozen Banana Daiquiri](https://dontstarve.wiki.gg/wiki/Frozen_Banana_Daiquiri)
- Allow ice
- 18.75, 15, 30 -> 12.5, 5, 20

[Unagi](https://dontstarve.wiki.gg/wiki/Unagi/DST)
- 18.75, 5, 20

[Trail Mix](https://dontstarve.wiki.gg/wiki/Trail_Mix/DST)
- 12.5, 5, 30 -> 12.5, 5, 20

#### **Health 8** Tier Dishes

[Bacon and Eggs](https://dontstarve.wiki.gg/wiki/Bacon_and_Eggs/DST)
- 75, 5, 20 -> 75, 5, 8

[Fishsticks](https://dontstarve.wiki.gg/wiki/Fishsticks)
- Allow twigs
- 37.5, 5, 40 -> 37.5, 5, 8

[Barnacle Pita](https://dontstarve.wiki.gg/wiki/Barnacle_Pita)
- 37.5, 5, 20 -> 37.5, 5, 8

[Breakfast Skillet](https://dontstarve.wiki.gg/wiki/Breakfast_Skillet)
- 37.5, 5, 20 -> 37.5, 5, 8

[Butter Muffin](https://dontstarve.wiki.gg/wiki/Butter_Muffin/DST)
- 37.5, 5, 20 -> 37.5, 5, 8

[Fish Tacos](https://dontstarve.wiki.gg/wiki/Fish_Tacos/DST)
- 37.5, 5, 20 -> 37.5, 5, 8

[Honey Nuggets](https://dontstarve.wiki.gg/wiki/Honey_Nuggets/DST)
- 37.5, 5, 20 -> 37.5, 5, 8

[Spicy Chili](https://dontstarve.wiki.gg/wiki/Spicy_Chili/DST)
- 37.5, 0, 20 -> 37.5, 5, 8

[Fruit Medley](https://dontstarve.wiki.gg/wiki/Fruit_Medley/DST)
- Allow twigs
- 25, 5, 20 -> 25, 5, 8

[Asparagus Soup](https://dontstarve.wiki.gg/wiki/Asparagus_Soup/DST)
- Allow ice
- 18.75, 5, 20 -> 18.75, 5, 8

#### **Hunger** Tier Dishes

[Stuffed Fish Heads](https://dontstarve.wiki.gg/wiki/Stuffed_Fish_Heads)
- Allow twigs and ice
- 75, 0, 20 -> 75, -5, 0

#### **Sanity** Tier Dishes

[Banana Pop](https://dontstarve.wiki.gg/wiki/Banana_Pop/DST)
- Allow ice and twigs
- 12.5, 33, 20 -> 12.5, 33, 1

[Vegetable Stinger](https://dontstarve.wiki.gg/wiki/Vegetable_Stinger)
- Allow ice
- 25, 33, 3 -> 12.5, 33, 3

[Salsa Fresca](https://dontstarve.wiki.gg/wiki/Salsa_Fresca)
- 25, 33, 3

[Melonsicle](https://dontstarve.wiki.gg/wiki/Melonsicle)
- Allow ice and twigs
- 12.5, 20, 3 -> 12.5, 33, 3

