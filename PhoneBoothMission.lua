

--Die Gruppe die Beslan hält
local beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_BLUE")
beslanOccupationGroup.HandleEvent(EVENTS.Dead, beslanLibarated())

function beslanLibarated()
  local beslanMessage = MESSAGE:New("Beslan has been liberated. The Red team can now spawn there!",45,nil)
  beslanMessage:ToAll()
  
  --Spawn Airfield Verteidigung
  local beslanDefense = SPAWN:New("Garrison_Beslan")
  beslanDefense:Spawn()

  --Spawn Neue blaue Angriffs Gruppe
  local newBlueUnits = SPAWN:New("Attacking_Forces_Blue_Mozdok")
  newBlueUnits:Spawn()
end






