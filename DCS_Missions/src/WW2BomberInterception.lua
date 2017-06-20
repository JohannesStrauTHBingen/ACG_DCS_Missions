


local axisGroundController = COMMANDCENTER:New(CommandCenterPositionable,CommandCenterName)
local bomberDef = MISSION:New(axisGroundController , "US Bomber Campaign","Primary" , "Intercept all B17 Formations!" , "Axis")

local bomberAttackOne = GROUP:Find("B17LeaderLeaderGroup")
  :HandleEvent(EVENTS.Birth)
function bomberAttackOne:OnEventBirth(EventData)
end