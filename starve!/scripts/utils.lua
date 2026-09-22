local GLOBAL = GLOBAL

SPICES = { "_spice_garlic", "_spice_sugar", "_spice_chili", "_spice_salt" }

ChangeStats = function(prefab, hu, s, h)
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

DisableEating = function(inst)
    if inst.components.edible then
        inst:RemoveComponent("edible")
    end
end

ICE_ALLOW_LIST = {}
TWIGS_ALLOW_LIST = {}

AllowIce = function(recipe_name)
    ICE_ALLOW_LIST[recipe_name] = true
end

AllowTwigs = function(recipe_name)
    TWIGS_ALLOW_LIST[recipe_name] = true
end

ChangeRecipe = function(dish_or_tbl, test_fn, priority)
    local dish, recipe_test, prio
    if type(dish_or_tbl) == "table" then
        dish = dish_or_tbl.dish
        recipe_test = dish_or_tbl.recipe or dish_or_tbl.test
        prio = dish_or_tbl.priority
    else
        dish = dish_or_tbl
        recipe_test = test_fn
        prio = priority
    end

    local cooking = GLOBAL.require("cooking")
    for _, recipe_table in pairs(cooking.recipes) do
        if recipe_table and recipe_table[dish] then
            if recipe_test ~= nil then
                recipe_table[dish].test = recipe_test
            end
            if prio ~= nil then
                recipe_table[dish].priority = prio
            end
        end
    end
end
GLOBAL.ChangeRecipe = ChangeRecipe
