
local redAirfield = ZONE:New("redAirfield")

local clientGroupSetBlue = SET_GROUP:New()
  :FilterCategories("plane")
  :FilterCoalitions("blue")
  :FilterStart()
clientGroupSetBlue:ForEachGroup(function(group)


    function group:OnEventShot(EventData)

      MESSAGE:New("Handling hit",10,nil):ToAll()
      
      group:HandleEvent(EVENTS.Shot)

      local targetGroup = GROUP:Find(EventData.target)
      if targetGroup:AllOnGround() and targetGroup:IsCompletelyInZone(redAirfield) then
        group:Destroy()
      end
    end
    MESSAGE:New("Shot got handeled",10,nil)
end)

MESSAGE:New("All lines loaded",10,nil):ToAll()
