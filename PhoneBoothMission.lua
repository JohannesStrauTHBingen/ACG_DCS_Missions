
-- 6 Gruppen 3 pro Seite
-- Eine gruppe umzingelt Airfield (pro Seite)
-- Nach Zerst�rung von diese Gruppe airfield -> forward operationg base
-- Neue gruppe f�r CAS spawn
-- 2 gruppe pro seite als verteidigung f�r EWR
-- !!!!AWACS UNZERST�RBAR MACHEN!!!!

--perZone?


beslanGroup = GROUP:FindByName("BeslanCaptureGroup")

beslanGroup:HandleEvent(EVENTS.Dead, beslanActivateAirfield())

--Wenn die gruppe beslandGroup tot ist werden alle Einheiten auf dem Airfield Beslan activiert 

function beslanActivateAirfield()
    units  =  {"mig21_1", "mig21_2"}
    for unit in units do
      activateUnit = GROUP:Find(unit)
      activateUnit:Activate()
    end
end












