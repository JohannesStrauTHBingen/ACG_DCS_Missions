

--Die Gruppe die Beslan hält


beslanDefense = SPAWN:New("Garrison_Beslan")
beslanMessage = MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil)
newBlueUnits = SPAWN:New("Attacking_Forces_Blue_Mozdok")

beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_Blue")
beslanOccupationGroup.HandleEvent(EVENTS.Dead)

function beslanOccupationGroup:OnEventDead(EventData)
  if not EventData.IniGroup:IsAlive() then
    beslanLibarated()
  end
end

function beslanLibarated()
  beslanMessage:ToAll()
  beslanDefense:Spawn()
  newBlueUnits:Spawn()
end










