

--Die Gruppe die Beslan hält
local beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_Blue")
beslanOccupationGroup.HandleEvent(EVENTS.Dead, beslanLibarated())

function beslanLibarated()
  local beslanMessage = MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil)
  beslanMessage:ToAll()
  
  --Spawn Airfield Verteidigung
  local beslanDefense = SPAWN:New("Beslan_Defense")
  beslanDefense:Spawn()

  --Spawn Neue blaue Angriffs Gruppe
  local newBlueUnits = SPAWN:New("New_Blue_Units")
  newBlueUnits:Spawn()
end






