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

local jagt = SCORING:New("Bomber Abwehr")
local mission = MISSION
  :New(commandCenter,"WestWall","Primary","Destroy incomming Bombers!",coalition.side.RED)
  :AddScoring(jagt)

MESSAGE:New("Mission done!",20,"Debug"):ToAll()

local interceptTask = TASK_A2A_INTERCEPT:New(mission,jagtwaffe,"Intercept",bombers)

MESSAGE:New("Intercepterscript done!",20,"Debug"):ToAll()
