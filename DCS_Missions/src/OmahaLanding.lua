
local omahaZone = ZONE:New("LandingZone")

local shermanSpawn = SPAWN:New("Sherman")
  :InitLimit(10,50)
  :SpawnScheduled(60, 0)

local recconUnitsSpawn = SPAWN:New("RecconUS")
  :InitLimit(2,30)
  :SpawnScheduled(60,0)
  :SpawnScheduleStop()

--local usOmahaHQ = GROUP:Find("USOmahaHQ")

local NotArrived = true

local ships = GROUP:Find("HostShip")
ships:HandleEvent(EVENTS.Dead)
function ships:OnEventDead(EventData)
  MESSAGE:New("Our Supply Ships got sunk! Ground forces are cut off!", 20,nil):ToBlue()
  MESSAGE:New("We destoyed the allied Supplies! Push the remaining enemy forces back into the Atlantic!",20,nil):ToRed()
  if not NotArrived then
    shermanSpawn:SpawnScheduleStop()
    recconUnitsSpawn:SpawnScheduleStop()
  end
end

local shipsArrivedSchedular, shipsArrivedScedularID = SCHEDULER:New(nil,function()
  if NotArrived and ships.IsCompletelyInZone(self, omahaZone) and ships.GetMaxVelocity() == 0 then
    NotArrived = false
    shermanSpawn:SpawnScheduleStart()
    MESSAGE:New("US Ships Landed at Omaha Beach and are unloading Tanks. Attack them!",10,nil):ToRed()
    MESSAGE:New("US Ships Landed at Omaha Beach and are unloading Tanks. Protect them!",10,nil):ToBlue()
  end
end, {},0,30,0,1000):Start(shipsArrivedScedularID)

--local usOmahaCC = COMMANDCENTER:New(usOmahaHQ,"Overlord")
