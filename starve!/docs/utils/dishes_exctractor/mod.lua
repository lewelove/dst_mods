-- Adapter layer: replays the mod's tuning DSL and records its declarations.

local sandbox = require("sandbox")

local MOD_REQUIRE = function()
    return { recipes = {} }
end

local mod = {}

function mod.load(utils_path, dishes_path)
    local env = sandbox.new_env()
    env.require = MOD_REQUIRE
    env.AddPrefabPostInit = function() end
    env.AddPrefabPostInitAny = function() end
    env.AddGamePostInit = function() end
    env.AddComponentPostInit = function() end
    env.AddPlayerPostInit = function() end

    local ok, err = sandbox.run_file(env, utils_path)
    if not ok then
        error("failed loading mod utils: " .. tostring(err))
    end

    local record = { stats = {}, priority = {}, allow_ice = {}, allow_twigs = {} }

    env.ChangeStats = function(prefab, hunger, sanity, health)
        record.stats[prefab] = { hunger = hunger, sanity = sanity, health = health }
    end

    env.ChangePriority = function(prefab, priority)
        record.priority[prefab] = priority
    end

    env.AllowIce = function(prefab)
        record.allow_ice[prefab] = true
    end

    env.AllowTwigs = function(prefab)
        record.allow_twigs[prefab] = true
    end

    env.ChangeRecipe = function()
        -- Recipe tests do not affect dish stats; priority now goes through ChangePriority.
    end

    ok, err = sandbox.run_file(env, dishes_path)
    if not ok then
        error("failed loading mod dishes: " .. tostring(err))
    end

    return record
end

return mod
