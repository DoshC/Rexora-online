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
			npcHandler:say("Selling weapons, ammunition and armor. Special offers only available here, have a look!", TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, "package for rashid") then
		if getPlayerStorageValue(cid,TravellingTrader.Mission02) >= 1 and getPlayerStorageValue(cid,TravellingTrader.Mission02) < 3 then
			npcHandler:say("Oooh, damn, I completely forgot about that. I was supposed to pick it up from the Outlaw Camp. ...",cid)
			addEvent(selfSay, 3000,	"I can't leave my shop here right now, please go and talk to Snake Eye about that package... I promise he won't make any trouble. ...",cid)
			addEvent(selfSay, 6000,	"Don't tell Rashid! I really don't want him to know that I forgot his order. Okay?", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("Thank you, I appreciate it. Don't forget to mention the package to Snake.", cid)
			setPlayerStorageValue(cid,TravellingTrader.Mission02, getPlayerStorageValue(cid,TravellingTrader.Mission02) + 1)
			TopicState[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings and Banor be with you, |PLAYERNAME|! May I interest you in a {trade} for weapons, ammunition or armor?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Farewell, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Farewell, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. If you're only interested in {distance} equipment, let me know.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())