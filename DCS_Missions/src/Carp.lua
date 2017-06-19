
--BASE:TraceOnOff(true)
--BASE:TraceAll(true)
--BASE:TraceLevel(3)

--Ground Units that are supposed to be spawned.
local kingTigerSpawn = SPAWN:New("KingTiger")
  :InitLimit(1,10)
  :SpawnScheduled(900, 0)

local tigerSpawn = SPAWN:New("Tiger")
  :InitLimit(2, 20)
  :SpawnScheduled(300, 0)

local pantherSpawn = SPAWN:New("Panther")
  :InitLimit(2, 20)
  :SpawnScheduled(300, 0)

local panzerIVSpawn = SPAWN:New("PanzerIV")
  :InitLimit(5,50)
  :SpawnScheduled(60, 0)

local ShermanSpawn = SPAWN:New("Sherman")
  :InitLimit(10,50)
  :SpawnScheduled(60, 0)

local FireflySpawn = SPAWN:New("Firefly")
  :InitLimit(5,25)
  :SpawnScheduled(60, 0)

local CromwellSpawn = SPAWN:New("Cromwell")
  :InitLimit(5, 25)
  :SpawnScheduled(60, 0)

local pointsAllied = 0
local pointsAxis = 0

local ship = UNIT:Find("HostShip")

local bredfords = SPAWN:New("Bedfords"):Spawn()

Zone = ZONE:New("Airfield")

if bredfords:IsCompletelyInZone(Zone) then


end


--local B17LeaderBackGroup = SPAWN:New("B17LeaderBackGroup")
--  :OnSpawnGroup(function(SpawnGroup)
--
--      MESSAGE:New("BackGroupStart" ,10, nil):ToAll()
--
--      local B17LeftBackGroup = SPAWN:New("B17LeftBackGroup"):Spawn()
--      local B17RightBackGroup = SPAWN:New("B17RightBackGroup"):Spawn()
--      local B17BackBackGroup = SPAWN:New("B17BackBackGroup"):Spawn()
--
--      MESSAGE:New("BackGroupEnd" ,10, nil):ToAll()
--
--  end)

--local B17LeaderLeftGroup = SPAWN:New("B17LeaderLeftGroup")
--  :OnSpawnGroup(function(SpawnGroup)
--
--      MESSAGE:New("LeftGroupStart" ,10, nil):ToAll()
--
--      local B17LeftLeftGroup = SPAWN:New("B17LeftLeftGroup"):Spawn()
--      local B17RightLeftGroup = SPAWN:New("B17RightLeftGroup"):Spawn()
--      local B17BackLeftGroup = SPAWN:New("B17BackLeftGroup"):Spawn()
--
--      MESSAGE:New("LeftGroupEnd" ,10, nil):ToAll()
--
--  end)

--local B17LeaderRightGroup = SPAWN:New("B17LeaderRightGroup")
--  :OnSpawnGroup(function(SpawnGroup)
--
--      MESSAGE:New("RightGroupStart" ,10, nil):ToAll()
--
--      local B17LeftRightGroup = SPAWN:New("B17LeftRightGroup"):Spawn()
--      local B17RightRightGroup = SPAWN:New("B17RightRightGroup"):Spawn()
--      local B17BackRightGroup = SPAWN:New("B17BackRightGroup"):Spawn()
--
--      MESSAGE:New("RightGroupEnd" ,10, nil):ToAll()
--
--  end)

--local B17LeaderLeaderGroup = SPAWN:New("B17LeaderLeaderGroup")
--  :OnSpawnGroup(function(SpawnGroup)
--
--      MESSAGE:New("LeaderGroupStart" ,10, nil):ToAll()
--
--      local B17LeftLeaderGroup = SPAWN:New("B17LeftLeaderGroup"):Spawn()
--      local B17RightLeaderGroup = SPAWN:New("B17RightLeaderGroup"):Spawn()
--      local B17BackLeaderGroup = SPAWN:New("B17BackLeaderGroup"):Spawn()
--
--      MESSAGE:New("LeaderGroupEnd" ,10, nil):ToAll()
--
--      B17LeaderBackGroup:Spawn()
--      B17LeaderLeftGroup:Spawn()
--      B17LeaderRightGroup:Spawn()
--  end):Spawn()

local addPoints = SCHEDULER:New(nil,function()

    BASE.E(self,"AddPoints starts")
    local blueUnitsInZone = 0
    local redUnitsInZone = 0
    local captureZone = ZONE:New("capZone")

    local blueUnitSet = SET_UNIT:New()
      :FilterCoalitions("blue")
      :FilterCategories("ground")
      :FilterStart()
    blueUnitSet:ForEachUnit(
      function(Unit)
        if (Unit:IsInZone(captureZone)) then
          blueUnitsInZone = blueUnitsInZone + 1
        end
      end)

    local redUnitsSet = SET_UNIT:New()
      :FilterCoalitions("red")
      :FilterCategories("ground")
      :FilterStart()
    redUnitsSet:ForEachUnit(
      function(Unit)
        if (Unit:IsInZone(captureZone)) then
          redUnitsInZone = redUnitsInZone + 1
        end
      end)

    if (blueUnitsInZone > 0 and redUnitsInZone == 0) then
      MESSAGE:New("Allies are holding the Airfield! Attack them!",10,nil):ToRed()
      MESSAGE:New("We are holding the Airfield! Keep it on!",10,nil):ToBlue()
      pointsAllied = pointsAllied + 1
    end

    if (redUnitsInZone > 0 and blueUnitsInZone == 0) then
      MESSAGE:New("Axis are holding the Airfield! Attack them!",10,nil):ToBlue()
      MESSAGE:New("We are holding the Airfield! Keep it on!",10,nil):ToRed()
      pointsAxis = pointsAxis + 1
    end

    MESSAGE:New("Axis Capture Points: " .. tostring(pointsAxis) ,10, nil):ToAll()
    MESSAGE:New("Allies Capture Points: " .. tostring(pointsAllied) ,10, nil):ToAll()
    BASE:E("Add Points end.")
end
,{},300,300)

local missionResult = SCHEDULER:New(nil, function()

    if (pointsAxis > pointsAllied) then
      MESSAGE:New("We won the battle! Good Job Kameraden. Next fight in 5 Minutes.",20,nil):ToRed()
      MESSAGE:New("We lost! Retreat and regroup. Next fight in 5 Minutes.",20,nil):ToBlue()
    end

    if (pointsAllied > pointsAxis) then
      MESSAGE:New("We lost! Retreat and regroup. Next fight in 5 Minutes.",20,nil):ToRed()
      MESSAGE:New("We won! One step closer to Berlin. Next fight in 5 Minutes.",20,nil):ToBlue()
    end

    if (pointsAllied == pointsAxis) then
      MESSAGE:New("Draw. Restart in 5 Minutes.",20,nil):ToAll()
    end
end,{},14100)

MESSAGE:New("Mission Start!" ,10, nil):ToAll()
