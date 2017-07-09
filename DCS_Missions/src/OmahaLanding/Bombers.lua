---
-- by Johannes Strauß aka IronJockel
-- 
-- This file handels the spawning and despawning of raids.
-- It is dependend on the AllUnits file to work. 

local index = 0

local raid1 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17One"):FilterStart()
local raid2 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Two"):FilterStart()
local raid3 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Third"):FilterStart()
local raid4 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Four"):FilterStart()
local raid5 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Five"):FilterStart()
local raid6 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Six"):FilterStart()
local raid7 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Seven"):FilterStart()
local raid8 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Eight"):FilterStart()
local raid9 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Nine"):FilterStart()
local raid10 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Ten"):FilterStart()
local raid11 = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Eleven"):FilterStart()

local raids = {raid1, raid2, raid3, raid4, raid5, raid6, raid7, raid8, raid9, raid10, raid11}
local bombers = nil
---
--Spawn all Units in the given Set
local function spawnSet(set)
  set:ForEachGroup(function(group)
    group:Activate()
  end)
end

---
--Despawns all Units in the given Set
local function despawnSet(set)
  set:ForEachGroup(function(group)
    group:Destroy()
  end)
end

---
--Schedular to spawn a new raid, iterating over an array of raids and despawn the old one.
--the current raid gets saved in the bomber variable so the GermanRadar file always detects the current raid.

local spawnRaid = SCHEDULER:New(nil,function()
  if bombers then
    despawnSet(bombers)
  end
  index = index +1
  spawnSet(raids[index])
  bombers = raids[index]
end ,{}, 600, 1800 )

MESSAGE:New("Bombers loaded!",10,"Debug"):ToAll()

local jagtwaffeClients = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()

---
--counts the living bombers.
local function countAliveBombers()
  local bomberUnits = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("B17")
  local number = 0
  bombers:ForEachGroup(function(group)
    if group:IsAlive() then
      number = number + 1
    end
  end)
  return number
end

---
--generates the BRA Message for a client. Each client gets his own personal Message bassed on his own position.
local function generateMessage(bomber, client, aliveBombers)
  local bomberPos = bomber:GetCoordinate()
  local clientPos = client:GetCoordinate()
  return "B17 formation spotted at\n " ..
    bomberPos:ToStringBRA(clientPos)
    .. "\n" .. tostring(aliveBombers) .. " Bombers detected!" ,15,"BODO: "
end

---
--The schedular that calls the methods to send a message to all clients.
local radarSchedular = SCHEDULER:New(nil,function()
  if bombers then
    local aliveBombers = countAliveBombers()
    if aliveBombers > 0 then
      jagtwaffeClients:ForEachClient(function(client)
        if client:IsAlive() then
          local bomber = bombers:GetFirst()
          local bomberPos = bomber:GetCoordinate()
          local clientPos = client:GetCoordinate()
          MESSAGE:New(generateMessage(bomber,client,aliveBombers) ,15,"BODO: "):ToClient(client)
        end
      end)
    end
  end
end,{},0, 10)

MESSAGE:New("German Radar loaded!",10,"Debug"):ToAll()
