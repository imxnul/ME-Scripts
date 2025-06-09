local API = require("api")
API.SetMaxIdleTime(5)

local function getBuff(buffId)
  local buff = API.Buffbar_GetIDstatus(buffId, false)
  return { found = buff.found, remaining = (buff.found and API.Bbar_ConvToSeconds(buff)) or 0 }
end

local function extraActionButtonVisible()
  return API.VB_FindPSettinOrder(10254).state == 3
end

local function doExtraActionButton()
  if extraActionButtonVisible() then
	API.logWarn("Clicking extra action button")
	API.DoAction_Interface(0x2e, 0xffffffff, 1, 743, 1, -1, API.OFF_ACT_GeneralInterface_route)
	API.RandomSleep2(1000, 300, 300)
	end
end

local function useExcali()
  API.RandomSleep2(4000, 1000, 1000)
  API.DoAction_Inventory1(36619,0,1,API.OFF_ACT_GeneralInterface_route) -- augmented Excal ID
  API.RandomSleep2(4000, 1000, 1000)
end

local function readExcalibur()
  local buffs = API.DeBuffbar_GetIDstatus(14632)
  if buffs.conv_text < 1 then
    useExcali()
   print("Excalibur time!")
return true
  else
    return false 
  end
end

while API.Read_LoopyLoop(true) do
local darkness = getBuff(30122)
local prayren = getBuff(14695)
local prayer = API.GetPrayPrecent()
local hp = API.GetHP_()

if not prayren.found or (prayren.found and prayren.remaining <= math.random(2, 45)) then
  if API.DoAction_Inventory2({ 33186, 33184, 33182, 33180, 33178, 33176, 23609, 23611, 23613, 23615, 23617, 23619, 21630, 21632, 21634, 21636 }, 0, 1, API.OFF_ACT_GeneralInterface_route) then
    API.RandomSleep2(300, 200, 200)
  end
end

if prayer < math.random(200, 400) then
  if API.DoAction_Inventory2({ 23399, 23401, 23403, 23405, 23407, 23409, 3024, 3026, 3028, 3030 }, 0, 1, API.OFF_ACT_GeneralInterface_route) then
    API.RandomSleep2(300, 200, 200)
  end
end

if not darkness.found or (darkness.found and darkness.remaining <= math.random(10, 120)) then
  if API.DoAction_Ability("Darkness", 1, API.OFF_ACT_GeneralInterface_route, false) then
    API.RandomSleep2(300, 200, 200)
  end
end

if hp < math.random(4250, 6500) then
  readExcalibur() 
end

if hp < math.random(2500, 4000) then
	if API.DoAction_Ability("Eat food", 1, API.OFF_ACT_GeneralInterface_route, false) then
  API.RandomSleep2(300, 200, 200)
  end
end

if prayer < math.random(5, 15) then
	API.Write_LoopyLoop(false)	
end
doExtraActionButton()
end



