

--Spawn a BomberGroup every 30 minutes
bomberSpawn = SPAWN:New( "Bombers" )
  :SpawnScheduled(1800,0)
  :OnSpawnGroup(function( SpawnGoup )
      MESSAGE:New("Bombers are on their way to ! Protect them." ,200,nil):ToBlue()
      MESSAGE:New("Möbelwagen detected on their way ! Pauke Pauke!." ,200,nil):ToRed()

  end)

radarSchedular = SCHEDULER:New(nil, function()



end
,{},300 ,300)


  