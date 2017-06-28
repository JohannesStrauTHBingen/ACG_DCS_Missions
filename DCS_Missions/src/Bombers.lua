


--local firstRaidBackGroup   = GROUP:FindByName("LeaderGroupBack")
--local firstRaidRightGroup  = GROUP:FindByName("LeaderGroupRight")
--local firstRaidLeftGroup   = GROUP:FindByName("LeaderGroupLeft")
--local firstRaidLeaderGroup = GROUP:FindByName("LeaderGroupLeader")
--  :HandleEvent(EVENTS.Birth)
--function firstRaidLeaderGroup:OnEventBirth(EventData)
--  firstRaidBackGroup:Activate()
--  firstRaidLeftGroup:Activate()
--  firstRaidRightGroup:Activate()
--end
--firstRaidLeaderGroup:Activate()

local bomberSet = SET_GROUP:New():FilterCoalitions("blue"):FilterPrefixes("FirstRaid"):FilterStart()

bomberSet:ForEachGroup(function(MooseGroup)
  MooseGroup:Activate()
  MESSAGE:New("A Bomber Group Activated",10,"Debug"):ToAll()
end)

