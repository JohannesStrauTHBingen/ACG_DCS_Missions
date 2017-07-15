local hqGer = GROUP:FindByName("AdlerHorst")
local commandCenterGer = COMMANDCENTER:New(hqGer,"AdlerHorst")
  :SetModeWWII()
  :SetReferenceZones("Vierville suer Mer")
  :SetReferenceZones("Azeville")
  :SetReferenceZones("Les Dunes de Varreville")
  :SetReferenceZones("Grandcamp les Bains")
  :SetReferenceZones("La Vailee")
  :SetReferenceZones("Ranchy")
  :SetReferenceZones("Cateaubrave")
  :SetReferenceZones("Isigny")

local jagt = SCORING:New("CAS")
local gerCAS = MISSION
  :New(commandCenterGer,"WestWall","Primary","Allied forces are Advancing! Destroy their Bombers and Ground Forces!",coalition.side.RED)
  :AddScoring(jagt)

local gerRec = DETECTION_UNITS:New(gerRecUnits)
local CASTaskingGer = TASK_A2G_DISPATCHER:New(gerCAS,jagtwaffe,gerRec)

function gerCAS:OnAfterMissionGoals( From, Event, To )
  self:E( { From, Event, To } )
  local targetGroups = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()
  local aliveUnits = 0
  targetGroups:ForEachGroup(function(group)
    if group:IsAlive() then
      aliveUnits = aliveUnits + 1
    end
  end)
  if aliveUnits == 0 then
    gerCAS:GetCommandCenter():MessageToCoalition( "Mission Complete! All targets have been destroyed and the Allied Invasion as been crushed!" )
    gerCAS:Complete()
  end
end

MESSAGE:New("Axis HQ online",20,"Debug"):ToAll()