local GLOBAL = GLOBAL

GLOBAL.TUNING.AFFINITY_15_CALORIES_TINY = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_SMALL = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_MED = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_LARGE = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_HUGE = 1.0
GLOBAL.TUNING.AFFINITY_15_CALORIES_SUPERHUGE = 1.0

-- Load shared utilities first so functions are available to all feature files
modimport("scripts/utils.lua")

-- Load feature modules
modimport("features/ingredients.lua")
modimport("features/dishes.lua")
modimport("features/loot.lua")
modimport("features/winter_freeze.lua")
