
BASE:TraceOnOff(true)
BASE:TraceAll(true)
BASE:TraceLevel(3)

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

local bomberLeader = SPAWN:New("BomberLeader")
  :OnSpawnGroup(function()
    MESSAGE:New("Bombers Spawned",20,nil):ToAll()
  end)
local bomberRight = SPAWN:New("BomberRight")
local bomberLeft = SPAWN:New("BomberLeft")
local bomberBack = SPAWN:New("BomberBack")


local bomberScheduler = SCHEDULER:New(function()
  

  end,{},0,20)


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
