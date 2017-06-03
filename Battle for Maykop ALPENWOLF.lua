-- Novorossiysk und Gelendzhik sind Rot. Sochi ist Blau (Sochi allein ist sogar etwas größer als die beiden zusammen, daher nur ein Airfield). Maykop ist neutral - kann aber erobert werden.
-- 4 Bodengruppen, 2 für jede Koalition: Jeweils eine angreifende Gruppe (2 km südlich von Maykop - Panzer vs Panzer) und eine Verteidigungsgruppe, falls Maykop erobert wird.
-- Für Rot heißen die Gruppen: "Red_Attack_Force_Maykop" und "Red_Garrison_Maykop". Für Blau: "Blue_Attack_Force_Maykop" und "Blue_Garrison_Maykop". (natürlich ohne "").



-- Ist eine Angreifende Gruppe komplett zerstört, spawnt automatisch die Verteidigungsgruppe der anderen (siegreichen) Koalition in Maykop und erobert die Airbase. Spieler können da spawnen.

MaykopAttackingGroupRED = GROUP:FindByName("Red_Attack_Force_Maykop")
MaykopDefenceGroupBLUE = GROUP:FindByName("Blue_Garrison_Maykop")
maykopOccupied = true

MaykopAttackingGroupREDGroupIsAliveChecker , MaykopAttackingGroupREDGroupIsAliveCheckerID = SCHEDULER:New(nil,function()
 
  if maykopOccupied and not MaykopAttackingGroupRED:IsAlive()  then
    maykopOccupied = false
    function trigger.action.outSound(string computerbeep_11)
    MESSAGE:New("Good job! Maykop is ours boys!",60,nil):Blue()
    MESSAGE:New("The enemy has captured Maykop! We must counterstrike. Maykop MUST be only ours!"):ToRed()
    MaykopDefenceGroupBLUE:Spawn()
    MaykopAttackingGroupREDGroupIsAliveChecker:Stop(MaykopAttackingGroupREDGroupIsAliveChecker)
  end
  
end
,{}, 60 , 60)

MaykopAttackingGroupBLUE = GROUP:FindByName("Blue_Attack_Force_Maykop")
MaykopDefenceGroupRED = GROUP:FindByName("Red_Garrison_Maykop")
maykopOccupied = true

MaykopAttackingGroupBLUEGroupIsAliveChecker , MaykopAttackingGroupBLUEGroupIsAliveCheckerID = SCHEDULER:New(nil,function()
 
  if maykopOccupied and not MaykopAttackingGroupBLUE:IsAlive()  then
    maykopOccupied = false
    function trigger.action.outSound(string computerbeep_11)
    MESSAGE:New("Good job! Maykop is ours boys!",60,nil):ToRed()
    MESSAGE:New("The enemy has captured Maykop! We must counterstrike. Maykop MUST be only ours!"):ToBlue()
    MaykopDefenceGroupRED:Spawn()
    MaykopAttackingGroupBLUEGroupIsAliveChecker:Stop(MaykopAttackingGroupBLUEGroupIsAliveChecker)
  end
  
end
,{}, 60 , 60)

-- Maykop kann immer wieder eroebert werden. Wenn Rot die angreifende Gruppe von Blau südlich von Maykop zerstört, bekommt er Maykop mit Verteidigungseinheiten. Will aber Blau Maykop erobern,
-- muss er erstmal die angrefiende Gruppe von Rot südlich von Maykop zerstören und dann zusätzlich die Verteidigungsgruppe um Maykop herum.

-- Für weitere Eroberungen von Maykop genügt es dann immer wieder die Vertidigungsgruppe des Gegners zu zerstören, damit die eigene spawnt und die Clients auch.

-- Wenn eine der angreifenden Gruppen angegriffen wird, erscheint folgendes für die jeweilige Koalition: "Our ground forces at Maykop are under attack! Provide CAP ASAP!" für 60 Sekunden.

-- Maykop wird erobert: "Good job! Maykop is ours boys!" und gleichzeitig für die anderen: "The enemy has captured Maykop! We must counterstrike. Maykop MUST be only ours!" für 60 Sekunden.

-- Das war's erstmal!