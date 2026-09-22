local GLOBAL = GLOBAL

---- Dishes ---- https://dontstarve.wiki.gg/wiki/Dishes ----

-- [Amberosia](https://dontstarve.wiki.gg/wiki/Amberosia)
AllowTwigs("dustmeringue")

-- [Asparagusgazpacho](https://dontstarve.wiki.gg/wiki/Asparagazpacho)
AllowIce("asparagugazpacho")

-- [Asparagus Soup](https://dontstarve.wiki.gg/wiki/Asparagus_Soup/DST)
-- 18.75, 5, 20 -> 18.75, 5, 10
ChangeStats("asparagussoup", 18.75, 5, 10)

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
