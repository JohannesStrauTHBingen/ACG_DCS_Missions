
local left1 = GROUP:FindByName("B17OneLeft")
local right1 = GROUP:FindByName("B17OneRight")
local back1 = GROUP:FindByName("B17OneBack")

local raidOne = GROUP:FindByName("B17OneLeader")
  :HandleEvent(EVENTS.Birth)
function raidOne:OnEventBirth(EventData)
  MESSAGE:New("Fired 1",10, "Debug"):ToAll()
  left1:Activate()
  right1:Activate()
  back1:Activate()
end

local left2 = GROUP:FindByName("B17TwoLeft")
local right2 = GROUP:FindByName("B17TwoRight")
local back2 = GROUP:FindByName("B17TwoBack")

local raidTwo = GROUP:FindByName("B17TwoLeader")
  :HandleEvent(EVENTS.Birth)
function raidTwo:OnEventBirth(EventData)
  MESSAGE:New("Fired 2",10, "Debug"):ToAll()
  left2:Activate()
  right2:Activate()
  back2:Activate()
end

local left3 = GROUP:FindByName("B17ThirdLeft")
local right3 = GROUP:FindByName("B17ThirdRight")
local back3 = GROUP:FindByName("B17ThirdBack")

local raidThree = GROUP:FindByName("B17ThirdLeader")
  :HandleEvent(EVENTS.Birth)
function raidThree:OnEventBirth(EventData)
  MESSAGE:New("Fired 3",10, "Debug"):ToAll()
  left3:Activate()
  right3:Activate()
  back3:Activate()
end

local left4 = GROUP:FindByName("B17FourLeft")
local right4 = GROUP:FindByName("B17FourRight")
local back4 = GROUP:FindByName("B17FourBack")

local raidFour = GROUP:FindByName("B17FourLeader")
  :HandleEvent(EVENTS.Birth)
function raidFour:OnEventBirth(EventData)
  MESSAGE:New("Fired 4",10, "Debug"):ToAll()
  left4:Activate()
  right4:Activate()
  back4:Activate()
end

local left5 = GROUP:FindByName("B17FiveLeft")
local right5 = GROUP:FindByName("B17FiveRight")
local back5 = GROUP:FindByName("B17FiveBack")

local raidFive = GROUP:FindByName("B17FiveLeader")
  :HandleEvent(EVENTS.Birth)
function raidFive:OnEventBirth(EventData)
  MESSAGE:New("Fired 5",10, "Debug"):ToAll()
  left5:Activate()
  right5:Activate()
  back5:Activate()
end

local left6 = GROUP:FindByName("B17SixLeft")
local right6 = GROUP:FindByName("B17SixRight")
local back6 = GROUP:FindByName("B17SixBack")

local raidSix = GROUP:FindByName("B17SixLeader")
  :HandleEvent(EVENTS.Birth)
function raidSix:OnEventBirth(EventData)
  MESSAGE:New("Fired 6",10, "Debug"):ToAll()
  left6:Activate()
  right6:Activate()
  back6:Activate()
end

--local raidIndex = 0
--local raids = {raidOne, raidTwo, raidThree, raidFour, raidFive, raidSix}
--
--local spawnRaids = SCHEDULER:New(nil,function()
--    
--    raidIndex = raidIndex + 1
--    raids[raidIndex]:Activate()
--      
--end ,{},0,10)


