
local hq = GROUP:FindByName("AlderHorst")

local commandCenter = COMMANDCENTER:New(hq,"AdlerHorst")
  :SetModeWWII()

local referenceZones = {"Azeville", "Les Dunes de Varreville", "Grandcamp les Bains", "Vierville suer Mer", "La Vailee", "Ranchy", "Cateaubrave", "Isigny"}
for referenceZone in referenceZones do
  commandCenter:SetReferenceZones(referenceZone)
end

local jagtwaffe = SET_GROUP:New():FilterCategories("plane"):FilterCoalitions("red"):FilterStart()
local bombers = SET_GROUP:New():FilterCoalitions("blue"):FilterCategories("plane"):FilterPrefixes("First"):FilterStart()

local jagt = SCORING:New("Bomber Abwehr")
local mission = MISSION
  :New(commandCenter,"WestWall","Primary","Destroy incomming Bombers!",coalition.side.RED)
  :AddScoring(jagt)

local interceptTask = TASK_A2A_INTERCEPT:New(mission,jagtwaffe,"Intercept",bombers)  