
-- 6 Gruppen 3 pro Seite
-- Eine gruppe umzingelt Airfield (pro Seite)
-- Nach Zerstörung von diese Gruppe airfield -> forward operationg base
-- Neue gruppe für CAS spawn
-- 2 gruppe pro seite als verteidigung für EWR
-- !!!!AWACS UNZERSTÖRBAR MACHEN!!!!


--Idee : Einheiten können per CA bewegt werden. Also kann ein airfield wieder eingenommen werden und ein airfield ist erst nutzbar wenn es von feindlichen
--Einheiten befreit wurde und eigene Einheiten drin stehen
--Umsetzung: mit Zone.

spawnProtectionZoneRed = ZONE:New("SpawnProtectionZoneRed")
spawnProtectionZoneBlue = ZONE:New("SpawnProtectionZoneBlue")

allRedsPlayers = {"Red1", "Red2"}
allBluesPlayers = {"Blue1", "Blue2"}


--This function will destroy the player that enters a zone
--It is meant to make a safe spawn area for each coalison
function destroyIfInZone(givenZone, givenPlayers)
  for player in givenPlayers do
    local unit = GROUP:FindByName(player)
    if(unit:IsInZone(givenZone))then
      unit:Destroy()
    end
  end
end

keepOutScheduler = new SCHEDULER:New(nil,
  function()
    destroyIfInZone(spawnProtectionZoneBlue,allRedsPlayers)
    destroyIfInZone(spawnProtectionZoneRed,allBluesPlayers)
  end
  ,{},30, 20)


--Array von einheiten die activiert werden können.
beslanInactiveUnits  =  {"mig21_1", "mig21_2"}

--beslanGroup is the Group that is holding the Airfield Beslan. If it gets destryoed a event is triggered
beslanGroup = GROUP:FindByName("BeslanCaptureGroup")
beslanGroup:HandleEvent(EVENTS.Dead, beslanLibarated())

--All Functions that all be called if beslan gets liberated
--It will only handle function calls!!
function beslanLibarated()
  activateUnits("Units at Beslan are now active!", beslanInactiveUnits)
  spawnNewGroup("BeslanDefense")
  spawnNewGroup("NewTargets")
end

--This method acivates an given array of units. It's meant to be used within an EventHandler
function activateUnits(message, units)
  makeMessage(message)
  for unit in units do
    local activateUnit = GROUP:Find(unit)
    activateUnit:Activate()
  end
end

function makeMessage(message)
  MessageToAll(message, 20 ,"Message")
end

--Spawned eine Gruppe mit ihr übergebenden namen.
function spawnNewGroup(groupName)
  SPAWN:New(groupName):Spawn()
end

--Methode to deactivate units. Don't know if it is possible.
function deactivateUnits(message, units)
  for unit in units do
    local deactivateUnit = GROUP:Find(unit)
  end
end
