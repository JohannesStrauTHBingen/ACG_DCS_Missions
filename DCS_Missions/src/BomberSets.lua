
local raidOne = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17One"):FilterStart()
local raidTwo = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Two"):FilterStart()
local raidThree = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Third"):FilterStart()
local raidFour = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Four"):FilterStart()
local raidFive = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Five"):FilterStart()
local raidSix = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Six"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("B17"):FilterStart()

local function SpawnRaid(raidSet)
  raidSet:ForEachGroup(function(group)
    group:Activate()
  end)
end

local raids = {raidOne, raidTwo, raidThree, raidFour, raidFive, raidSix}
local index = 0

local spawnRaidSchedular = SCHEDULER:New(nil,function()
  index = index + 1
  SpawnRaid(raids[index])
  bombers = raids[index]
  MESSAGE:New("Bombers Arrived in XA50.\n protect them on their way to Chippelle and back!", 15, "HQ: "):ToBlue()
end ,{}, 0,3600)

local operationArea = ZONE:New("DespawnBombers")
local despawnRaid = SCHEDULER:New(nil, function()
  bombers:ForEachGroupNotInZone(operationArea,function(group)
    group:Destroy()
    end)
end,{}, 1800, 10)
