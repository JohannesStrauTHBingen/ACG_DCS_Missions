---
--by Johannes Strauﬂ aka IronJockel
--

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