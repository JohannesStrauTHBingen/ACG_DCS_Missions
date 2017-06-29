


local jagtwaffe = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("First"):FilterStart()

MESSAGE:New("All Sets Done",10,"Debug"):ToAll()

--UNIT:GetCoordinate()
--CLIENT:GetClientGroupUnit()
--COORDINATE:GetBRAText(AngleRadians,Distance,Settings)
--
--COORDINATE:ToStringBR(TargetCoordinate,FromCoordinate,Settings)

COORDINATE:ToStringBRA(FromCoordinate)

local radarSchedular = SCHEDULER:New(nil,function()
  jagtwaffe:ForEachClient(function(client)
    if(bombers:Count() > 0)then
      local bomber = bombers:GetFirst()
      local bomberPos = bomber:GetCoordinate()
      local clientPos = client:GetCoordinate()
      
      bomberPos:ToStringBRA(clientPos)
      --COORDINATE:GetBRAText(COORDINATE:GetAngleRadians(bomberPos:GetVec3()))
      MESSAGE:New("A private Message just for you" ,15,"RadarInfo"):ToClient(client)
    end
  end)
end,{},0,30)
