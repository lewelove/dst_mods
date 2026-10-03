-- Driver layer: loads untrusted Lua source (game + mod) in isolated environments.

local sandbox = {}

local function permissive_stub()
    local stub
    stub = setmetatable({}, {
        __index = function() return function() end end,
        __call = function() return stub end,
    })
    return stub
end

sandbox.permissive_stub = permissive_stub

-- Environment where unknown globals fall through to the host standard library,
-- but all writes stay local. DST scripts only need the stdlib plus a few globals.
function sandbox.new_env()
    local env = setmetatable({}, { __index = _G })
    env._G = env
    env.GLOBAL = env
    env.BRANCH = ""
    env.PLATFORM = "PC"
    env.IsConsole = function() return false end
    env.json = { encode = function() return "" end, decode = function() return {} end }
    return env
end

-- Minimal require() that resolves modules from `root` and silently stubs anything
-- missing or failing. The cache is exposed so directly-run files can be pre-seeded.
function sandbox.require_shim(env, root, opts)
    opts = opts or {}
    local cache = {}

    local function require_fn(name)
        if cache[name] ~= nil then return cache[name] end

        local path = root .. "/" .. name:gsub("%.", "/") .. ".lua"
        local chunk = loadfile(path)
        if not chunk then
            cache[name] = permissive_stub()
            return cache[name]
        end

        setfenv(chunk, env)
        local ok, result = pcall(chunk)
        if not ok then
            if opts.on_error then opts.on_error(name, result) end
            cache[name] = permissive_stub()
            return cache[name]
        end

        cache[name] = result == nil and true or result
        return result
    end

    return require_fn, cache
end

-- Runs one file in the given environment, returning (ok, result_or_error).
function sandbox.run_file(env, path)
    local chunk, err = loadfile(path)
    if not chunk then return false, err end

    setfenv(chunk, env)
    local ok, result = pcall(chunk)
    if not ok then return false, result end

    return true, result
end

return sandbox
