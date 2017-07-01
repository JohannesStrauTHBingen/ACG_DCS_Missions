
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
  :InitLimit(2,0)
  :SpawnScheduled(30,0)
  :SpawnScheduleStop()
local alliedTanksTwoSpawn = SPAWN:New("USGroundForcesShermanTwo")
  :InitLimit(8,0)
  :SpawnScheduled(1,0)
  :SpawnScheduleStop()

local shipOne = GROUP:FindByName("USshipOne")
  :HandleEvent(EVENTS.Dead)
function shipOne:OnEventDead(EventData)
  alliedTanksOneSpawn:SpawnScheduleStop()
end
local shipTwo = GROUP:FindByName("USshipTwo")
  :HandleEvent(EVENTS.Dead)
function shipTwo:OnEventDead(EventData)
  alliedTanksTwoSpawn:SpawnScheduleStop()
end

local firstOne = true
local zoneOne = ZONE:New("LandingZoneOne")
local shipOneArrived = SCHEDULER:New(nil,function()
  if firstOne and shipOne:IsCompletelyInZone(zoneOne) then
    firstOne = false
    alliedTanksOneSpawn:SpawnScheduleStart()
  end
end, {},0,180)

local firstTwo = true
local zoneTwo = ZONE:New("LandingZoneTwo")
local shipTwoArrived = SCHEDULER:New(nil,function()
  MESSAGE:New("checking",10,"Debug"):ToAll()

  if firstTwo and shipTwo:IsCompletelyInZone(zoneTwo) then
    MESSAGE:New("unloading units",10,"Debug"):ToAll()
    firstTwo = false
    alliedTanksTwoSpawn:SpawnScheduleStart()
  end
end, {},0,10)

MESSAGE:New("Allied HQ online",10,"Debug"):ToAll()
