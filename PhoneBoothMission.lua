
-- 6 Gruppen 3 pro Seite
-- Eine gruppe umzingelt Airfield (pro Seite)
-- Nach Zerst�rung von diese Gruppe airfield -> forward operationg base
-- Neue gruppe f�r CAS spawn
-- 2 gruppe pro seite als verteidigung f�r EWR
-- !!!!AWACS UNZERST�RBAR MACHEN!!!!

--perZone?


beslanGroup = GROUP:FindByName("BeslanCaptureGroup")
CAStarget = GROUP:Find("OtherGroup")



beslanGroup:HandleEvent(EVENTS.Dead, beslanActivateAirfield())

function beslanActivateAirfield()
    units  =  {"mig21_1", "mig21_2"}
    for unit in units do
      activateUnit = GROUP:Find(unit)
      activateUnit:Activate()
    end
end





