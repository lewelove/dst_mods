local GLOBAL = GLOBAL
local PLANT_DEFS = GLOBAL.require("prefabs/farm_plant_defs").PLANT_DEFS

---- Crop Seeds Stripped From Farm Plants And Giant Veggies ----

local CROP_SEEDS = { seeds = true }
for _, def in pairs(PLANT_DEFS) do
    if def.seed ~= nil then
        CROP_SEEDS[def.seed] = true
    end
end

local SEED_DROP_TAGS = { "farm_plant", "oversized_veggie" }

local function WithoutSeeds(loots)
    local kept = {}
    for _, prefab in ipairs(loots) do
        if not CROP_SEEDS[prefab] then
            table.insert(kept, prefab)
        end
    end
    return kept
end

AddComponentPostInit("lootdropper", function(ld, inst)
    if GLOBAL.TheWorld == nil or not GLOBAL.TheWorld.ismastersim then return end

    local old_SetLoot = ld.SetLoot

    ld.SetLoot = function(self, loots, ...)
        if loots ~= nil and inst:HasAnyTag(SEED_DROP_TAGS) then
            loots = WithoutSeeds(loots)
        end
        return old_SetLoot(self, loots, ...)
    end
end)

