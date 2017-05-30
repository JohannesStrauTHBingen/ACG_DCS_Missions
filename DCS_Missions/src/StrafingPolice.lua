

local clientUnitSet = SET_UNIT:New()
  :FilterCategories("plane")
  :FilterStart()


local zone = ZONE:New("Airfield")

local aUnit = UNIT:Find("Unit")
aUnit:HandleEvent(EVENTS.Hit)
function aUnit:OnEventHit(EventData)
  if aUnit:IsAlive()then
    
    if aUnit:

  end
end


  