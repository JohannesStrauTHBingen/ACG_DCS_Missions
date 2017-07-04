
local raidOne = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17One"):FilterStart()
local raidTwo = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Two"):FilterStart()
local raidThree = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Third"):FilterStart()
local raidFour = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Four"):FilterStart()
local raidFive = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Five"):FilterStart()
local raidSix = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Six"):FilterStart()


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
end ,{}, 0,3600)
