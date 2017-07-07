---
--by Johannes Strauß aka IronJockel
--

local oneGer
local twoGer
local threeGer
local fourGer

local gerZone = ZONE:New("GerAAATurnON")
local airdefGER = SCHEDULER:New(nil, function()
  local found = 0
  fighterwings:ForEachGroupCompletelyInZone(gerZone,function(group)
    if group:IsAlive() then
      found = found + 1
    end
  end)

  if found > 0 then
    if not oneGer then
      oneGer = SPAWN:New("AAARucqueville"):Spawn()
      twoGer = SPAWN:New("AAALantheuil"):Spawn()
      threeGer = SPAWN:New("AAABazenville"):Spawn()
      fourGer = SPAWN:New("AAASainteCroxsurMer"):Spawn()
      MESSAGE:New(" Allied aircraft over german airfield! AAA guns are manned! ",10, "BODO"):ToRed()
    end
  end

  if found < 1 then
    if oneGer then
      oneGer:Destroy()
      twoGer:Destroy()
      threeGer:Destroy()
      fourGer:Destroy()
      oneGer = nil
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
  local found = 0
  jagtwaffe:ForEachGroupCompletelyInZone(usZone,function(group)
    if group:IsAlive() then
      found = found + 1
    end
  end)

  if found > 0 then
    if not oneUS then
      oneUS = SPAWN:New("AAABeuzeville"):Spawn()
      twoUS = SPAWN:New("AAAPicauville"):Spawn()
      threeUS = SPAWN:New("AAABiniville"):Spawn()
      fourUS = SPAWN:New("AAAAzeville"):Spawn()
      MESSAGE:New(" German aircraft over our airfield! AAA guns are manned!",10, "HQ"):ToBlue()
    end
  end

  if found < 1 then
    if oneUS then
      oneUS:Destroy()
      twoUS:Destroy()
      threeUS:Destroy()
      fourUS:Destroy()
      oneUS = nil
    end
  end
end,{},0,20)

MESSAGE:New("AAA Done",10,"Debug"):ToAll()
