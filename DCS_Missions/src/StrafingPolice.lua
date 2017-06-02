
local redAirfield = ZONE:New("redAirfield")

local clientGroupSetBlue = SET_GROUP:New()
  :FilterCategories("plane")
  :FilterCoalitions("blue")
  :FilterStart()
clientGroupSetBlue:ForEachGroup(function(group)
  
  group:HandleEvent(Events.Shot)

  function group:OnEventShot(EventData)
    local targetGroup = GROUP:Find(EventData.target)
    if targetGroup:AllOnGround() and targetGroup:IsCompletelyInZone(redAirfield) then
      group:Destroy()
    end
  end
end)
