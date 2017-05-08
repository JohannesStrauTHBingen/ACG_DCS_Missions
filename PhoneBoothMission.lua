
-- 6 Gruppen 3 pro Seite
-- Eine gruppe umzingelt Airfield (pro Seite)
-- Nach Zerstörung dieser Gruppe airfield -> forward operationg base
-- Neue Gruppe für CAS spawn
-- 1 Gruppe pro seite als Verteidigung für EWR
-- !!!AWACS UNZERSTÖRBAR MACHEN!!!


-- Idee : Einheiten können per CA bewegt werden. Also kann ein airfield wieder eingenommen werden und ein airfield ist erst nutzbar wenn es von feindlichen
-- Einheiten befreit wurde und eigene Einheiten drin stehen
-- Umsetzung: mit Zone.

blueClientSet = SET_CLIENT:FilterCoalitions("blue")
  :FilterStart()
  :ForEachClientInZone(ZONE:New("WarningZoneBlue"),
    function (clientobject)
      MessageToUnit(clientobject:GetClientGroupDCSUnit(), "You're to close to the enemy Base. Return to CombatZone if you don't want to blow up.",20, CLIENT:GetClientGroupName() + " Close at enemy Base." )
    end)
  :ForEachClientInZone(ZONE:New("spawnProtectionZoneBlue"),function(client)
    client:GetDCSGroup():Destroy()
  end)

redClientSet = SET_CLIENT:FilterCoalitions("red")
  :FilterStart()
  :ForEachClientInZone(ZONE:New("WarningZoneRed"),
    function (client)
      client:E({MessageToUnit(client:GetClientGroupDCSUnit(), "You're to close to the enemy Base. Return to CombatZone if you don't want to blow up.",20, CLIENT:GetClientGroupName() + " Close at enemy Base." )})
    end)
  :ForEachClientInZone(ZONE:New("spawnProtectionZoneRed"),function(client)
    client:E({client:GetDCSGroup():Destroy()})
  end)

-- beslanGroup is the Group that is holding the Airfield Beslan. If it gets destryoed a event is triggered
beslanGroup = GROUP:FindByName("Attacking_Forces_BLUE")
beslanGroup:HandleEvent(EVENTS.Dead, beslanLibarated())

-- All Functions that all be called if beslan gets liberated
-- It will only handle function calls!!
function beslanLibarated()
  beslanGroupSet = SET_GROUP:FilterPrefixes("Red_Beslan")
    :FilterStart():ForEachGroup(function(group)
    group:E({group:Activate()})
    end)
  MessageToAll("Red Team has managed to free Beslan! They can spawn there now.", 60 ,"Free Beslan!")
  spawnNewGroup("Garrison_Beslan")
  spawnNewGroup("Attacking_Forces_Blue_Mozdok")
end

nalchikGroup = GROUP:FindByName("Attack_Force_BLUE")
nalchikGroup:HandleEvent(EVENTS.Dead, nalchikLiberated())

function nalchikLiberated()
  nalchikGroupSet = SET_GROUP:FilterPrefixes("Blue_Nalchik")
    :FilterStart()
    :ForEachGroup(function(group)
      group:E({group:Activate()})
    end)
  MessageToAll("Blue Team has managed to free Nalchik! They can spawn there now.", 60 ,"Free Nalchik!")
  spawnNewGroup("Garrison_Nalchik")
  spawnNewGroup("Attacking_Forces_Red_Vody")
end

-- Spawned eine Gruppe mit ihr übergebenden namen.
function spawnNewGroup(groupName)
  SPAWN:New(groupName):Spawn()
end
