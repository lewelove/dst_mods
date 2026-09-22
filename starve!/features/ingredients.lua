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

-- Raw Fish
-- 25, 0, 8 -> 25, 0, 1
ChangeStats("fishmeat", 25, 0, 1)

-- Fish Steak
-- 25, 0, 8 -> 25, 0, 1
ChangeStats("fishmeat_cooked", 25, 0, 1)

-- Fish Jerky
-- 25, 15, 20 -> 25, 20, 1
ChangeStats("fishmeat_dried", 25, 20, 1)

-- Live Eel
-- 9.375, 0, 3 -> 9.375, 0, 1
ChangeStats("eel", 9.375, 0, 1)

-- Eel
-- 9.375, 0, 3 -> 9.375, 0, 1
ChangeStats("pondeel", 9.375, 0, 1)

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
