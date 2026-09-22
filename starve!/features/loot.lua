local GLOBAL = GLOBAL

local function SetMobLoot(inst, loot, chanceloot)
    if not GLOBAL.TheWorld.ismastersim then return end
    local ld = inst.components.lootdropper
    if not ld then return end

    ld:SetChanceLootTable(nil)
    ld:SetLoot(loot or {})
    ld.chanceloot = nil
    if chanceloot then
        for _, entry in ipairs(chanceloot) do
            ld:AddChanceLoot(entry[1], entry[2])
        end
    end
end

-- [Bee](https://dontstarve.wiki.gg/wiki/Bee)
AddPrefabPostInit("bee", function(inst)
    SetMobLoot(inst, nil, {
        { "stinger", 0.1 },
    })
end)

-- [Killer Bee](https://dontstarve.wiki.gg/wiki/Killer_Bee)
AddPrefabPostInit("killerbee", function(inst)
    SetMobLoot(inst, nil, {
        { "stinger", 0.1 },
    })
end)

-- [Spider](https://dontstarve.wiki.gg/wiki/Spider/DST)
AddPrefabPostInit("spider", function(inst)
    SetMobLoot(inst, nil, {
        { "monstermeat", 0.25 },
    })
end)

-- [Spider Warrior](https://dontstarve.wiki.gg/wiki/Spider_Warrior/DST)
AddPrefabPostInit("spider_warrior", function(inst)
    SetMobLoot(inst, nil, {
        { "monstermeat", 0.25 },
        { "spidergland", 0.25 },
    })
end)

-- [Cave Spider](https://dontstarve.wiki.gg/wiki/Cave_Spider/DST)
AddPrefabPostInit("spider_hider", function(inst)
    SetMobLoot(inst, nil, {
        { "monstermeat", 0.5 },
        { "spidergland", 0.25 },
    })
end)

-- [Spitter](https://dontstarve.wiki.gg/wiki/Spitter/DST)
AddPrefabPostInit("spider_spitter", function(inst)
    SetMobLoot(inst, nil, {
        { "monstermeat", 0.5 },
        { "spidergland", 0.25 },
    })
end)

-- [Dangling Depth Dweller](https://dontstarve.wiki.gg/wiki/Dangling_Depth_Dweller/DST)
AddPrefabPostInit("spider_dropper", function(inst)
    SetMobLoot(inst, { "silk" }, nil)
end)

-- [Shattered Spider](https://dontstarve.wiki.gg/wiki/Shattered_Spider)
AddPrefabPostInit("spider_moon", function(inst)
    SetMobLoot(inst, nil, {
        { "moonglass", 0.25 },
    })
end)

-- [Nurse Spider](https://dontstarve.wiki.gg/wiki/Nurse_Spider)
AddPrefabPostInit("spider_healer", function(inst)
    SetMobLoot(inst, { "spidergland" }, {
        { "monstermeat", 0.5 },
    })
end)

-- [Sea Strider](https://dontstarve.wiki.gg/wiki/Sea_Strider)
AddPrefabPostInit("spider_water", function(inst)
    SetMobLoot(inst, { "twigs" }, {
        { "monstermeat", 0.25 },
    })
end)

-- [Werepig](https://dontstarve.wiki.gg/wiki/Werepig/DST)
local function PatchPigLoot(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    local ld = inst.components.lootdropper
    if not ld then return end

    local old_SetLoot = ld.SetLoot
    ld.SetLoot = function(self, loot, ...)
        if inst:HasTag("werepig") or (loot and #loot == 3 and loot[1] == "meat" and loot[2] == "meat" and loot[3] == "pigskin") then
            loot = { "meat", "pigskin" }
        end
        return old_SetLoot(self, loot, ...)
    end

    if inst:HasTag("werepig") then
        ld:SetLoot({ "meat", "pigskin" })
    end
end

AddPrefabPostInit("pigman", PatchPigLoot)
AddPrefabPostInit("pigguard", PatchPigLoot)

AddPrefabPostInit("moonpig", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot({ "meat", "pigskin" })
    end
end)

-- [Koalefant](https://dontstarve.wiki.gg/wiki/Koalefant)
AddPrefabPostInit("koalefant_summer", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot({ "meat", "meat", "meat", "meat", "trunk_summer" })
    end
end)

AddPrefabPostInit("koalefant_winter", function(inst)
    if not GLOBAL.TheWorld.ismastersim then return end
    if inst.components.lootdropper then
        inst.components.lootdropper:SetLoot({ "meat", "meat", "meat", "meat", "trunk_winter" })
    end
end)

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
                if GLOBAL.math.random() < 0.5 then
                    old_Spawn(self, "acorn", pos)
                end
            elseif season == "spring" then
                -- 25% chance for 1
                if GLOBAL.math.random() < 0.5 then
                    old_Spawn(self, "acorn", pos)
                end
            end
        end
        return ret
    end
end)
