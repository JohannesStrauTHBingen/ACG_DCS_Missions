
--Die Gruppe die Beslan hält
beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_Blue")
beslanOccupationGroup.HandleEvent(EVENTS.Dead)
function beslanOccupationGroup:OnEventDead(EventData)
  
  MESSAGE:New("OnEventDead by beslanOccuation Group got triggert!",30,nil):ToAll()
  
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
  newBlueUnits:Spawn()
end