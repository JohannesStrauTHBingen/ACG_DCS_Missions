local jagtwaffe = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local fighterwings = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterStart()
local gerRecUnits = SET_GROUP:New():FilterCoalitions("red"):FilterPrefixes("Ger"):FilterStart()
local usRecUnits = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()

local hq = GROUP:FindByName("AdlerHorst")
local commandCenter = COMMANDCENTER:New(hq,"AdlerHorst")
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
  :New(commandCenter,"WestWall","Primary","Allied forces are Advancing! Destroy their Bombers and Ground Forces!",coalition.side.RED)
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