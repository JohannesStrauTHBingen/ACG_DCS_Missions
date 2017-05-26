

--Spawn a BomberGroup every 30 minutes

bomberSpawn = SPAWN:New( "Bombers" )
  :SpawnScheduled(1800,0)  
  :OnSpawnGroup(function( SpawnGoup )
  
  MESSAGE:New("Bombers are on their way to Calais at " .. SpawnGroup:GetMaxHeight() ..  " m! Protect them." ,200,nil):ToBlue()
  MESSAGE:New("Möbelwagen detected on their way to Calais " .. SpawnGroup:GetMaxHeight() ..  " m! Pauke Pauke!." ,200,nil):ToRed()
  
  end)