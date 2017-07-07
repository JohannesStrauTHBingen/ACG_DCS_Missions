---
--by Johannes Strauß aka IronJockel
--
--This file simulates the detection of bombers and sends a message to all
--german clients
--This file doesn't work without the files AllUnits and Bombers and should be loaded into the mission atfer them! 
--

--a set of german clients
local jagtwaffeClients = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()

---
--counts the living bombers.
local function countAliveBombers()
  local bomberUnits = SET_UNIT:New():FilterPrefixes("B17")
  local number = 0
  bomberUnits:ForEachUnit(function(unit)
    if unit:IsAlive() then
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
end,{},0, 120)

MESSAGE:New("German Radar loaded!",10,"Debug"):ToAll()