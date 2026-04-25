local GLOBAL = GLOBAL
local require = GLOBAL.require

local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local SPICES = { "_spice_garlic", "_spice_sugar", "_spice_chili", "_spice_salt" }

local function ChangeStats(prefab, h, hu, s)
    AddPrefabPostInit(prefab, function(inst)
        if inst ~= nil and inst.components.edible ~= nil then
            inst.components.edible.healthvalue = h
            inst.components.edible.hungervalue = hu
            inst.components.edible.sanityvalue = s
        end
    end)
    
    for _, spice in ipairs(SPICES) do
        AddPrefabPostInit(prefab .. spice, function(inst)
            if inst ~= nil and inst.components.edible ~= nil then
                inst.components.edible.healthvalue = h
                inst.components.edible.hungervalue = hu
                inst.components.edible.sanityvalue = s
            end
        end)
    end
end

ChangeStats("asparagus", 3, 12.5, 0)
ChangeStats("asparagus_cooked", 8, 12.5, 0)
ChangeStats("cactus_meat", -10, 9.375, -10)
ChangeStats("cactus_meat_cooked", 0, 12.5, 10)
ChangeStats("corn", 3, 12.5, 0)
ChangeStats("corn_cooked", 1, 9.375, 0)
ChangeStats("durian", -10, 12.5, -10)
ChangeStats("durian_cooked", 0, 18.75, -20)
ChangeStats("eggplant", 3, 12.5, 0)
ChangeStats("eggplant_cooked", 8, 18.75, 0)
ChangeStats("berries_juicy_cooked", 8, 12.5, 0)
ChangeStats("potato", -3, 9.375, -5)
ChangeStats("potato_cooked", 3, 18.75, 0)
ChangeStats("pumpkin", 3, 18.75, 0)
ChangeStats("pumpkin_cooked", 8, 25, 0)
ChangeStats("tomato", 3, 12.5, 0)
ChangeStats("tomato_cooked", 8, 12.5, 0)

ChangeStats("cookedmonstermeat", -10, 18.75, -10)
ChangeStats("seeds", 0, 2.35, 0)
ChangeStats("seeds_cooked", 1, 2.35, 0)
ChangeStats("butterflywings", 3, 4.7, 0)

ChangeStats("butterflymuffin", 20, 25, 5)
ChangeStats("dragonpie", 20, 75, 5)
ChangeStats("fishtacos", 25, 25, 15)
ChangeStats("meatballs", 3, 47.5, 5)
ChangeStats("bonestew", 12, 112.5, 5)
ChangeStats("pumpkincookie", 0, 37.5, 33)
ChangeStats("asparagussoup", 30, 18.75, 5)
ChangeStats("potatotornado", 3, 18.75, 15)
ChangeStats("vegstinger", 3, 18.75, 33)

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

