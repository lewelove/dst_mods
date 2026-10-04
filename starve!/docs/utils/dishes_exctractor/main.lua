local script_path = arg[0] or "main.lua"
local here = script_path:match("^(.*)[/\\][^/\\]*$") or "."
package.path = here .. "/?.lua;" .. package.path

local json = require("json")
local game = require("game")
local mod = require("mod")
local build = require("build")

local ROOT = here .. "/../../.."
local GAME_DIR = ROOT .. "/../databundles/scripts"
local UTILS_PATH = ROOT .. "/scripts/utils.lua"
local DISHES_PATH = ROOT .. "/features/dishes.lua"
local OUT_PATH = ROOT .. "/docs/public/dishes_data.json"

local function write_file(path, contents)
    local file, err = io.open(path, "wb")
    if not file then
        error("cannot open output '" .. path .. "': " .. tostring(err))
    end

    file:write(contents)
    file:close()
end

local function warn_unknown(game_data, record)
    local groups = {
        stats = record.stats,
        priority = record.priority,
        allow_ice = record.allow_ice,
        allow_twigs = record.allow_twigs,
    }

    for label, entries in pairs(groups) do
        for prefab in pairs(entries) do
            if game_data.foods[prefab] == nil then
                io.stderr:write("warning: mod " .. label .. " targets unknown dish '" .. prefab .. "'\n")
            end
        end
    end
end

local vanilla = game.load(GAME_DIR)
local record = mod.load(UTILS_PATH, DISHES_PATH)

warn_unknown(vanilla, record)

local data = build.run(vanilla, record)
write_file(OUT_PATH, json.encode(data, build.ORDER) .. "\n")

local total, changed = 0, 0
for _, entry in pairs(data) do
    total = total + 1
    if entry.modded then
        changed = changed + 1
    end
end

print(string.format("wrote %s (%d dishes, %d modded)", OUT_PATH, total, changed))
