local B17LeaderBackGroup = SPAWN:New("B17LeaderBackGroup")
  :OnSpawnGroup(function(SpawnGroup)

      MESSAGE:New("BackGroupStart" ,10, nil):ToAll()

      local B17LeftBackGroup = SPAWN:New("B17LeftBackGroup"):Spawn()
      local B17RightBackGroup = SPAWN:New("B17RightBackGroup"):Spawn()
      local B17BackBackGroup = SPAWN:New("B17BackBackGroup"):Spawn()

      MESSAGE:New("BackGroupEnd" ,10, nil):ToAll()

  end)

local B17LeaderLeftGroup = SPAWN:New("B17LeaderLeftGroup")
  :OnSpawnGroup(function(SpawnGroup)

      MESSAGE:New("LeftGroupStart" ,10, nil):ToAll()

      local B17LeftLeftGroup = SPAWN:New("B17LeftLeftGroup"):Spawn()
      local B17RightLeftGroup = SPAWN:New("B17RightLeftGroup"):Spawn()
      local B17BackLeftGroup = SPAWN:New("B17BackLeftGroup"):Spawn()

      MESSAGE:New("LeftGroupEnd" ,10, nil):ToAll()

  end)

local B17LeaderRightGroup = SPAWN:New("B17LeaderRightGroup")
  :OnSpawnGroup(function(SpawnGroup)

      MESSAGE:New("RightGroupStart" ,10, nil):ToAll()

      local B17LeftRightGroup = SPAWN:New("B17LeftRightGroup"):Spawn()
      local B17RightRightGroup = SPAWN:New("B17RightRightGroup"):Spawn()
      local B17BackRightGroup = SPAWN:New("B17BackRightGroup"):Spawn()

      MESSAGE:New("RightGroupEnd" ,10, nil):ToAll()

  end)

local B17LeaderLeaderGroup = SPAWN:New("B17LeaderLeaderGroup")
  :OnSpawnGroup(function(SpawnGroup)

      MESSAGE:New("LeaderGroupStart" ,10, nil):ToAll()
      
      local B17LeftLeaderGroup = SPAWN:New("B17LeftLeaderGroup"):Spawn()
      local B17RightLeaderGroup = SPAWN:New("B17RightLeaderGroup"):Spawn()
      local B17BackLeaderGroup = SPAWN:New("B17BackLeaderGroup"):Spawn()

      MESSAGE:New("LeaderGroupEnd" ,10, nil):ToAll()

      B17LeaderBackGroup:Spawn()
      B17LeaderLeftGroup:Spawn()
      B17LeaderRightGroup:Spawn()
  end):Spawn()
