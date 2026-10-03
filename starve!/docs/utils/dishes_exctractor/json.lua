-- Serialization layer: deterministic pretty JSON with explicit key ordering.

local json = {}

local ESCAPES = {
    ['"'] = '\\"',
    ["\\"] = "\\\\",
    ["\b"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
}

local function escape_string(value)
    local escaped = value:gsub('[%z\1-\31\\"]', function(char)
        return ESCAPES[char] or string.format("\\u%04x", string.byte(char))
    end)
    return '"' .. escaped .. '"'
end

local function format_number(value)
    if value ~= value or value == math.huge or value == -math.huge then
        error("cannot encode non-finite number")
    end

    if math.floor(value) == value then
        return string.format("%d", value)
    end

    return string.format("%.14g", value)
end

local function sorted_keys(value, order)
    local keys = {}
    for key in pairs(value) do
        keys[#keys + 1] = key
    end

    table.sort(keys, function(a, b)
        local ra = order[a] or math.huge
        local rb = order[b] or math.huge
        if ra ~= rb then
            return ra < rb
        end
        return a < b
    end)

    return keys
end

local function encode(value, order, depth)
    local kind = type(value)

    if kind == "table" then
        local keys = sorted_keys(value, order)
        if #keys == 0 then
            return "{}"
        end

        local inner_pad = string.rep("  ", depth + 1)
        local outer_pad = string.rep("  ", depth)
        local parts = {}

        for _, key in ipairs(keys) do
            if type(key) ~= "string" then
                error("only string keys are supported")
            end
            parts[#parts + 1] = inner_pad .. escape_string(key) .. ": " .. encode(value[key], order, depth + 1)
        end

        return "{\n" .. table.concat(parts, ",\n") .. "\n" .. outer_pad .. "}"
    end

    if kind == "number" then
        return format_number(value)
    end

    if kind == "string" then
        return escape_string(value)
    end

    if kind == "boolean" then
        return value and "true" or "false"
    end

    error("cannot encode value of type " .. kind)
end

function json.encode(value, order)
    return encode(value, order or {}, 0)
end

return json
