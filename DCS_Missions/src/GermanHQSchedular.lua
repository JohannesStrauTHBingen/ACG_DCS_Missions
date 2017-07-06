
local jagtwaffe = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("B17"):FilterStart()

local function countAliveBombers()
  local number = 0
  bombers:ForEachGroup(function(group)
    if group:IsAlive() then
      number = number + group:GetSize()
    end
  end)
  return number
end

local radarSchedular = SCHEDULER:New(nil,function()
  local aliveBombers = countAliveBombers()
  if aliveBombers > 0 then
    jagtwaffe:ForEachClient(function(client)
      if client:IsAlive() then
        local bomber = bombers:GetFirst()

        while not bomber:IsAlive() do
          bombers:Remove(bomber:GetName())
          bomber = bombers:GetFirst()
        end

        local bomberPos = bomber:GetCoordinate()
        local clientPos = client:GetCoordinate()
        MESSAGE:New( "B17 Formation Spottet at\n " ..
          bomberPos:ToStringBRA(clientPos)
          .. "\n" .. tostring(aliveBombers) .. " Bombers detected!" ,15,"RadarInfo"):ToClient(client)
      end
    end)
  end
end,{},0, 300)


