-- Novorossiysk und Gelendzhik sind Rot. Sochi ist Blau (Sochi allein ist sogar etwas gr��er als die beiden zusammen, daher nur ein Airfield). Maykop ist neutral - kann aber erobert werden.
-- 4 Bodengruppen, 2 f�r jede Koalition: Jeweils eine angreifende Gruppe (2 km s�dlich von Maykop - Panzer vs Panzer) und eine Verteidigungsgruppe, falls Maykop erobert wird.
-- F�r Rot hei�en die Gruppen: "Red_Attack_Force_Maykop" und "Red_Garrison_Maykop". F�r Blau: "Blue_Attack_Force_Maykop" und "Blue_Garrison_Maykop". (nat�rlich ohne "").



-- Ist eine Angreifende Gruppe komplett zerst�rt, spawnt automatisch die Verteidigungsgruppe der anderen (siegreichen) Koalition in Maykop und erobert die Airbase. Spieler k�nnen da spawnen.

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

-- Maykop kann immer wieder eroebert werden. Wenn Rot die angreifende Gruppe von Blau s�dlich von Maykop zerst�rt, bekommt er Maykop mit Verteidigungseinheiten. Will aber Blau Maykop erobern,
-- muss er erstmal die angrefiende Gruppe von Rot s�dlich von Maykop zerst�ren und dann zus�tzlich die Verteidigungsgruppe um Maykop herum.

-- F�r weitere Eroberungen von Maykop gen�gt es dann immer wieder die Vertidigungsgruppe des Gegners zu zerst�ren, damit die eigene spawnt und die Clients auch.

-- Wenn eine der angreifenden Gruppen angegriffen wird, erscheint folgendes f�r die jeweilige Koalition: "Our ground forces at Maykop are under attack! Provide CAP ASAP!" f�r 60 Sekunden.

-- Maykop wird erobert: "Good job! Maykop is ours boys!" und gleichzeitig f�r die anderen: "The enemy has captured Maykop! We must counterstrike. Maykop MUST be only ours!" f�r 60 Sekunden.

-- Das war's erstmal!