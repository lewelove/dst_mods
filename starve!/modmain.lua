local GLOBAL = GLOBAL
local require = GLOBAL.require

GLOBAL.TUNING.AFFINITY_15_CALORIES_TINY = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_SMALL = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_MED = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_LARGE = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_HUGE = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_SUPERHUGE = 1.0

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local SPICES = { "_spice_garlic", "_spice_sugar", "_spice_chili", "_spice_salt" }

local function ChangeStats(prefab, hu, s, h)
    AddPrefabPostInit(prefab, function(inst)
        if inst ~= nil and inst.components.edible ~= nil then
            inst.components.edible.hungervalue = hu
            inst.components.edible.sanityvalue = s
            inst.components.edible.healthvalue = h
        end
    end)
    
    for _, spice in ipairs(SPICES) do
        AddPrefabPostInit(prefab .. spice, function(inst)
            if inst ~= nil and inst.components.edible ~= nil then
                inst.components.edible.hungervalue = hu
                inst.components.edible.sanityvalue = s
                inst.components.edible.healthvalue = h
            end
        end)
    end
end

local function DisableEating(inst)
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end

local ICE_ALLOW_LIST = {}
local TWIGS_ALLOW_LIST = {}

local function AllowIce(recipe_name)
    ICE_ALLOW_LIST[recipe_name] = true
end

local function AllowTwigs(recipe_name)
    TWIGS_ALLOW_LIST[recipe_name] = true
end

local function ChangeRecipe(dish_or_tbl, test_fn, priority)
    local dish, recipe_test, prio
    if type(dish_or_tbl) == "table" then
        dish = dish_or_tbl.dish
        recipe_test = dish_or_tbl.recipe or dish_or_tbl.test
        prio = dish_or_tbl.priority
    else
        dish = dish_or_tbl
        recipe_test = test_fn
        prio = priority
    end

    local cooking = GLOBAL.require("cooking")
    for _, recipe_table in pairs(cooking.recipes) do
        if recipe_table and recipe_table[dish] then
            if recipe_test ~= nil then
                recipe_table[dish].test = recipe_test
            end
            if prio ~= nil then
                recipe_table[dish].priority = prio
            end
        end
    end
end
GLOBAL.ChangeRecipe = ChangeRecipe

-- The order of ingredients is based on https://dontstarve.wiki.gg/wiki/Food_Value/DST

---- Meats ----

-- Morsel
-- 12.5, -10, 0
ChangeStats("smallmeat", 12.5, -10, 0)

-- Drumstick
-- 12.5, -10, 0
-- ChangeStats("drumstick", 12.5, -10, 0)

-- Frog Legs
-- 12.5, -10, 0
-- ChangeStats("froglegs", 12.5, -10, 0)

-- Small Jerky
-- 12.5, 10, 8 -> 12.5, 10, 1
ChangeStats("smallmeat_dried", 12.5, 10, 1)

-- Naked Nostrils
-- 12.5, -10, 3 -> 12.5, -10, 0
ChangeStats("batnose", 12.5, -10, 0)

-- Charred Nostrils
-- 18.75, 0, 8 -> 18.75, 0, 1
ChangeStats("batnose_cooked", 18.75, 0, 1)

-- Batilisk Wing
-- 12.5, -10, 3 -> 12.5, -10, 0
ChangeStats("batwing", 12.5, -10, 0)

-- Cooked Batilisk Wing
-- 18.75, 0, 8 -> 18.75, 0, 1
ChangeStats("batwing_cooked", 18.75, 0, 1)

-- Meat
-- 25, -10, 1
-- ChangeStats("meat", 25, -10, 1)

-- Cooked Meat
-- 25, 0, 3 -> 25, 0, 1
ChangeStats("cookedmeat", 25, 0, 1)

-- Jerky
-- 25, 15, 20 -> 25, 15, 1
ChangeStats("meat_dried", 25, 15, 1)

-- Monster Meat
-- 18.75, -15, -20 -> 18.75, -20, -20
ChangeStats("monstermeat", 18.75, -20, -20)

-- Cooked Monster Meat
-- 18.75, -10, -3 -> 18.75, -10, -10
ChangeStats("cookedmonstermeat", 18.75, -10, -10)

-- Monster Jerky
-- 18.75, -5, -3 -> 18.75, -5, -5
ChangeStats("monstermeat_dried", 18.75, -5, -5)

--- Fish ---

-- Small Fishy Jerky
-- 12.5, 20, 15 -> 12.5, 20, 1
ChangeStats("fishmeat_small_dried", 12.5, 20, 1)

-- Fish Steak
-- 25, 0, 8 -> 25, 0, 1
ChangeStats("fishmeat_cooked", 25, 0, 1)

-- Fish Jerky
-- 25, 15, 20 -> 25, 20, 1
ChangeStats("fishmeat_dried", 25, 20, 1)

-- Eel
-- 9.375, 0, 3 -> 9.375, 0, 1
ChangeStats("eel", 9.375, 0, 1)

-- Cooked Eel
-- 12.5, 0, 8 -> 12.5, 0, 1
ChangeStats("eel_cooked", 12.5, 0, 1)

--- Other Meat ---

-- Summer Koalefant Trunk
-- 37.5, 0, 30 -> 25, -10, 1
ChangeStats("trunk_summer", 25, -10, 1)

-- Winter Koalefant Trunk
-- 37.5, 0, 30 -> 25, -10, 1
ChangeStats("trunk_winter", 25, -10, 1)

-- Cooked Koalefant Trunk
-- 75, 0, 40 -> 37.5, 0, 8
ChangeStats("trunk_cooked", 37.5, 0, 8)

-- Heat Gland
-- 18.75, -10, 8 -> 12.5, -10, 1
ChangeStats("mitegland", 12.5, -10, 1)

-- Cooked Heat Gland
-- 25, -5, 20 -> 18.75, -5, 1
ChangeStats("mitegland_cooked", 18.75, -5, 1)

---- Fruits ----

-- Berries
-- 9.375, 0, 0 -> 6.25, 0, 0
ChangeStats("berries", 6.25, 0, 0)

-- Roasted Berries
-- 12.5, 0, 1 -> 9.375, 0, 1
ChangeStats("berries_cooked", 9.375, 0, 1)

-- Juicy Berries
-- 12.5, 0, 1 -> 6.25, 0, 1
ChangeStats("berries_juicy", 6.25, 0, 1)

-- Roasted Juicy Berries
-- 18.75, 0, 3 -> 9.375, 0, 1
ChangeStats("berries_juicy_cooked", 9.375, 0, 1)

-- Fig
-- 12.5, 0, 0 -> 6.25, 0, 0
ChangeStats("fig", 6.25, 0, 0)

-- Cooked Fig
-- 18.75, 0, 1 -> 9.375, 0, 1
ChangeStats("fig_cooked", 9.375, 0, 1)

-- Lesser Glow Berry
-- 12.5, -10, 3 -> 6.25, -10, 1
ChangeStats("wormlight_lesser", 6.25, -10, 1)

-- Pomegranate
-- 9.375, 0, 3 -> 6.25, 0, 0
ChangeStats("pomegranate", 6.25, 0, 0)

-- Sliced Pomegranate
-- 12.5, 0, 20 -> 9.375, 0, 1
ChangeStats("pomegranate_cooked", 9.375, 0, 1)

-- Durian
-- 25, -5, -3 -> 6.25, -20, -20
ChangeStats("durian", 6.25, -20, -20)

-- Extra Smelly Durian
-- 25, -5, 0 -> 9.375, -50, 1
ChangeStats("durian_cooked", 9.375, -50, 1)

-- Dragon Fruit 
-- 9.375, 0, 3 -> 6.25, 0, 0
ChangeStats("dragonfruit", 6.25, 0, 0)

-- Prepared Dragon Fruit 
-- 12.5, 0, 20 -> 9.375, 0, 3
ChangeStats("dragonfruit_cooked", 9.375, 0, 3)

-- Banana
-- 12.5, 0, 1 -> 6.25, 0, 0
ChangeStats("cave_banana", 6.25, 0, 0)

-- Cooked Banana
-- 12.5, 0, 3 -> 9.375, 0, 1
ChangeStats("cave_banana_cooked", 9.375, 0, 1)

-- Watermelon
-- 12.5, 5, 3 -> 6.25, 0, 0
ChangeStats("watermelon", 6.25, 0, 0)

-- Grilled Watermelon
-- 12.5, 7.5, 1 -> 9.375, 0, 1
ChangeStats("watermelon_cooked", 9.375, 0, 1)

-- Glow Berry
-- 25, -10, 11 -> 9.375, -10, 11
ChangeStats("wormlight", 9.375, -10, 11)

-- Nightberry
-- 12.5, -20, -8 -> 6.25, -20, -8
ChangeStats("ancientfruit_nightvision", 6.25, -20, -8)

-- Cooked Nightberry
-- 18.8, -5, -3 -> 9.375, -5, -3
ChangeStats("ancientfruit_nightvision_cooked", 9.375, -5, -3)

---- Veggies ----

-- Red Cap
-- 12.5, 0, -20 -> 0, 0, -20
ChangeStats("red_cap", 0, 0, -20)

-- Cooked Red Cap
-- 0, -10, 1
-- ChangeStats("red_cap_cooked", 0, -10, 1)

-- Green Cap
-- 12.5, -50, 0 -> 0, -50, 0
ChangeStats("green_cap", 0, -50, 0)

-- Cooked Green Cap
-- 0, 15, -1 -> 0, 15, -3
ChangeStats("green_cap_cooked", 0, 15, -3)

-- Blue Cap
-- 12.5, -15, 20 -> 0, -15, 8
ChangeStats("blue_cap", 0, -15, 8)

-- Cooked Blue Cap
-- 12.5, 10, -3 -> 0, 10, -3
ChangeStats("blue_cap_cooked", 0, 10, -3)

-- Moon Shroom
-- 12.5, 10, 0 -> 0, 20, 0
ChangeStats("moon_cap", 0, 20, 0)

-- Cooked Moon Shroom
-- -12.5, -10, 0 -> 0, -20, 0
ChangeStats("moon_cap_cooked", 0, -20, 0)

-- Kelp Fronds
-- 9.375, -10, -1

-- Cooked Kelp Fronds
-- 9.375, -5, 0

-- Dried Kelp Fronds
-- 9.375, 10, 1

-- Cactus Flower
-- 12.5, 5, 8

-- Carrot
-- 12.5, 0, 1 -> 6.25, 0, 0
ChangeStats("carrot", 6.25, 0, 0)

-- Roasted Carrot
-- 12.5, 0, 3 -> 9.375, 0, 1
ChangeStats("carrot_cooked", 9.375, 0, 1)

-- Corn
-- 25, 0, 3 -> 3.125, -5, 0
ChangeStats("corn", 3.125, -5, 0)

-- Popcorn
-- 12.5, 0, 3 -> 3.125, 0, 0
ChangeStats("corn_cooked", 3.125, 0, 0)

-- Eggplant
-- 25, 0, 8 -> 3.125, -5, 0
ChangeStats("eggplant", 3.125, -5, 0)

-- Braised Eggplant
-- 25, 0, 20 -> 9.375, 0, 1
ChangeStats("eggplant_cooked", 9.375, 0, 1)

-- Pumpkin
-- 37.5, 0, 3 -> 3.125, -5, 0
ChangeStats("pumpkin", 3.125, -5, 0)

-- Hot Pumpkin
-- 37.5, 0, 8 -> 9.375, 0, 1
ChangeStats("pumpkin_cooked", 9.375, 0, 1)

-- Mandrake
-- 75, 0, 60 -> made inedible
AddPrefabPostInit("mandrake", DisableEating)

-- Lichen
-- 12.5, -5, 3 -> 3.125, -15, 1
ChangeStats("cutlichen", 3.125, -15, 1)
-- todo: Make Inedible Value of 1

-- Cactus Flesh
-- 12.5, -5, -3 -> 3.125, -10, -10
ChangeStats("cactus_meat", 3.125, -10, -10)

-- Cooked Cactus Flesh
-- 12.5, 15, 1 -> 9.375, 0, 1
ChangeStats("cactus_meat_cooked", 9.375, 0, 1)

-- Asparagus
-- 12.5, 0, 3 -> 6.25, 0, 0
ChangeStats("asparagus", 6.25, 0, 0)

-- Cooked Asparagus
-- 25, 0, 3 -> 9.375, 0, 1
ChangeStats("asparagus_cooked", 9.375, 0, 1)

-- Ripe Stone Fruit
-- 12.5, 0, 1 -> 6.25, 0, 1
ChangeStats("rock_avocado_fruit_ripe", 6.25, 0, 1)

-- Cooked Stone Fruit
-- 12.5, 0, 3 -> 9.375, 0, 3
ChangeStats("rock_avocado_fruit_ripe_cooked", 9.375, 0, 3)

-- Garlic
-- 9.375, -10, 0 -> 3.125, -10, 3
ChangeStats("garlic", 3.125, -10, 3)

-- Roasted Garlic
-- 9.375, -5, 1 -> 6.25, -5, 3
ChangeStats("garlic_cooked", 6.25, -5, 3)

-- Onion
-- 9.375, -10, 0 -> 3.125, -10, 0
ChangeStats("onion", 3.125, -10, 0)

-- Roasted Onion
-- 9.375, -5, 1 -> 6.25, -5, 1
ChangeStats("onion_cooked", 6.25, -5, 1)

-- Pepper
-- 9.375, -15, -20 -> 6.25, -15, -20
ChangeStats("pepper", 6.25, -15, -20)

-- Roasted Pepper
-- 9.375, -10, -3 -> 9.375, -10, -3
ChangeStats("pepper_cooked", 9.375, -10, -3)

-- Potato
-- 12.5, -5, -3 -> 3.125, -5, 0
ChangeStats("potato", 3.125, -5, 0)

-- Roasted Potato
-- 25, 0, 20 -> 9.375, 0, 1
ChangeStats("potato_cooked", 9.375, 0, 1)

-- Toma Root
-- 12.5, 0, 20 -> 9.375, 0, 0
ChangeStats("tomato", 9.375, 0, 0)

-- Roasted Toma Root
-- 12.5, 0, 20 -> 9.375, 0, 1
ChangeStats("tomato_cooked", 9.375, 0, 1)

---- Other ----

-- Butter
-- 25, 0, 40 -> 12.5, 0, 8
ChangeStats("butter", 12.5, 0, 8)

-- Ice
-- 2.3, 0, 0.5 -> 0, 0, 1
ChangeStats("ice", 0, 0, 1)

-- Butterfly Wings
-- 9.375, 0, 8 -> 3.125, 0, 1
ChangeStats("butterflywings", 3.125, 0, 1)

-- Moon Moth Wings
-- 9.375, 15, 8 -> 3.125, 15, 1
ChangeStats("moonbutterflywings", 3.125, 15, 1)

-- Roasted Birchnut
-- 9.375, 0, 1 -> 2.375, 0, 1
ChangeStats("acorn_cooked", 2.375, 0, 1)

-- Glommer's Goop
-- 9.375, -50, 40 -> 0, -50, 20
ChangeStats("glommerfuel", 0, -50, 20)

-- Seeds
-- 4.6875, 0, 0 -> 2.375, 0, 0
ChangeStats("seeds", 2.375, 0, 0)

-- Toasted Seeds
-- 4.6875, 0, 1 -> 2.375, 0, 1
ChangeStats("seeds_cooked", 2.375, 0, 1)

-- Crop Seeds
-- 9.375, 0, 0.5 -> 2.375, 0, 0
ChangeStats("carrot_seeds", 2.375, 0, 0)
ChangeStats("corn_seeds", 2.375, 0, 0)
ChangeStats("dragonfruit_seeds", 2.375, 0, 0)
ChangeStats("durian_seeds", 2.375, 0, 0)
ChangeStats("eggplant_seeds", 2.375, 0, 0)
ChangeStats("pomegranate_seeds", 2.375, 0, 0)
ChangeStats("pumpkin_seeds", 2.375, 0, 0)
ChangeStats("watermelon_seeds", 2.375, 0, 0)
ChangeStats("asparagus_seeds", 2.375, 0, 0)
ChangeStats("tomato_seeds", 2.375, 0, 0)
ChangeStats("potato_seeds", 2.375, 0, 0)
ChangeStats("onion_seeds", 2.375, 0, 0)
ChangeStats("pepper_seeds", 2.375, 0, 0)
ChangeStats("garlic_seeds", 2.375, 0, 0)


---- Dishes ---- https://dontstarve.wiki.gg/wiki/Dishes ----

-- [Amberosia](https://dontstarve.wiki.gg/wiki/Amberosia)
AllowTwigs("dustmeringue")

-- [Asparagusgazpacho](https://dontstarve.wiki.gg/wiki/Asparagazpacho)
AllowIce("asparagugazpacho")

-- [Asparagus Soup](https://dontstarve.wiki.gg/wiki/Asparagus_Soup/DST)
-- Allow ice
-- 18.75, 5, 20 -> 18.75, 5, 10
ChangeStats("asparagussoup", 18.75, 5, 10)
AllowIce("asparagussoup")

-- [Bacon and Eggs](https://dontstarve.wiki.gg/wiki/Bacon_and_Eggs/DST)
-- 75, 5, 20 -> 75, 5, 10
ChangeStats("baconeggs", 75, 5, 10)

-- [Banana Pop](https://dontstarve.wiki.gg/wiki/Banana_Pop/DST)
-- Allow ice and twigs
-- 12.5, 33, 20 -> 12.5, 33, 3
ChangeStats("bananapop", 12.5, 33, 3)
AllowIce("bananapop")
AllowTwigs("bananapop")

-- [Banana Shake](https://dontstarve.wiki.gg/wiki/Banana_Shake)
-- 2 Bananas, 1 Sweetener, 1 Ice
-- 25, 33, 8 -> 25, 33, 40
-- Priority 1 -> 30
ChangeStats("bananajuice", 25, 33, 40)
AllowIce("bananajuice")
ChangeRecipe({
    dish = "bananajuice",
    priority = 30,
    recipe = function(cooker, names, tags)
        return ((names.cave_banana or 0) + (names.cave_banana_cooked or 0) >= 2)
            and (tags.sweetener and tags.sweetener >= 1)
            and (tags.frozen and tags.frozen >= 1)
            and not tags.meat
    end,
})

-- [Barnacle Linguine](https://dontstarve.wiki.gg/wiki/Barnacle_Linguine)
-- 75, 20, 30 -> 50, 5, 20
ChangeStats("barnaclinguine", 50, 5, 20)

-- [Barnacle Nigiri](https://dontstarve.wiki.gg/wiki/Barnacle_Nigiri)
-- 37.5, 15, 40 -> 37.5, 15, 20
ChangeStats("barnaclesushi", 37.5, 15, 20)

-- [Barnacle Pita](https://dontstarve.wiki.gg/wiki/Barnacle_Pita)
-- 37.5, 5, 20 -> 37.5, 5, 3
ChangeStats("barnaclepita", 37.5, 5, 3)

-- [Beefalo Treats](https://dontstarve.wiki.gg/wiki/Beefalo_Treats)
AllowTwigs("beefalotreat")

-- [Beefy Greens](https://dontstarve.wiki.gg/wiki/Beefy_Greens)
-- 75, 5, 40 -> 37.5, 5, 40
ChangeStats("meatysalad", 37.5, 5, 40)

-- [Breakfast Skillet](https://dontstarve.wiki.gg/wiki/Breakfast_Skillet)
-- 37.5, 5, 20 -> 37.5, 5, 10
ChangeStats("veggieomlet", 37.5, 5, 10)

-- [Bunny Stew](https://dontstarve.wiki.gg/wiki/Bunny_Stew)
-- 37.5, 5, 20 -> 12.5, 5, 10
-- Priority 1 -> 0
-- (meat < 1) and (frozen >=2) -> (meat > 0) and (frozen > 0)
-- Fallback for meat+ice dishes
ChangeStats("bunnystew", 12.5, 5, 10)
AllowIce("bunnystew")
ChangeRecipe({
    dish = "bunnystew",
    priority = 0,
    recipe = function(cooker, names, tags)
        return (tags.meat and tags.meat > 0)
            and (tags.frozen and tags.frozen > 0)
            and not tags.inedible
    end,
})

-- [Butter Muffin](https://dontstarve.wiki.gg/wiki/Butter_Muffin/DST)
-- 37.5, 5, 20 -> 37.5, 5, 10
ChangeStats("butterflymuffin", 37.5, 5, 10)

-- [California Roll](https://dontstarve.wiki.gg/wiki/California_Roll/DST)
-- 37.5, 10, 20

-- [Ceviche](https://dontstarve.wiki.gg/wiki/Ceviche/DST)
-- Allow ice
-- 25, 5, 20
AllowIce("ceviche")

-- [Creamy Potato Purée](https://dontstarve.wiki.gg/wiki/Creamy_Potato_Pur%C3%A9e)
-- 37.5, 33, 20

-- [Dragonpie](https://dontstarve.wiki.gg/wiki/Dragonpie/DST)
-- 75, 5, 40 -> 37.5, 5, 20
ChangeStats("dragonpie", 37.5, 5, 20)

-- [Fancy Spiralled Tubers](https://dontstarve.wiki.gg/wiki/Fancy_Spiralled_Tubers)
-- 37.5, 15, 5 -> 18.75, 15, 3
ChangeStats("potatotornado", 18.75, 15, 3)
AllowTwigs("potatotornado")

-- [Fig-Stuffed Trunk](https://dontstarve.wiki.gg/wiki/Fig-Stuffed_Trunk)
-- 1 Fig, 1 Trunk, 0.5 Fruit, 0.5 Veggie
-- 150, 15, 60 -> 75, 15, 60
ChangeStats("koalefig_trunk", 75, 15, 60)
ChangeRecipe({
    dish = "koalefig_trunk",
    recipe = function(cooker, names, tags)
        return (names.trunk_summer or names.trunk_winter or names.trunk_cooked)
            and (names.fig or names.fig_cooked)
            and (tags.fruit and tags.fruit >= 0.5)
            and (tags.veggie and tags.veggie >= 0.5)
            and not tags.inedible
    end,
})

-- [Figatoni](https://dontstarve.wiki.gg/wiki/Figatoni)
-- 56.25, 15, 30

-- [Figgy Frogwich](https://dontstarve.wiki.gg/wiki/Figgy_Frogwich)
-- 25, 5, 20 -> 25, 33, 30
ChangeStats("frognewton", 25, 33, 30)

-- [Figkabab](https://dontstarve.wiki.gg/wiki/Figkabab)
-- Allow twigs
-- 37.5, 10, 20 -> 37.5, 5, 20
ChangeStats("figkabab", 37.5, 5, 20)
AllowTwigs("figkabab")

-- [Fish Tacos](https://dontstarve.wiki.gg/wiki/Fish_Tacos/DST)
-- 37.5, 5, 20 -> 37.5, 15, 3
ChangeStats("fishtacos", 37.5, 15, 3)

-- [Fishsticks](https://dontstarve.wiki.gg/wiki/Fishsticks)
-- Allow twigs
-- 37.5, 5, 40 -> 37.5, 5, 3
ChangeStats("fishsticks", 37.5, 5, 3)
AllowTwigs("fishsticks")

-- [Fist Full of Jam](https://dontstarve.wiki.gg/wiki/Fist_Full_of_Jam/DST)
-- Allow ice
-- 37.5, 5, 3 -> 25, 5, 3
ChangeStats("jammypreserves", 25, 5, 3)
AllowIce("jammypreserves")

-- [Flower Salad](https://dontstarve.wiki.gg/wiki/Flower_Salad/DST)
-- 12.5, 5, 40 -> 12.5, 5, 30
ChangeStats("flowersalad", 12.5, 5, 30)

-- [Froggle Bunwich](https://dontstarve.wiki.gg/wiki/Froggle_Bunwich/DST)
-- 37.5, 5, 20 -> 37.5, 5, 10
ChangeStats("frogglebunwich", 37.5, 5, 10)

-- [Frozen Banana Daiquiri](https://dontstarve.wiki.gg/wiki/Frozen_Banana_Daiquiri)
-- Allow ice
-- 18.75, 15, 30 -> 12.5, 5, 20
ChangeStats("frozenbananadaiquiri", 12.5, 5, 20)
AllowIce("frozenbananadaiquiri")

-- [Fruit Medley](https://dontstarve.wiki.gg/wiki/Fruit_Medley/DST)
-- 25, 5, 20 -> 37.5, 5, 10
ChangeStats("fruitmedley", 37.5, 5, 10)

-- [Guacamole](https://dontstarve.wiki.gg/wiki/Guacamole/DST)
-- 1 Moleworm, 1 Ripe Stone Fruit, 1 Onion, 1 Toma Root
-- 37.5, 0, 20 -> 37.5, 33, 30
-- Priority 10 -> 30
ChangeStats("guacamole", 37.5, 33, 30)
ChangeRecipe({
    dish = "guacamole",
    priority = 30,
    recipe = function(cooker, names, tags)
        return (names.mole and names.mole >= 1)
            and ((names.rock_avocado_fruit_ripe or 0) + (names.rock_avocado_fruit_ripe_cooked or 0) >= 1)
            and ((names.onion or 0) + (names.onion_cooked or 0) >= 1)
            and ((names.tomato or 0) + (names.tomato_cooked or 0) >= 1)
            and not tags.inedible
    end,
})

-- [Honey Ham](https://dontstarve.wiki.gg/wiki/Honey_Ham/DST)
-- 75, 5, 30 -> 75, 5, 20
ChangeStats("honeyham", 75, 5, 20)

-- [Honey Nuggets](https://dontstarve.wiki.gg/wiki/Honey_Nuggets/DST)
-- 37.5, 5, 20 -> 37.5, 5, 10
ChangeStats("honeynuggets", 37.5, 5, 10)

-- [Ice Cream](https://dontstarve.wiki.gg/wiki/Ice_Cream/DST)
-- Allow ice
-- 25, 50, 0
AllowIce("icecream")

-- [Jelly Salad](https://dontstarve.wiki.gg/wiki/Jelly_Salad)
-- 37.5, 50, 0

-- [Kabobs](https://dontstarve.wiki.gg/wiki/Kabobs/DST)
-- Allow twigs
-- 37.5, 5, 3
AllowTwigs("kabobs")

-- [Leafy Meatloaf](https://dontstarve.wiki.gg/wiki/Leafy_Meatloaf)
-- 37.5, 5, 8 -> 37.5, 5, 3
ChangeStats("leafloaf", 37.5, 5, 3)

-- [Lobster Bisque](https://dontstarve.wiki.gg/wiki/Lobster_Bisque)
-- 1 Wobster, 1 Garlic, >= 1 Ice
-- 25, 10, 60 -> 25, 5, 60
ChangeStats("lobsterbisque", 25, 5, 60)
AllowIce("lobsterbisque")
ChangeRecipe({
    dish = "lobsterbisque",
    recipe = function(cooker, names, tags)
        return (names.wobster_sheller_land and names.wobster_sheller_land >= 1)
            and ((names.garlic or 0) + (names.garlic_cooked or 0) >= 1)
            and (tags.frozen and tags.frozen >= 1)
            and not tags.inedible
    end,
})

-- [Lobster Dinner](https://dontstarve.wiki.gg/wiki/Lobster_Dinner)
-- 1 Wobster, 1 Butter, 1 Sweetener, 1 Garlic
-- 37.5, 50, 60
ChangeRecipe({
    dish = "lobsterdinner",
    recipe = function(cooker, names, tags)
        return (names.wobster_sheller_land and names.wobster_sheller_land >= 1)
            and (names.butter and names.butter >= 1)
            and (tags.sweetener and tags.sweetener >= 1)
            and ((names.garlic or 0) + (names.garlic_cooked or 0) >= 1)
            and not tags.meat
            and not tags.frozen
    end,
})

-- [Mandrake Soup](https://dontstarve.wiki.gg/wiki/Mandrake_Soup/DST)
-- 150, 5, 100
AllowIce("mandrakesoup")

-- [Meatballs](https://dontstarve.wiki.gg/wiki/Meatballs/DST)
-- 62.5, 5, 3

-- [Meaty Stew](https://dontstarve.wiki.gg/wiki/Meaty_Stew/DST)
-- Allow ice
-- Priority 0 -> 1
-- 120, 5, 12 -> 92.5, 5, 3
ChangeStats("bonestew", 92.5, 5, 3)
AllowIce("bonestew")
ChangeRecipe({
    dish = "bonestew",
    priority = 1,
})

-- [Melonsicle](https://dontstarve.wiki.gg/wiki/Melonsicle/DST)
-- Allow ice and twigs
-- 12.5, 20, 3 -> 12.5, 33, 3
ChangeStats("watermelonicle", 12.5, 33, 3)
AllowIce("watermelonicle")
AllowTwigs("watermelonicle")

-- [Milkmade Hat](https://dontstarve.wiki.gg/wiki/Milkmade_Hat)
AllowTwigs("batnosehat")

-- [Monster Lasagna](https://dontstarve.wiki.gg/wiki/Monster_Lasagna/DST)
-- 37.5, -20, -20
-- Priority 10 -> 99
-- (monster >= 2) -> (monster >= 1)
-- reason: fallback for any monster meat dishes
AllowIce("monsterlasagna")
AllowTwigs("monsterlasagna")
ChangeRecipe({
    dish = "monsterlasagna",
    priority = 99,
    recipe = function(cooker, names, tags)
        return (tags.monster or 0) >= 1
    end,
})

-- [Mushy Cake](https://dontstarve.wiki.gg/wiki/Mushy_Cake)
-- 25, 10, 0

-- [Pierogi](https://dontstarve.wiki.gg/wiki/Pierogi/DST)
-- 37.5, 5, 40 -> 37.5, 5, 20
ChangeStats("perogies", 37.5, 5, 20)

-- [Plain Omelette](https://dontstarve.wiki.gg/wiki/Plain_Omelette)
-- 50, 5, 3

-- [Powdercake](https://dontstarve.wiki.gg/wiki/Powdercake/DST)
-- Allow twigs
-- 0, 0, -3
AllowTwigs("powcake")

-- [Pumpkin Cookies](https://dontstarve.wiki.gg/wiki/Pumpkin_Cookies/DST)
-- 37.5, 15, 0 -> 18.75, 20, 0
ChangeStats("pumpkincookie", 18.75, 20, 0)

-- [Ratatouille](https://dontstarve.wiki.gg/wiki/Ratatouille/DST)
-- 25, 5, 3

-- [Salsa Fresca](https://dontstarve.wiki.gg/wiki/Salsa_Fresca)
-- 25, 33, 3 -> 18.75, 15, 10
ChangeStats("salsa", 18.75, 15, 10)

-- [Seafood Gumbo](https://dontstarve.wiki.gg/wiki/Seafood_Gumbo/DST)
-- 37.5, 20, 40 -> 50, 15, 30
ChangeStats("seafoodgumbo", 50, 15, 30)
AllowIce("seafoodgumbo")

-- [Soothing Tea](https://dontstarve.wiki.gg/wiki/Soothing_Tea)
-- Allow ice
-- 0, 15, 3
AllowIce("sweettea")

-- [Spicy Chili](https://dontstarve.wiki.gg/wiki/Spicy_Chili/DST)
-- 1 Meat, 1 Pepper, 2 Veggie Value
-- 37.5, 0, 20 -> 37.5, 5, 10
ChangeStats("hotchili", 37.5, 5, 10)
ChangeRecipe({
    dish = "hotchili",
    recipe = function(cooker, names, tags)
        return (tags.meat and tags.meat >= 1)
            and ((names.pepper or 0) + (names.pepper_cooked or 0) >= 1)
            and (tags.veggie and tags.veggie >= 2)
            and not tags.inedible
    end,
})

-- [Steamed Twigs](https://dontstarve.wiki.gg/wiki/Steamed_Twigs)
AllowTwigs("beefalofeed")

-- [Stuffed Eggplant](https://dontstarve.wiki.gg/wiki/Stuffed_Eggplant/DST)
-- 37.5, 5, 3

-- [Stuffed Fish Heads](https://dontstarve.wiki.gg/wiki/Stuffed_Fish_Heads)
-- Allow ice and twigs
-- 75, 0, 20 -> 75, -5, 1
ChangeStats("barnaclestuffedfishhead", 75, -5, 1)
AllowIce("barnaclestuffedfishhead")
AllowTwigs("barnaclestuffedfishhead")

-- [Stuffed Night Cap](https://dontstarve.wiki.gg/wiki/Stuffed_Night_Cap)
-- 18.75, -15, -20
-- Priority 30 -> 100
AllowTwigs("shroombait")
ChangeRecipe({ dish = "shroombait", priority = 100 })

-- [Stuffed Pepper Poppers](https://dontstarve.wiki.gg/wiki/Stuffed_Pepper_Poppers)
-- 1 Meat, 2 Peppers
-- 25, -5, 30 -> 25, -5, 20
ChangeStats("pepperpopper", 25, -5, 20)
ChangeRecipe({
    dish = "pepperpopper",
    recipe = function(cooker, names, tags)
        return (tags.meat and tags.meat >= 1)
            and ((names.pepper or 0) + (names.pepper_cooked or 0) >= 2)
            and not tags.inedible
    end,
})

-- [Surf 'n' Turf](https://dontstarve.wiki.gg/wiki/Surf_%27n%27_Turf/DST)
-- 37.5, 33, 60 -> 37.5, 33, 30
ChangeStats("surfnturf", 37.5, 33, 30)

-- [Taffy](https://dontstarve.wiki.gg/wiki/Taffy/DST)
-- 25, 15, -3

-- [Tall Scotch Eggs](https://dontstarve.wiki.gg/wiki/Tall_Scotch_Eggs)
-- 1 Tallbird Egg, 1 Pepper, 2 Veggie Value
-- 150, 5, 60 -> 92.5, 5, 40
-- Priority 10 -> 30
ChangeStats("talleggs", 92.5, 5, 40)
ChangeRecipe({
    dish = "talleggs",
    priority = 30,
    recipe = function(cooker, names, tags)
        return (names.tallbirdegg or names.tallbirdegg_cooked)
            and ((names.pepper or 0) + (names.pepper_cooked or 0) >= 1)
            and (tags.veggie and tags.veggie >= 2)
            and not tags.inedible
    end,
})

-- [Trail Mix](https://dontstarve.wiki.gg/wiki/Trail_Mix/DST)
-- Allow twigs
-- 12.5, 5, 30 -> 12.5, 5, 10
ChangeStats("trailmix", 12.5, 5, 10)
AllowTwigs("trailmix")

-- [Turkey Dinner](https://dontstarve.wiki.gg/wiki/Turkey_Dinner/DST)
-- 2 Raw Drumsticks, 2 Berries
-- 75, 5, 20 -> 75, 5, 10
ChangeStats("turkeydinner", 75, 5, 10)
ChangeRecipe({
    dish = "turkeydinner",
    recipe = function(cooker, names, tags)
        return (names.drumstick and names.drumstick >= 2)
            and (((names.berries or 0) + (names.berries_cooked or 0) + (names.berries_juicy or 0) + (names.berries_juicy_cooked or 0)) >= 2)
            and not tags.inedible
    end,
})

-- [Unagi](https://dontstarve.wiki.gg/wiki/Unagi/DST)
-- 18.75, 5, 20

-- [Vegetable Stinger](https://dontstarve.wiki.gg/wiki/Vegetable_Stinger)
-- Allow ice
-- 25, 33, 3 -> 12.5, 33, 3
ChangeStats("vegstinger", 12.5, 33, 3)
AllowIce("vegstinger")

-- [Veggie Burger](https://dontstarve.wiki.gg/wiki/Veggie_Burger)
-- 1 Leafy Meat, 1 Onion, 2 Veggie Value
-- 37.5, 33, 30 -> 37.5, 33, 40
ChangeStats("leafymeatburger", 37.5, 33, 40)
ChangeRecipe({
    dish = "leafymeatburger",
    recipe = function(cooker, names, tags)
        return (names.plantmeat or names.plantmeat_cooked)
            and ((names.onion or 0) + (names.onion_cooked or 0) >= 1)
            and (tags.veggie and tags.veggie >= 2)
            and not tags.inedible
    end,
})

-- [Waffles](https://dontstarve.wiki.gg/wiki/Waffles/DST)
-- 1 Butter, 1 Egg, 1 Berry, 1 Sweetener
-- 37.5, 5, 60 -> 37.5, 5, 60
ChangeStats("waffles", 37.5, 5, 60)
ChangeRecipe({
    dish = "waffles",
    recipe = function(cooker, names, tags)
        return (names.butter and names.butter >= 1)
            and (tags.egg and tags.egg >= 1)
            and (tags.sweetener and tags.sweetener >= 1)
            and (((names.berries or 0) + (names.berries_cooked or 0) + (names.berries_juicy or 0) + (names.berries_juicy_cooked or 0)) >= 1)
            and not tags.inedible
    end,
})


local cooking = GLOBAL.require("cooking")

local MONSTER_MEAT_ALLOW_LIST = {
    monsterlasagna = true,
    monstertartare = true,
    shroombait = true,
}

local function ApplyCrockPotRestrictions()
    for pot_type, recipe_table in pairs(cooking.recipes) do
        for name, recipe in pairs(recipe_table) do
            if name ~= "wetgoop" then
                local old_test = recipe.test
                recipe.test = function(cooker, names, tags)
                    if not MONSTER_MEAT_ALLOW_LIST[name] and (tags.monster or 0) > 0 then
                        return false
                    end
                    if not ICE_ALLOW_LIST[name] and (names.ice or 0) > 0 then
                        return false
                    end
                    if not TWIGS_ALLOW_LIST[name] and (tags.inedible or 0) > 0 then
                        return false
                    end
                    if old_test then
                        return old_test(cooker, names, tags)
                    end
                    return false
                end
            end
        end
    end
end

ChangeRecipe({ dish = "monstertartare", priority = 100 })

ApplyCrockPotRestrictions()

---- Bees Loot Changes ----

local function ModifyBeeLoot(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    if inst.components.lootdropper then
        -- Clear existing loot tables (removes honey and default stinger chances)
        inst.components.lootdropper:SetChanceLootTable(nil)
        inst.components.lootdropper:SetLoot({})
        inst.components.lootdropper.chanceloots = {}
        -- Add 5% Stinger drop
        inst.components.lootdropper:AddChanceLoot("stinger", 0.05)
    end
end

AddPrefabPostInit("bee", ModifyBeeLoot)
AddPrefabPostInit("killerbee", ModifyBeeLoot)


---- Deciduous Tree Loot Changes ----

AddPrefabPostInit("deciduoustree", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    local ld = inst.components.lootdropper
    if not ld then return end

    -- Prevent "acorn" from being added to the loot table
    local old_SetLoot = ld.SetLoot
    ld.SetLoot = function(self, loot, ...)
        if loot then
            local new_loot = {}
            for _, v in ipairs(loot) do
                if v ~= "acorn" then table.insert(new_loot, v) end
            end
            return old_SetLoot(self, new_loot, ...)
        end
        return old_SetLoot(self, loot, ...)
    end
    
    -- Manually scrub if already set (for trees already at Stage 3)
    if ld.loot then
        for i = #ld.loot, 1, -1 do
            if ld.loot[i] == "acorn" then table.remove(ld.loot, i) end
        end
    end

    -- Block hardcoded manual spawns from prefabs/deciduoustrees.lua
    local old_Spawn = ld.SpawnLootPrefab
    ld.SpawnLootPrefab = function(self, prefab, pt, ...)
        if prefab == "acorn" then return end
        return old_Spawn(self, prefab, pt, ...)
    end

    -- Hook into DropLoot to handle custom seasonal logic
    local old_Drop = ld.DropLoot
    ld.DropLoot = function(self, pt, ...)
        local ret = old_Drop(self, pt, ...)
        
        -- Custom logic for Stage 3 (Tall)
        if inst.components.growable and inst.components.growable.stage == 3 then
            local season = GLOBAL.TheWorld.state.season
            local pos = pt or inst:GetPosition()

            if season == "autumn" then
                -- 1 guaranteed + 25% chance for 1 more
                old_Spawn(self, "acorn", pos)
                if GLOBAL.math.random() < 0.25 then
                    old_Spawn(self, "acorn", pos)
                end
            elseif season == "spring" then
                -- 25% chance for 1
                if GLOBAL.math.random() < 0.25 then
                    old_Spawn(self, "acorn", pos)
                end
            end
        end
        return ret
    end
end)


---- Crops Freeze in Winter ----

local function FundamentalWinterFreeze(inst)
    if not GLOBAL.TheWorld.ismastersim then return end

    inst:DoTaskInTime(0, function(inst)
        local is_winter = GLOBAL.TheWorld.state.iswinter

        if inst.components.growable then
            local g = inst.components.growable
            if not g._starve_mod_hooked then
                g._starve_mod_hooked = true
                
                local old_Resume = g.Resume
                g.Resume = function(self, ...)
                    local ret = old_Resume(self, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:Pause()
                    end
                    return ret
                end
                
                local old_StartGrowing = g.StartGrowing
                g.StartGrowing = function(self, ...)
                    local ret = old_StartGrowing(self, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:Pause()
                    end
                    return ret
                end
            end
            if is_winter then g:Pause() end
        end

        if inst.components.timer then
            local t = inst.components.timer
            if not t._starve_mod_hooked then
                t._starve_mod_hooked = true
                
                local old_StartTimer = t.StartTimer
                t.StartTimer = function(self, name, ...)
                    local ret = old_StartTimer(self, name, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:PauseTimer(name)
                    end
                    return ret
                end
                
                local old_ResumeTimer = t.ResumeTimer
                t.ResumeTimer = function(self, name, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        return
                    end
                    return old_ResumeTimer(self, name, ...)
                end
            end
            
            if is_winter and t.timers then
                for timer_name, _ in pairs(t.timers) do
                    t:PauseTimer(timer_name)
                end
            end
        end

        inst:WatchWorldState("iswinter", function(inst, iswinter)
            if iswinter then
                if inst.components.growable then inst.components.growable:Pause() end
                if inst.components.timer and inst.components.timer.timers then
                    for timer_name, _ in pairs(inst.components.timer.timers) do
                        inst.components.timer:PauseTimer(timer_name)
                    end
                end
            else
                if inst.components.growable then inst.components.growable:Resume() end
                if inst.components.timer and inst.components.timer.timers then
                    for timer_name, _ in pairs(inst.components.timer.timers) do
                        inst.components.timer:ResumeTimer(timer_name)
                    end
                end
            end
        end)
    end)
end

if PLANT_DEFS then
    for plant_type, _ in pairs(PLANT_DEFS) do
        AddPrefabPostInit("farm_plant_" .. plant_type, FundamentalWinterFreeze)
    end
end

local weeds = { "weed_tillweed", "weed_firenettle", "weed_forgetmelots", "weed_ivy" }
for _, weed_name in ipairs(weeds) do
    AddPrefabPostInit(weed_name, FundamentalWinterFreeze)
end


---- Cactuses Freeze in Winter ----

local function DisableWildGrowth(inst)
    if inst.components.pickable then GLOBAL.MakeNoGrowInWinter(inst) end
end

AddPrefabPostInit("cactus", DisableWildGrowth)
AddPrefabPostInit("oasis_cactus", DisableWildGrowth)
