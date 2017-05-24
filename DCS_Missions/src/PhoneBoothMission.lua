
beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_BLUE")
beslanDefense = SPAWN:New("Garrison_Beslan")
newBlueUnits = SPAWN:New("Attacking_Forces_Blue_Mozdok")

nalchikOccupationGroup = GROUP:FindByName("Attacking_Forces_RED")
nalchikDefense = SPAWN:New("Garrison_Nalchik")
newRedUnits = SPAWN:New("Attacking_Forces_Red_Vody")

 groupIsAliveChecker , groupIsAliveCheckerID = SCHEDULER:New(nil,function()
 
  if not beslanOccupationGroup:IsAlive() then
    MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil):ToAll()
    beslanDefense:Spawn()
    newBlueUnits:Spawn()
  end
  
  if not nalchikOccupationGroup:IsAlive() then
    MESSAGE:New("Nalchik got liberated by Blue Forces. It can now serve as secondary Aifrield for Blue!",30,nil):ToAll()
    nalchikDefense:Spawn()
    newRedUnits:Spawn()
    end
end
,{}, 1 ,1)

