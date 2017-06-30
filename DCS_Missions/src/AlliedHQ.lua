local hq = GROUP:FindByName("Overlord")

local commandCenter = COMMANDCENTER:New(hq,"Overlord")
  :SetModeWWII()
  :SetReferenceZones("Azeville")
  :SetReferenceZones("Les Dunes de Varreville")
  :SetReferenceZones("Grandcamp les Bains")
  :SetReferenceZones("Vierville suer Mer")
  :SetReferenceZones("La Vailee")
  :SetReferenceZones("Ranchy")
  :SetReferenceZones("Cateaubrave")
  :SetReferenceZones("Isigny")


MESSAGE:New("US HQ done!",20,"Debug"):ToAll()

local jagt = SCORING:New("CAS")
local mission = MISSION
  :New(commandCenter,"WestWall","Primary","Allied forces are Advancing! Destroy their Bombers and Ground Forces!",coalition.side.RED)
  :AddScoring(jagt)



local gerRec = DETECTION_UNITS:New(gerRecUnits)
local CASTasking = TASK_A2G_DISPATCHER:New(mission,jagtwaffe,gerRec)

function mission:OnAfterMissionGoals( From, Event, To )
  self:E( { From, Event, To } )
  local targetGroups = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("US"):FilterStart()
  local aliveUnits = 0
  targetGroups:ForEachGroup(function(group)
    if group:IsAlive() then
      aliveUnits = aliveUnits + 1
    end
  end)
  if aliveUnits == 0 then
    mission:GetCommandCenter():MessageToCoalition( "Mission Complete! All targets have been destroyed and the Allied Invasion as been crushed!" )
    mission:Complete()
  end
end