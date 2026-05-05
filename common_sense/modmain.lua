local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH

AddRecipe2(
    "armorwood", 
    { 
        Ingredient("boards", 2), 
        Ingredient("rope", 2) 
    }, 
    TECH.SCIENCE_ONE, 
    { 
        atlas = "images/inventoryimages.xml", 
        image = "armorwood.tex" 
    }, 
    { "ARMOUR" }
)

AddRecipe2(
    "hammer",
    {
        Ingredient("twigs", 3),
        Ingredient("rocks", 3),
        Ingredient("rope", 2)
    },
    TECH.SCIENCE_ONE,
    {
        atlas = "images/inventoryimages.xml",
        image = "hammer.tex"
    },
    { "TOOLS" }
)
