
beslanOccupationGroup = GROUP:FindByName("Attacking_Forces_BLUE")
beslanDefense = SPAWN:New("Garrison_Beslan")
newBlueUnits = SPAWN:New("Attacking_Forces_Blue_Mozdok")

nalchikOccupationGroup = GROUP:FindByName("Attacking_Forces_RED")
nalchikDefense = SPAWN:New("Garrison_Nalchik")
newRedUnits = SPAWN:New("Attacking_Forces_Red_Vody")

 beslanGroupIsAliveChecker , beslanGroupIsAliveCheckerID = SCHEDULER:New(nil,function()
 
  if not beslanOccupationGroup:IsAlive() then
    MESSAGE:New("Beslan got liberated by Red Forces. It can now serve as secondary Aifrield for Red!",30,nil):ToAll()
    beslanDefense:Spawn()
    newBlueUnits:Spawn()
    beslanGroupIsAliveChecker:Stop(beslanGroupIsAliveCheckerID)
  end
  
end
,{}, 60 ,60)

nalchikGroupIsAliveChecker, nalchikGroupIsAliveCheckerID = SCHEDULER:New(nil,function()

  if not nalchikOccupationGroup:IsAlive() then
    MESSAGE:New("Nalchik got liberated by Blue Forces. It can now serve as secondary Aifrield for Blue!",30,nil):ToAll()
    nalchikDefense:Spawn()
    newRedUnits:Spawn()
    nalchikGroupIsAliveChecker:Stop(nalchikGroupIsAliveCheckerID)
    end
end
,{},60 ,60) 

