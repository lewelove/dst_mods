local GLOBAL = GLOBAL

-- Bees
SetCustomLoot({ "bee", "killerbee" }, {
  stinger = { amount = 1, chance = 0.05 },
})

-- [Spider](https://dontstarve.wiki.gg/wiki/Spider/DST)
SetCustomLoot("spider", {
  monstermeat = { amount = 1, chance = 0.166 },
})

-- [Spider Warrior](https://dontstarve.wiki.gg/wiki/Spider_Warrior/DST)
SetCustomLoot("spider_warrior", {
  monstermeat = { amount = 1, chance = 0.166 },
  spidergland = { amount = 1, chance = 0.25 },
})

-- [Cave Spider](https://dontstarve.wiki.gg/wiki/Cave_Spider/DST)
SetCustomLoot("spider_hider", {
  monstermeat = { amount = 1, chance = 0.5 },
  spidergland = { amount = 1, chance = 0.25 },
})

-- [Spitter](https://dontstarve.wiki.gg/wiki/Spitter/DST)
SetCustomLoot("spider_spitter", {
  monstermeat = { amount = 1, chance = 0.5 },
  spidergland = { amount = 1, chance = 0.25 },
})

-- [Dangling Depth Dweller](https://dontstarve.wiki.gg/wiki/Dangling_Depth_Dweller/DST)
SetCustomLoot("spider_dropper", {
  silk = { amount = 1, chance = 1.0 },
})

-- [Shattered Spider](https://dontstarve.wiki.gg/wiki/Shattered_Spider)
SetCustomLoot("spider_moon", {
  moonglass = { amount = 1, chance = 0.166 },
})

-- [Nurse Spider](https://dontstarve.wiki.gg/wiki/Nurse_Spider)
SetCustomLoot("spider_healer", {
  monstermeat = { amount = 1, chance = 0.166 },
  spidergland = { amount = 1, chance = 1.0 },
})

-- [Sea Strider](https://dontstarve.wiki.gg/wiki/Sea_Strider)
SetCustomLoot("spider_water", {
  monstermeat = { amount = 1, chance = 0.166 },
  twigs = { amount = 2, chance = 1.0 },
})

-- []()
-- []()

-- Werepig
SetCustomLoot("werepig", {
  meat = { amount = 1, chance = 1.0 },
  pigskin = { amount = 1, chance = 1.0 },
})

-- Koalefants
SetCustomLoot("koalefant_summer", {
  meat = { amount = 4, chance = 1.0 },
  trunk_summer = { amount = 1, chance = 1.0 },
})

SetCustomLoot("koalefant_winter", {
  meat = { amount = 4, chance = 1.0 },
  trunk_winter = { amount = 1, chance = 1.0 },
})

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
