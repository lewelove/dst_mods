local custom_loot = {}

-- mobs: a single prefab string or a list of prefab strings
-- loot_def: table of { item_prefab = { amount = N, chance = 1.0 } }
SetCustomLoot = function(mobs, loot_def)
    if type(mobs) == "string" then
        mobs = { mobs }
    end

    for _, mob in ipairs(mobs) do
        custom_loot[mob] = loot_def
    end
end

AddComponentPostInit("lootdropper", function(self)
    local _GenerateLoot = self.GenerateLoot

    self.GenerateLoot = function(self, ...)
        local rule = custom_loot[self.inst.prefab]

        -- If this mob is in our custom table, discard vanilla loot and roll ours
        if rule ~= nil then
            local loot = {}

            for item, config in pairs(rule) do
                local amount = config.amount or 1
                local chance = config.chance ~= nil and config.chance or 1.0

                for i = 1, amount do
                    if chance >= 1.0 or math.random() <= chance then
                        table.insert(loot, item)
                    end
                end
            end

            return loot
        end

        -- Fall back to default vanilla behavior for other mobs
        return _GenerateLoot(self, ...)
    end
end)
