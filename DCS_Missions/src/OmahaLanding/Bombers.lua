---
-- by Johannes Strauﬂ aka IronJockel
-- 
-- This file handels the spawning and despawning of raids.
-- It is dependend on the AllUnits file to work. 

local index = 0
local raids = {raid1, raid2, raid3, raid4, raid5, raid6, raid7, raid8, raid9, raid10, raid11}

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
end ,{}, 900, 1800 )

MESSAGE:New("Bombers loaded!",10,"Debug"):ToAll()