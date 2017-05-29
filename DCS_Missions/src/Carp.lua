

kingTigerSpawn = SPAWN:New("KingTiger")
  :InitLimit(1,10)
  :SpawnScheduled(900, 0)

tigerSpawn = SPAWN:New("Tiger")
  :InitLimit(2, 20)
  :SpawnScheduled(300, 0)

pantherSpawn = SPAWN:New("Panther")
  :InitLimit(2, 20)
  :SpawnScheduled(300, 0)

panzerIVSpawn = SPAWN:New("PanzerIV")
  :InitLimit(5,50)
  :SpawnScheduled(60, 0)

ShermanSpawn = SPAWN:New("Sherman")
  :InitLimit(10,50)
  :SpawnScheduled(60, 0)

FireflySpawn = SPAWN:New("Firefly")
  :InitLimit(5,25)
  :SpawnScheduled(60, 0)

CromwellSpawn = SPAWN:New("Cromwell")
  :InitLimit(5, 25)
  :SpawnScheduled(60, 0)

pointsAllied = 0
pointsAxis = 0



AddPoints = SCHEDULER:New(nil,function()

    local blueUnitsInZone = 0
    local redUnitsInZone = 0
    local captureZone = ZONE:New("capZone")

    local blueUnitSet = SET_UNIT:New()
      :FilterCoalitions("blue")
      :FilterCategories("ground")
      :FilterStart()
    blueUnitSet:ForEachUnit(
      function(Unit)

--Todo
      end)

    local redUnitsSet = SET_UNIT:New()
      :FilterCoalitions("red")
      :FilterCategories("ground")
      :FilterStart()
    redUnitsSet:ForEachUnitCompletelyInZone(captureZone,
      function(unit)
        redUnitsInZone = redUnitsInZone + 1
        MESSAGE:New("A red Unit got found in the Zone",3,nil):ToAll()
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
end
,{},10,10)

missionResult = SCHEDULER:New(nil, function()

    if (pointsAxis > pointsAllied) then
      MESSAGE:New("We won the battle! Good Job Kameraden.",20,nil):ToRed()
      MESSAGE:New("We lost! Retreat and regroup.",20,nil):ToBlue()
    end
    if (pointsAllied > pointsAxis) then

      MESSAGE:New("We lost! Retreat and regroup.",20,nil):ToRed()
      MESSAGE:New("We won! One step closer to Berlin.",20,nil):ToBlue()
    end
end,{},360)


MESSAGE:New("All lines loaded" ,10, nil):ToAll()
