
-- 6 Gruppen 3 pro Seite
-- Eine gruppe umzingelt Airfield (pro Seite)
-- Nach Zerst�rung von diese Gruppe airfield -> forward operationg base
-- Neue gruppe f�r CAS spawn
-- 2 gruppe pro seite als verteidigung f�r EWR
-- !!!!AWACS UNZERST�RBAR MACHEN!!!!

--perZone?


beslanGroup = GROUP:FindByName("BeslanCaptureGroup")
CAStarget = GROUP:Find("OtherGroup")

units  =  {"mig21_1", "mig21_2"}

beslanGroup:HandleEvent(EVENTS.Dead, beslanActivateAirfield(units))


--This method acivates an given array of units. It's meant to be used within an EventHandler 
function activateUnits(units)
    for unit in units do
      activateUnit = GROUP:Find(unit)
      activateUnit:Activate()
    end
end




