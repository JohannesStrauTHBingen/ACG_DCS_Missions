
local jagtwaffe = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("First"):FilterStart()

MESSAGE:New("All Sets Done",10,"Debug"):ToAll()

local radarSchedular = SCHEDULER:New(nil,function()
  MESSAGE:New("starting radar",10,"Debug"):ToAll()
  jagtwaffe:ForEachClient(function(ClientObject)
    MESSAGE:New("hit" ,15,"RadarInfo"):ToAll()
    if(bombers:Count() > 0)then
      local bomber = bombers:GetFirst()
      local bomberPos = bomber:GetCoordinate()
      local clientPos = ClientObject:GetCoordinate()
      --MESSAGE:New(bomberPos.ToStringBRA(clientPos) ,15,"RadarInfo"):ToClient(client)
      --MESSAGE:New("There they are" ,15,"RadarInfo"):ToClient(client)
    end
  end)
end,{},0,30)
