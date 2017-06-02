
local redAirfield = ZONE:New("redAirfield")

local group = GROUP:FindByName("me"):HandleEvent(EVENTS.ShootingStart)

function group:OnEventSchootingStart(EventData)
  MESSAGE:New("Handling hit",10,nil):ToAll()

  local targetGroup = GROUP:Find(EventData.target)
  if targetGroup:AllOnGround() and targetGroup:IsCompletelyInZone(redAirfield) then
    group:Destroy()
  end
  MESSAGE:New("Shot got handeled",10,nil)
end

MESSAGE:New("All lines loaded",10,nil):ToAll()
