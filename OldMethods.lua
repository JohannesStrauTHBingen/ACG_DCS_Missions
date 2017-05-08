

spawnProtectionZoneRed = ZONE:New("SpawnProtectionZoneRed")
spawnProtectionZoneBlue = ZONE:New("SpawnProtectionZoneBlue")

allRedsPlayers = {"MiG-21_Mozdok_1", "MiG-21_Mozdok_2", "MiG-21_Mozdok_3", "MiG-21_Mozdok_4", "MiG-21_Mozdok_5", "MiG-21_Mozdok_6", "MiG-21_Mozdok_7", "MiG-21_Mozdok_8", "MiG-21_Mozdok_9", "MiG-21_Mozdok_10", "MiG-21_Mozdok_11", "MiG-21_Mozdok_12", "MiG-21_Mozdok_13", "MiG-21_Mozdok_14", "MiG-21_Mozdok_15", "MiG-21_Mozdok_16", "MiG-15_Mozdok_1", "MiG-15_Mozdok_2", "MiG-15_Mozdok_3", "MiG-15_Mozdok_4", "L-39ZA_Mozdok_1", "L-39ZA_Mozdok_2", "Su-25T_Mozdok_1", "Su-25T_Mozdok_2", "Su-25T_Mozdok_3", "Su-25T_Mozdok_4", "Su-25_Mozdok_1", "Su-25_Mozdok_2", "!!! MiG-21_Beslan_1 !!!", "!!! MiG-21_Beslan_2 !!!", "!!! MiG-21_Beslan_3 !!!", "!!! MiG-21_Beslan_4 !!!", "!!! MiG-15_Beslan_1 !!!", "!!! MiG-15_Beslan_2 !!!", "!!! L-39ZA_Beslan_1 !!!", "!!! L-39ZA_Beslan_2 !!!"}
allBluesPlayers = {"F-5E-3_Vody_1", "F-5E-3_Vody_2", "F-5E-3_Vody_3", "F-5E-3_Vody_4", "F-5E-3_Vody_5", "F-5E-3_Vody_6", "F-5E-3_Vody_7", "F-5E-3_Vody_8", "F-5E-3_Vody_9", "F-5E-3_Vody_10", "F-5E-3_Vody_11", "F-5E-3_Vody_12", "F-5E-3_Vody_13", "F-5E-3_Vody_14", "F-86_Vody_1", "F-86_Vody_2", "F-86_Vody_3", "F-86_Vody_4", "AJS37_Vody_1", "AJS37_Vody_2", "AJS37_Vody_3", "AJS37_Vody_4", "A-10C_Vody_1", "A-10C_Vody_2", "A-10C_Vody_3", "A-10C_Vody_4", "HAWK_Vody_1", "HAWK_Vody_2", "!!! F-5E-3_Nalchik_1 !!!", "!!! F-5E-3_Nalchik_2 !!!", "!!! F-5E-3_Nalchik_3 !!!", "!!! F-5E-3_Nalchik_4 !!!", "!!! F-86_Nalchik_1 !!!", "!!! F-86_Nalchik_2 !!!", "!!! AJS37_Nalchik_1 !!!", "!!! AJS37_Nalchik_2 !!!"}

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

  -- Array von einheiten die activiert werden können.
beslanInactiveUnits  =  {"!!! MiG-21_Beslan_1 !!!", "!!! MiG-21_Beslan_2 !!!", "!!! MiG-21_Beslan_3 !!!", "!!! MiG-21_Beslan_4 !!!", "!!! MiG-15_Beslan_1 !!!", "!!! MiG-15_Beslan_2 !!!", "!!! L-39ZA_Beslan_1 !!!", "!!! L-39ZA_Beslan_2 !!!"}

-- beslanGroup is the Group that is holding the Airfield Beslan. If it gets destryoed a event is triggered
beslanGroup = GROUP:FindByName("Attacking_Forces_BLUE")
beslanGroup:HandleEvent(EVENTS.Dead, beslanLibarated())

-- All Functions that all be called if beslan gets liberated
-- It will only handle function calls!!
function beslanLibarated()
  activateUnits("Units at Beslan are now active!", beslanInactiveUnits)
  spawnNewGroup("Garrison_Beslan")
  spawnNewGroup("Attacking_Forces_Blue_Mozdok")
end

-- This method acivates an given array of units. It's meant to be used within an EventHandler
function activateUnits(message, units)
  makeMessage(message)
  for unit in units do
    local activateUnit = GROUP:Find(unit)
    activateUnit:Activate()
  end
end
  