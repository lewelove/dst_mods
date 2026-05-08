local PLANT_PREFABS = {
	"marblebean",
	"acorn",
	"pinecone",
	"twiggy_nut",
	"butterfly",
	"dug_berrybush",
	"dug_berrybush2",
	"dug_berrybush_juicy",
	"dug_sapling",
	"dug_marsh_bush",
	"dug_grass"
}

local function ApplyDeploySettings(inst)
	if inst.components.deployable then
		local spacing = GetModConfigData("plants")
		if spacing == "NONE" then
			inst.components.deployable:SetDeploySpacing(GLOBAL.DEPLOYSPACING.NONE)
		elseif spacing == "MEDIUM" then
			inst.components.deployable:SetDeploySpacing(GLOBAL.DEPLOYSPACING.MEDIUM)
		end
	end
end

for _, prefab in ipairs(PLANT_PREFABS) do
	AddPrefabPostInit(prefab, ApplyDeploySettings)
end

local buildings_cfg = GetModConfigData("buildings")
if buildings_cfg ~= "NORMAL" then
	local spacing_val = buildings_cfg == "NONE" and 0 or 1
	for _, v in pairs(GLOBAL.AllRecipes) do
		v.min_spacing = spacing_val
	end
end

local JERKS = {
	"dmgind", "coldfire", "campfire", "succulent_potted", "pottedfern",
	"ruinsrelic_plate", "ruinsrelic_chipbowl", "balloon", "minisign",
	"houndfire", "tornado", "tumbleweed"
}

local NO_BLOCK_TAGS = {
	"bird", "animal", "insect", "character", "smallcreature", "largecreature",
	"small_livestock", "projectile", "pollinator", "monster", "hostile",
	"stalkerbloom", "_follower", "_inventoryitem"
}

local function CheckCollisions(inst)
	for _, jerk_prefab in ipairs(JERKS) do
		if inst.prefab == jerk_prefab then
			inst:AddTag("NOBLOCK")
			break
		end
	end

	for _, tag in ipairs(NO_BLOCK_TAGS) do
		if inst:HasTag(tag) then
			inst:AddTag("NOBLOCK")
			break
		end
	end

	if inst:HasTag("mine") or inst:HasTag("trap") then
		inst:DoPeriodicTask(0.5, function(e)
			if e:HasTag("mineactive") then
				e:RemoveTag("noblock")
			elseif not e:HasTag("noblock") then
				e:AddTag("noblock")
			end
		end)
	end
end

AddPrefabPostInitAny(CheckCollisions)
