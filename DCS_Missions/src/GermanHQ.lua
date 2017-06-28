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


MESSAGE:New("HQ done!",20,"Debug"):ToAll()

--local referenceZones = {"Azeville", "Les Dunes de Varreville", "Grandcamp les Bains", "Vierville suer Mer", "La Vailee", "Ranchy", "Cateaubrave", "Isigny"}

local jagtwaffe = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("First"):FilterStart()
local groundTargets = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("GroundForces"):FilterStart()

local jagt = SCORING:New("Bomber Abwehr")
local mission = MISSION
  :New(commandCenter,"WestWall","Primary","Allied forces are Advancing! Destroy their Bombers and Ground Forces!",coalition.side.RED)
  :AddScoring(jagt)

local interceptTask = TASK_A2A_INTERCEPT:New(mission,jagtwaffe,"Intercept",bombers)
local casTRask = TASK_A2G_BAI:New(mission,jagtwaffe,"Close Air Support", groundTargets)

MESSAGE:New("Intercepterscript done!",20,"Debug"):ToAll()
