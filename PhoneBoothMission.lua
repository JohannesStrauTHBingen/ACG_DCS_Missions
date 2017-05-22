

--Die Gruppe die Beslan hält
<<<<<<< HEAD
beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_Blue")
beslanOccupationGroup.HandleEvent(EVENTS.Dead)
function beslanOccupationGroup:OnEventDead(EventData)
  if not EventData.IniGroup:IsAlive() then
    beslanLibarated()
  end
end

beslanDefense = SPAWN:New("Beslan_Defense")
newBlueUnits = SPAWN:New("New_Blue_Units")
beslanMessage = MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil)

function beslanLibarated()
  beslanMessage:ToAll()
  --Spawn Airfield Defense
  beslanDefenseGroup = beslanDefense:Spawn()
  --Spawn new Blue Attack forces
=======
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
>>>>>>> origin/master
  newBlueUnits:Spawn()
end










