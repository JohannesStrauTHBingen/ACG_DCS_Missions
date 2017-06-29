
local jagtwaffe = SET_CLIENT:FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("First"):FilterStart()

jagtwaffe:ForEachClient(function(client)
  if(bombers:Count() > 0)then
    local unitPos = POINT_VEC3:NewFromVec3(client:GetClientGroupUnit():GetPointVec3())
    local bomber = bombers:GetFirst()
    local bomberPos = POINT_VEC3:NewFromVec3(bomber:GetPointVec3())
    MESSAGE:New(POINT_VEC3.ToStringBRA(bomberPos,unitPos, SETTINGS:SetA2A_BRA()),15,"RadarInfo"):ToClient(client)
  end
end)
