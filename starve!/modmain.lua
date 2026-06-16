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


---- Veggies ----

-- Cooked Asparagus
-- 25, 0, 3 -> rebalance
ChangeStats("asparagus_cooked", 12.5, 0, 8)

-- Cactus Flesh
-- 12.5, -5, -3 -> nerf
ChangeStats("cactus_meat", 9.375, -10, -10)

-- Cooked Cactus Flesh
-- 12.5, 15, 1 -> nerf
ChangeStats("cactus_meat_cooked", 12.5, 10, 1)

-- Corn
-- 25, 0, 3 -> nerf
ChangeStats("corn", 12.5, 0, 3)

-- Popcorn
-- 12.5, 0, 3 -> nerf
ChangeStats("corn_cooked", 9.375, 0, 1)

-- Eggplant
-- 25, 0, 8 -> nerf
ChangeStats("eggplant", 12.5, 0, 3)

-- Braised Eggplant
-- 25, 0, 20 -> nerf
ChangeStats("eggplant_cooked", 18.75, 0, 8)

-- Mandrake
-- 75, 0, 60 -> made inedible
AddPrefabPostInit("mandrake", DisableEating)

-- Potato
-- 12.5, -5, -3 -> nerf
ChangeStats("potato", 4.675, -5, -3)

-- Roasted Potato
-- 25, 0, 20 -> nerf
ChangeStats("potato_cooked", 12.5, 0, 3)

-- Pumpkin
-- 37.5, 0, 3 -> nerf
ChangeStats("pumpkin", 12.5, 0, 3)

-- Hot Pumpkin
-- 37.5, 0, 8 -> nerf
ChangeStats("pumpkin_cooked", 18.75, 0, 8)

-- Roasted Toma Root
-- 12.5, 0, 20 -> nerf
ChangeStats("tomato_cooked", 12.5, 0, 8)

-- Moon Shroom
-- 12.5, 10, 0 -> rebalance
ChangeStats("moon_cap", 0, 20, 0)

-- Cooked Moon Shroom
-- -12.5, -10, 0 -> rebalance
ChangeStats("moon_cap_cooked", 0, -20, 0)

-- Blue Cap
-- 12.5, -15, 20 -> nerf
ChangeStats("blue_cap", 0, -15, 20)

-- Cooked Blue Cap
-- 12.5, 10, -3 -> nerf
ChangeStats("blue_cap_cooked", 0, 10, -3)

-- Green Cap
-- 12.5, -50, 0 -> nerf
ChangeStats("green_cap", 0, -50, 0)

-- Cooked Green Cap
-- 0, 15, -1 -> nerf
ChangeStats("green_cap_cooked", 0, 15, -3)

-- Red Cap
-- 12.5, 0, -20 -> nerf
ChangeStats("red_cap", 0, 0, -20)

-- Cooked Red Cap
-- 0, -10, 1 -> buff
ChangeStats("red_cap_cooked", 0, -10, 8)



---- Fruits ----

-- Durian
-- 25, -5, -3 -> nerf
ChangeStats("durian", 12.5, -20, -20)

-- Extra Smelly Durian
-- 25, -5, 0 -> nerf
ChangeStats("durian_cooked", 18.75, -20, 0)

-- Dragon Fruit 
-- 9.375, 0, 3 -> no changes
ChangeStats("dragonfruit", 9.375, 0, 3)

-- Prepared Dragon Fruit 
-- 12.5, 0, 20 -> nerf
ChangeStats("dragonfruit", 12.5, 0, 8)

-- Sliced Pomegranate
-- 12.5, 0, 20 -> nerf
ChangeStats("pomegranate_cooked", 12.5, 0, 8)

-- Roasted Juicy Berries
-- 18.75, 0, 3 -> rebalance
ChangeStats("berries_juicy_cooked", 12.5, 0, 8)



---- Meats ----

-- Monster Meat
-- 18.75, -15, -20 -> nerf
ChangeStats("monstermeat", 18.75, -20, -20)

-- Cooked Monster Meat
-- 18.75, -10, -3 -> nerf
ChangeStats("cookedmonstermeat", 18.75, -10, -10)

-- Monster Jerky
-- 18.75, -5, -3 -> nerf
-- ChangeStats("monstermeat_dried", 12.5, -5, -3)

-- Meat
-- 25, -10, 1 -> nerf
-- ChangeStats("meat", 18.75, -10, 1)

-- Jerky
-- 25, 15, 20 -> nerf
-- ChangeStats("meat_dried", 18.75, 15, 20)

-- Drumstick
-- 12.5, -10, 0 -> nerf
-- ChangeStats("drumstick", 9.375, -10, 0)

-- Frog Legs
-- 12.5, -10, 0 -> nerf
-- ChangeStats("froglegs", 9.375, -10, 0)

-- Morsel
-- 12.5, -10, 0 -> nerf
-- ChangeStats("smallmeat", 9.375, -10, 0)

-- Small Jerky
-- 12.5, 10, 8 -> nerf
-- ChangeStats("smallmeat_dried", 12.5, 10, 8)



---- Other ----

-- Roasted Birchnut
-- 9.375, 0, 1 -> nerf
ChangeStats("acorn_cooked", 2.375, 0, 1)

-- Butterfly Wings
-- 9.375, 0, 8 -> nerf
ChangeStats("butterflywings", 4.375, 0, 3)

-- Moon Moth Wings
-- 9.375, 15, 8 -> nerf
ChangeStats("moonbutterflywings", 4.375, 15, 3)

-- Seeds
-- 4.6875, 0, 0 -> nerf
ChangeStats("seeds", 2.375, 0, 0)

-- Toasted Seeds
-- 4.6875, 0, 1 -> nerf
ChangeStats("seeds_cooked", 2.375, 0, 1)

-- Crop Seeds
-- 9.375, 0, 0.5 -> nerf
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

-- Asparagus Soup
-- 18.75, 5, 20 -> no changes
ChangeStats("asparagussoup", 18.75, 5, 20)

-- Banana Pop
-- 12.5, 33, 20 -> nerf -> reason: allowing ice
ChangeStats("bananapop", 12.5, 33, 3)

-- Banana Shake
-- 25, 33, 8 -> buff -> reason: unused
ChangeStats("bananajuice", 25, 15, 40)

-- Bunny Stew
-- 37.5, 5, 20 -> nerf -> reason: allowing ice
ChangeStats("bunnystew", 12.5, 5, 20)
-- (meat < 1) and (frozen >=2) -> buff -> reason: fallback for meat+ice dishes
for _, recipe_table in pairs(GLOBAL.require("cooking").recipes) do
    if recipe_table.bunnystew then
        recipe_table.bunnystew.test = function(cooker, names, tags)
            return (tags.meat and tags.meat > 0) 
                and (tags.frozen and tags.frozen > 0) 
                and (not tags.inedible)
        end
    end
end

-- Ceviche
-- 25, 5, 20 -> buff -> reason: unused
ChangeStats("ceviche", 37.5, 5, 40)

-- Dragonpie
-- 75, 5, 40 -> nerf -> reason: OP
ChangeStats("dragonpie", 25, 5, 40)

-- Fancy Spiralled Tubers
-- 37.5, 15, 3 -> nerf -> reason: potato nerf
ChangeStats("potatotornado", 18.75, 15, 3)

-- Fish Tacos
-- 37.5, 5, 20 -> buff -> reason: unused
ChangeStats("fishtacos", 37.5, 15, 40)

-- Fishsticks 
-- 37.5, 5, 40 -> nerf -> reason: allowing twigs
ChangeStats("fishsticks", 37.5, 5, 20)

-- Fist Full of Jam
-- 37.5, 5, 3 -> nerf -> reason: allowing ice
ChangeStats("jammypreserves", 18.75, 5, 3)

-- Frozen Banana Daiquiri
-- 18.75, 15, 30 -> nerf
ChangeStats("frozenbananadaiquiri", 12.5, 33, 20)

-- Meaty Stew
-- 150, 5, 12 -> nerf -> reason: OP + allowing ice
ChangeStats("bonestew", 92.5, 5, 12)

-- Monster Lasagna
-- 37.5, -20, -20 -> no changes
ChangeStats("monsterlasagna", 37.5, -20, -20)
-- (priority = 10) and (monster >= 2) -> buff -> reason: fallback for any monster meat dishes
for _, recipe_table in pairs(GLOBAL.require("cooking").recipes) do
    if recipe_table.monsterlasagna then
        recipe_table.monsterlasagna.priority = 99
        recipe_table.monsterlasagna.test = function(cooker, names, tags)
            return (tags.monster or 0) >= 1
        end
    end
end

-- Pumpkin Cookie
-- 37.5, 15, 0 -> rebalance -> reason: unused
ChangeStats("pumpkincookie", 18.75, 20, 0)

-- Salsa Fresca
-- 25, 33, 3 -> rebalance
ChangeStats("salsa", 18.75, 15, 20)

-- Trail Mix
-- 12.5, 5, 30 -> nerf -> reason: OP
ChangeStats("trailmix", 12.5, 5, 20)

-- Vegetable Stinger
-- 25, 33, 3 -> nerf -> reason: allowing ice
ChangeStats("vegstinger", 18.75, 33, 3)


-- -- 
-- -- , ,  -> nerf buff -> reason: 
-- ChangeStats("", , , )


local cooking = GLOBAL.require("cooking")

local MONSTER_MEAT_ALLOW_LIST = {
    monsterlasagna = true,
    monstertartare = true,
    shroombait = true,
}

local ICE_ALLOW_LIST = {
    asparagugazpacho = true,
    asparagussoup = true,
    bananapop = true,
    bunnystew = true,
    ceviche = true,
    jammypreserves = true,
    frozenbananadaiquiri = true,
    guacamole = true,
    icecream = true,
    lobsterbisque = true,
    mandrakesoup = true,
    bonestew = true,
    watermelonicle = true,
    seafoodgumbo = true,
    sweettea = true,
    vegstinger = true,
    monsterlasagna = true,
}

local TWIGS_ALLOW_LIST = {
    bananapop = true,
    potatotornado = true,
    figkabab = true,
    fishsticks = true,
    kabobs = true,
    watermelonicle = true,
    powcake = true,
    beefalofeed = true,
    monsterlasagna = true,
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

local recipes = cooking.recipes.cookpot
local portable_recipes = cooking.recipes.portablecookpot

if recipes then
    if recipes.shroombait then
        recipes.shroombait.priority = 100
    end
end

if portable_recipes then
    if portable_recipes.monstertartare then
        portable_recipes.monstertartare.priority = 100
    end
end

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
