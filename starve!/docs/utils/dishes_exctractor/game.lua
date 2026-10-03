-- Adapter layer: reads the vanilla game scripts as the source of truth.

local sandbox = require("sandbox")

local LOAD_ORDER = {
    "class",
    "util",
    "techtree",
    "constants",
    "tuning",
    "strings",
    "preparedfoods",
}

local game = {}

function game.load(dir)
    local verbose = os.getenv("EXTRACTOR_VERBOSE") ~= nil
    local env = sandbox.new_env()
    local require_fn, cache = sandbox.require_shim(env, dir, {
        on_error = function(name, err)
            if verbose then
                io.stderr:write("stubbed require '" .. name .. "': " .. tostring(err) .. "\n")
            end
        end,
    })
    env.require = require_fn

    local results = {}
    for _, name in ipairs(LOAD_ORDER) do
        local ok, result = sandbox.run_file(env, dir .. "/" .. name .. ".lua")
        if not ok then
            error("failed loading game script '" .. name .. "': " .. tostring(result))
        end

        results[name] = result
        cache[name] = result == nil and true or result
    end

    if results.preparedfoods == nil then
        error("preparedfoods.lua did not return a table")
    end

    return { foods = results.preparedfoods, strings = env.STRINGS }
end

return game
