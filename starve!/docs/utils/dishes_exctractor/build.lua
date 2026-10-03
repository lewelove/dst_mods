-- Domain layer: merges the vanilla snapshot with the mod declarations.

local SKIP = {
    beefalofeed = true,
    beefalotreat = true,
    batnosehat = true,
    dustmeringue = true,
}

local STAT_FIELDS = { "hunger", "sanity", "health" }

-- Field display order for the JSON writer; unknown keys fall back to alphabetical.
local ORDER = {
    name = 1,
    vanilla = 2,
    modded = 3,
    hunger = 1,
    sanity = 2,
    health = 3,
    rot_time = 4,
    cook_time = 5,
    priority = 6,
}

local build = { ORDER = ORDER }

local function vanilla_of(food)
    return {
        hunger = food.hunger,
        sanity = food.sanity or 0,
        health = food.health,
        rot_time = food.perishtime or 0,
        cook_time = food.cooktime or 0,
        priority = food.priority or 0,
    }
end

local function diff(vanilla, record, prefab)
    local modded = {}

    local stats = record.stats[prefab]
    if stats then
        for _, field in ipairs(STAT_FIELDS) do
            if stats[field] ~= vanilla[field] then
                modded[field] = stats[field]
            end
        end
    end

    local priority = record.priority[prefab]
    if priority ~= nil and priority ~= vanilla.priority then
        modded.priority = priority
    end

    return modded
end

function build.run(game, record)
    local data = {}

    for prefab, food in pairs(game.foods) do
        if not SKIP[prefab] then
            local name = game.strings.NAMES[string.upper(prefab)]
            if name == nil then
                error("no display name for dish '" .. prefab .. "'")
            end

            local entry = { name = name, vanilla = vanilla_of(food) }
            local modded = diff(entry.vanilla, record, prefab)
            if next(modded) ~= nil then
                entry.modded = modded
            end

            data[prefab] = entry
        end
    end

    return data
end

return build
