local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

-- OTServ event handling functions start
function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg) end
function onPlayerEndTrade(cid)              npcHandler:onPlayerEndTrade(cid) end
function onPlayerCloseChannel(cid)          npcHandler:onPlayerCloseChannel(cid) end
function onThink()                          npcHandler:onThink() end
-- OTServ event handling functions end

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 5)
		if math.random(100) < 25 then
			npcHandler:say("Come and take a look at the finest gems in the lands of Tibia.", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, "fine vase") then
		if getPlayerStorageValue(cid,TravellingTrader.Mission04) == 1 then
			npcHandler:say("Rashid sent you, I suppose. Before I sell you that vase, one word of advice. ...",cid)
			addEvent(selfSay, 3000,	"Make room in your backpack so that I can place the vase carefully inside it. If it falls to the floor, it will most likely shatter or break if you try to pick it up again. ...",cid)
			addEvent(selfSay, 3000,	"This vase it not meant to be touched by human hands, so just keep your hands off it. Are you ready to buy that vase for 1000 gold?", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			if getPlayerMoney(cid) >= 1000 then
				npcHandler:say("Here it is.", cid)
				setPlayerStorageValue(cid,TravellingTrader.Mission04, 2)
				doPlayerAddItem(cid,8760, 1)
				doPlayerRemoveMoney(cid,1000)
			else
				npcHandler:say("You don't have enought money.", cid)
			end
			TopicState[cid] = 0
		end
	end
	return true
end

npcHandler:addModule(FocusModule:new())
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)