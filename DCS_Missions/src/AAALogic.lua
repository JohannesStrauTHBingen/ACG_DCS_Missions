
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