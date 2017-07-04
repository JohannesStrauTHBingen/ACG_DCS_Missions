
local jagtwaffe = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local fighterwings = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterStart()
local gerRecUnits = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("Ger"):FilterStart()
local usRecUnits = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()

local oneGer
local twoGer
local threeGer
local fourGer

local gerZone = ZONE:New("GerAAATurnON")
local airdefGER = SCHEDULER:New(nil, function()
  local alliedAircraft = SET_UNIT:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterStart()
  local found = 0
  alliedAircraft:ForEachUnitCompletelyInZone(gerZone,function()
    found = found + 1
  end)

  if found > 0 then
    if not oneGer then
      oneGer = SPAWN:New("AAARucqueville"):Spawn()
      twoGer = SPAWN:New("AAALantheuil"):Spawn()
      threeGer = SPAWN:New("AAABazenville"):Spawn()
      fourGer = SPAWN:New("AAASainteCroxsurMer"):Spawn()
      MESSAGE:New("Allied aircraft over Ger Airfield and spawned AAA",10, "debug"):ToAll()
    end
  end

  if found < 1 then
    if oneGer then
      oneGer:Destroy()
      twoGer:Destroy()
      threeGer:Destroy()
      fourGer:Destroy()
      MESSAGE:New("Despawned AAA",10, "debug"):ToAll()
    end
  end
end,{},0,20)

MESSAGE:New("AAA GER Done",10,"Debug"):ToAll()

local oneUS
local twoUS
local threeUS
local fourUS

local usZone = ZONE:New("USAAAATurnOn")
local airdefUS = SCHEDULER:New(nil, function()
  local gerAircraft = SET_UNIT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
  local found = 0
  gerAircraft:ForEachUnitCompletelyInZone(usZone,function()
    found = found + 1
  end)

  if found > 0 then
    if not oneUS then
      oneUS = SPAWN:New("AAABeuzeville"):Spawn()
      twoUS = SPAWN:New("AAAPicauville"):Spawn()
      threeUS = SPAWN:New("AAABiniville"):Spawn()
      fourUS = SPAWN:New("AAAAzeville"):Spawn()
      MESSAGE:New("German aircraft over Alied Airfield and spawned AAA",10, "debug"):ToAll()
    end
  end

  if found < 1 then
    if oneUS then
      oneUS:Destroy()
      twoUS:Destroy()
      threeUS:Destroy()
      fourUS:Destroy()
      MESSAGE:New("Despawned AAA",10, "debug"):ToAll()
    end
  end
end,{},0,20)

MESSAGE:New("AAA Done",10,"Debug"):ToAll()

local hqGer = GROUP:FindByName("AdlerHorst")
local commandCenterGer = COMMANDCENTER:New(hqGer,"AdlerHorst")
  :SetModeWWII()
  :SetReferenceZones("Azeville")
  :SetReferenceZones("Les Dunes de Varreville")
  :SetReferenceZones("Grandcamp les Bains")
  :SetReferenceZones("Vierville suer Mer")
  :SetReferenceZones("La Vailee")
  :SetReferenceZones("Ranchy")
  :SetReferenceZones("Cateaubrave")
  :SetReferenceZones("Isigny")


local jagt = SCORING:New("CAS")
local missionGer = MISSION
  :New(commandCenterGer,"WestWall","Primary","Allied forces are Advancing! Destroy their Bombers and Ground Forces!",coalition.side.RED)
  :AddScoring(jagt)



local gerRec = DETECTION_UNITS:New(gerRecUnits)
local CASTaskingGer = TASK_A2G_DISPATCHER:New(missionGer,jagtwaffe,gerRec)
local A2ATaskingGer = TASK_A2A_DISPATCHER:New(missionGer,jagtwaffe,gerRec)

function missionGer:OnAfterMissionGoals( From, Event, To )
  self:E( { From, Event, To } )
  local targetGroups = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()
  local aliveUnits = 0
  targetGroups:ForEachGroup(function(group)
    if group:IsAlive() then
      aliveUnits = aliveUnits + 1
    end
  end)
  if aliveUnits == 0 then
    missionGer:GetCommandCenter():MessageToCoalition( "Mission Complete! All targets have been destroyed and the Allied Invasion as been crushed!" )
    missionGer:Complete()
  end
end

MESSAGE:New("Axis HQ online",20,"Debug"):ToAll()

local hqUS = GROUP:FindByName("Overlord")
local commandCenterUS = COMMANDCENTER:New(hqUS,"Overlord")
  :SetModeWWII()
  :SetReferenceZones("Azeville")
  :SetReferenceZones("Les Dunes de Varreville")
  :SetReferenceZones("Grandcamp les Bains")
  :SetReferenceZones("Vierville suer Mer")
  :SetReferenceZones("La Vai lee")
  :SetReferenceZones("Ranchy")
  :SetReferenceZones("Cateaubrave")
  :SetReferenceZones("Isigny")

local hunt = SCORING:New("CAS")
local missionUS = MISSION
  :New(commandCenterUS,"Operation Overlord","Primary","Protect our ground forces forces from enemy fighter bombers and support them on their advance!",coalition.side.BLUE)
  :AddScoring(hunt)

local usRec = DETECTION_UNITS:New(usRecUnits)
local CASTaskingUS = TASK_A2G_DISPATCHER:New(missionUS,fighterwings,usRec)
local A2ATaskingUS = TASK_A2A_DISPATCHER:New(missionUS,fighterwings,usRec)

function missionUS:OnAfterMissionGoals( From, Event, To )
  self:E( { From, Event, To } )
  local targetGroups = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("GerGarrison"):FilterStart()
  local aliveUnits = 0
  targetGroups:ForEachGroup(function(group)
    if group:IsAlive() then
      aliveUnits = aliveUnits + 1
    end
  end)
  if aliveUnits == 0 then
    missionUS:GetCommandCenter():MessageToCoalition( "Mission Complete! All targets have been destroyed!" )
    missionUS:Complete()
  end
end

local alliedTanksOneSpawn = SPAWN:New("USGroundForcesShermanOne")
  :InitLimit(8,0)
  :SpawnScheduled(1800,0)
  :SpawnScheduleStop()
local alliedTanksTwoSpawn = SPAWN:New("USGroundForcesShermanTwo")
  :InitLimit(8,0)
  :SpawnScheduled(1800,0)
  :SpawnScheduleStop()

local shipOne = GROUP:FindByName("USshipOne")
  :HandleEvent(EVENTS.Dead)
function shipOne:OnEventDead(EventData)
  alliedTanksOneSpawn:SpawnScheduleStop()
  MESSAGE:New("Our ships at Vierville suer Mer got destroyed! Our Groundforces are cut off!",10 , "BattleInfo"):ToBlue()
  MESSAGE:New("Enemy ships at Vierville suer Mer destroyed! Kill off remaning allied forces!",10 , "BattleInfo"):ToRed()
end
local shipTwo = GROUP:FindByName("USshipTwo")
  :HandleEvent(EVENTS.Dead)
function shipTwo:OnEventDead(EventData)
  alliedTanksTwoSpawn:SpawnScheduleStop()
  MESSAGE:New("Our ships at Grandcamp les Bains got destroyed! Our Groundforces are cut off!",10 , "BattleInfo"):ToBlue()
  MESSAGE:New("Enemy ships at Grandcamp les Bains destroyed! Kill off remaning allied forces!",10 , "BattleInfo"):ToRed()
end

local firstOne = true
local zoneOne = ZONE:New("LandingZoneOne")
local shipOneArrived = SCHEDULER:New(nil,function()
  if firstOne and shipOne:IsCompletelyInZone(zoneOne) then
    firstOne = false
    alliedTanksOneSpawn:SpawnScheduleStart()
    MESSAGE:New("Our ships arrived at Vierville suer Mer. Protect them!",10 , "BattleInfo"):ToBlue()
    MESSAGE:New("Enemy ships arrived at Vierville suer Mer. Destroy them!",10 , "BattleInfo"):ToRed()
  end
end, {},0,60)

local firstTwo = true
local zoneTwo = ZONE:New("LandingZoneTwo")
local shipTwoArrived = SCHEDULER:New(nil,function()
  if firstTwo and shipTwo:IsCompletelyInZone(zoneTwo) then
    firstTwo = false
    alliedTanksTwoSpawn:SpawnScheduleStart()
    MESSAGE:New("Our ships arrived at Grandcamp les Bains. Protect them!",10 , "BattleInfo"):ToBlue()
    MESSAGE:New("Enemy ships arrived at Grandcamp les Bains. Destroy them!",10 , "BattleInfo"):ToRed()
  end
end, {},0,60)

MESSAGE:New("Allied HQ online",10,"Debug"):ToAll()

local raidOne = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17One"):FilterStart()
local raidTwo = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Two"):FilterStart()
local raidThree = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Third"):FilterStart()
local raidFour = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Four"):FilterStart()
local raidFive = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Five"):FilterStart()
local raidSix = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("blue"):FilterPrefixes("B17Six"):FilterStart()


local function SpawnRaid(raidSet)
  raidSet:ForEachGroup(function(group)
    group:Activate()
  end)
end

local raids = {raidOne, raidTwo, raidThree, raidFour, raidFive, raidSix}
local index = 0

local spawnRaidSchedular = SCHEDULER:New(nil,function()
  index = index + 1
  SpawnRaid(raids[index])
end ,{}, 1800,3600)

local jagtwaffeClients = SET_CLIENT:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("B17"):FilterStart()

local function countAliveBombers()
  local number = 0
  bombers:ForEachGroup(function(group)
    if group:IsAlive() then
      number = number + group:GetSize()
    end
  end)
  return number
end

local radarSchedular = SCHEDULER:New(nil,function()
  local aliveBombers = countAliveBombers()
  if aliveBombers > 0 then
    jagtwaffeClients:ForEachClient(function(client)
      if client:IsAlive() then
        local bomber = bombers:GetFirst()
        local bomberPos = bomber:GetCoordinate()
        local clientPos = client:GetCoordinate()
        MESSAGE:New( "B17 Formation Spottet at\n " ..
          bomberPos:ToStringBRA(clientPos)
          .. "\n" .. tostring(aliveBombers) .. " Bombers detected!" ,15,"BODO: "):ToClient(client)
      end
    end)
  end
end,{},0, 300)

MESSAGE:New("All lines loaded", 10, "Debug"):ToAll()