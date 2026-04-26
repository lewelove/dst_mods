local GLOBAL = GLOBAL
local require = GLOBAL.require

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local SPICES = { "_spice_garlic", "_spice_sugar", "_spice_chili", "_spice_salt" }

local function ChangeStats(prefab, hu, s, h)
    AddPrefabPostInit(prefab, function(inst)
        if inst ~= nil and inst.components.edible ~= nil then
            inst.components.edible.hungervalue = hu
            inst.components.edible.sanityvalue = s
            inst.components.edible.healthvalue = h
        end
    end)
    
    for _, spice in ipairs(SPICES) do
        AddPrefabPostInit(prefab .. spice, function(inst)
            if inst ~= nil and inst.components.edible ~= nil then
                inst.components.edible.hungervalue = hu
                inst.components.edible.sanityvalue = s
                inst.components.edible.healthvalue = h
            end
        end)
    end
end

ChangeStats("asparagus", 12.5, 0, 3)
ChangeStats("asparagus_cooked", 12.5, 0, 8)
ChangeStats("cactus_meat", 9.375, -10, -10)
ChangeStats("cactus_meat_cooked", 12.5, 10, 0)
ChangeStats("corn", 12.5, 0, 3)
ChangeStats("corn_cooked", 9.375, 0, 1)
ChangeStats("durian", 12.5, -10, -10)
ChangeStats("durian_cooked", 18.75, -20, 0)
ChangeStats("eggplant", 12.5, 0, 3)
ChangeStats("eggplant_cooked", 18.75, 0, 8)
ChangeStats("berries_juicy_cooked", 12.5, 0, 8)
ChangeStats("potato", 9.375, -5, -3)
ChangeStats("potato_cooked", 18.75, 0, 3)
ChangeStats("pumpkin", 18.75, 0, 3)
ChangeStats("pumpkin_cooked", 25, 0, 8)
ChangeStats("tomato", 12.5, 0, 3)
ChangeStats("tomato_cooked", 12.5, 0, 8)

ChangeStats("cookedmonstermeat", 18.75, -10, -10)
ChangeStats("seeds", 2.35, 0, 0)
ChangeStats("seeds_cooked", 2.35, 0, 1)
ChangeStats("butterflywings", 4.7, 0, 3)

ChangeStats("butterflymuffin", 25, 5, 20)
ChangeStats("dragonpie", 75, 5, 20)
ChangeStats("fishtacos", 25, 15, 25)
ChangeStats("meatballs", 47.5, 5, 3)
ChangeStats("bonestew", 112.5, 5, 12)
ChangeStats("pumpkincookie", 37.5, 33, 0)
ChangeStats("asparagussoup", 18.75, 5, 30)
ChangeStats("potatotornado", 18.75, 15, 3)
ChangeStats("vegstinger", 18.75, 33, 3)

local function FundamentalWinterFreeze(inst)
    if not GLOBAL.TheWorld.ismastersim then return end

    inst:DoTaskInTime(0, function(inst)
        local is_winter = GLOBAL.TheWorld.state.iswinter

        if inst.components.growable then
            local g = inst.components.growable
            if not g._starve_mod_hooked then
                g._starve_mod_hooked = true
                
                local old_Resume = g.Resume
                g.Resume = function(self, ...)
                    local ret = old_Resume(self, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:Pause()
                    end
                    return ret
                end
                
                local old_StartGrowing = g.StartGrowing
                g.StartGrowing = function(self, ...)
                    local ret = old_StartGrowing(self, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:Pause()
                    end
                    return ret
                end
            end
            if is_winter then g:Pause() end
        end

        if inst.components.timer then
            local t = inst.components.timer
            if not t._starve_mod_hooked then
                t._starve_mod_hooked = true
                
                local old_StartTimer = t.StartTimer
                t.StartTimer = function(self, name, ...)
                    local ret = old_StartTimer(self, name, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        self:PauseTimer(name)
                    end
                    return ret
                end
                
                local old_ResumeTimer = t.ResumeTimer
                t.ResumeTimer = function(self, name, ...)
                    if GLOBAL.TheWorld.state.iswinter then
                        return
                    end
                    return old_ResumeTimer(self, name, ...)
                end
            end
            
            if is_winter and t.timers then
                for timer_name, _ in pairs(t.timers) do
                    t:PauseTimer(timer_name)
                end
            end
        end

        inst:WatchWorldState("iswinter", function(inst, iswinter)
            if iswinter then
                if inst.components.growable then inst.components.growable:Pause() end
                if inst.components.timer and inst.components.timer.timers then
                    for timer_name, _ in pairs(inst.components.timer.timers) do
                        inst.components.timer:PauseTimer(timer_name)
                    end
                end
            else
                if inst.components.growable then inst.components.growable:Resume() end
                if inst.components.timer and inst.components.timer.timers then
                    for timer_name, _ in pairs(inst.components.timer.timers) do
                        inst.components.timer:ResumeTimer(timer_name)
                    end
                end
            end
        end)
    end)
end

if PLANT_DEFS then
    for plant_type, _ in pairs(PLANT_DEFS) do
        AddPrefabPostInit("farm_plant_" .. plant_type, FundamentalWinterFreeze)
    end
end

local weeds = { "weed_tillweed", "weed_firenettle", "weed_forgetmelots", "weed_ivy" }
for _, weed_name in ipairs(weeds) do
    AddPrefabPostInit(weed_name, FundamentalWinterFreeze)
end

local function DisableWildGrowth(inst)
    if inst.components.pickable then GLOBAL.MakeNoGrowInWinter(inst) end
end
AddPrefabPostInit("cactus", DisableWildGrowth)
AddPrefabPostInit("oasis_cactus", DisableWildGrowth)

