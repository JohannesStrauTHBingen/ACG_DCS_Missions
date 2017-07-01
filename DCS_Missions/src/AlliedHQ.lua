local hq = GROUP:FindByName("Overlord")

local commandCenter = COMMANDCENTER:New(hq,"Overlord")
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
local mission = MISSION
  :New(commandCenter,"Operation Overlord","Primary","Protect our ground forces forces from enemy fighter bombers and support them on their advance!",coalition.side.BLUE)
  :AddScoring(hunt)

local usRec = DETECTION_UNITS:New(usRecUnits)
local CASTasking = TASK_A2G_DISPATCHER:New(mission,fighterwings,usRec)

function mission:OnAfterMissionGoals( From, Event, To )
  self:E( { From, Event, To } )
  local targetGroups = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("GerGarrison"):FilterStart()
  local aliveUnits = 0
  targetGroups:ForEachGroup(function(group)
    if group:IsAlive() then
      aliveUnits = aliveUnits + 1
    end
  end)
  if aliveUnits == 0 then
    mission:GetCommandCenter():MessageToCoalition( "Mission Complete! All targets have been destroyed!" )
    mission:Complete()
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
