---
-- by Johannes Strauß aka IronJockel
--
-- This file handels the spawning and despawning of raids and the detecting of these raids
-- by a radar.
-- No futher files are needed for this script to work.

---
--The raids put into a array for futher use.
local preFixes =  {"01", "02", "03", "04" , "05", "06", "07", "08", "09", "10", "11" }
local raids = {}
for i = 1, 11 do
  raids[i] = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17_" .. preFixes[i] ):FilterStart()
end

--index of the raid in the array.
local index = 0
--Pointer on the current raid
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
  set:ForEachGroup(
    ---@param Wrapper.Group#GROUP group
    function(group)
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
  bombers = raids[index]
  spawnSet(bombers)
end ,{}, 600, 1800 )

MESSAGE:New("Bombers loaded!",10,"Debug"):ToAll()


local jagtwaffeClients = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()

---
--counts the living bombers.
local function countAliveBombers()
  local number = 0
  bombers:ForEachGroup(function(group)
    number = number + group:GetSize()
  end)
  return number
end

---
--generates the BRA Message for a client. Each client gets his own personal Message bassed on his own position.
local function generateMessage(bomber, client, aliveBombers)
  local bomberPos = bomber:GetCoordinate()
  local clientPos = client:GetCoordinate()
  return "B17 formation spotted at\n" ..
    bomberPos:ToStringBRA(clientPos) ..
    "\n".. tostring(aliveBombers) .. " Bombers detected."
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
          MESSAGE:New(generateMessage(bomber,client,aliveBombers) ,15,"BODO"):ToClient(client)
        end
      end)
    end
  end
end,{},0, 120)

--local function getBomberPosition(group)
--  if bombers then
--    local aliveBombers = countAliveBombers()
--    if aliveBombers > 0 then
--      local bomber = bombers:getFirst()
--      local bomberPos = bomber:GetCoordinate()
--      local groupPos = group:GetCoordinate()
--      MESSAGE:New( "B17 formation spotted at\n" ..
--        bomberPos:ToStringBRA(groupPos) ..
--        "\n".. tostring(aliveBombers) .. " Bombers detected."
--        ,15,"BODO")
--    else
--      MESSAGE:New("All bombers shot down!",10,"BODO"):ToGroup(group)
--    end
--  else
--    MESSAGE:New("No Bombers detected in the area!",10,"BODO"):ToGroup(group)
--  end
--end


--local creatingMenu = SCHEDULER:New(nil,function()
--  jagtwaffe:ForEachGroup(function(group)
--    if group:IsAlive() then
--      local bodo = MENU_GROUP:New(group, "Bodo")
--      MENU_GROUP_COMMAND:New(group,"Request BRA",bodo,getBomberPosition, group)
--    end
--  end)
--end,{},0 ,10)

MESSAGE:New("German Radar loaded!",10,"Debug"):ToAll()
