

MESSAGE:New("Script loaded",30,nil):ToAll()

--Die Gruppe die Beslan hält
beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_BLUE")

MESSAGE:New("Reaching EVENT handler",30,nil):ToAll()

beslanOccupationGroup:HandleEvent(EVENTS.Dead)
function beslanOccupationGroup:OnEventDead(EventData)

	if not EventData.IniGroup:IsAlive() then
		 beslanLibarated()
	end
 end

MESSAGE:New("Reaching beslanLibarated",30,nil):ToAll()

beslanDefense = SPAWN:New("Garrison_Beslan")
newBlueUnits = SPAWN:New("Attacking_Forces_Blue_Mozdok")



function beslanLibarated()
  MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil):ToAll()
  --Spawn Airfield Defense
  beslanDefenseGroup = beslanDefense:Spawn()
  --Spawn new Blue Attack forces
  newBlueUnits:Spawn()
end

MESSAGE:New("Reaching SCHEDULAR loaded",30,nil):ToAll()

 local debugSchedular = SCHEDULER:New(nil,
 function()
	MESSAGE:New("Attacking Forces Blue Gone",30,nil):ToAll()
	beslanOccupationGroup:Destroy()
 end, {}, 10 
 )
	
MESSAGE:New("last Line",30,nil):ToAll()