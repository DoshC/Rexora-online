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


local voices = {
	"<mumbles> So where was I again?",
	"<mumbles> Typical - you can never find a hero when you need one!",
	"<mumbles> Could the bonelord language be the invention of some madman?",
	"<mumbles> The curse algorithm of triplex shadowing has to be two times higher than an overcharged nanoquorx on the peripheral..."
}

local lastSound = 0
function onThink()
	if lastSound < os.time() then
		lastSound = (os.time() + 10)
		if math.random(100) < 20 then
			doCreatureSay(getNpcCid(),voices[math.random(#voices)], 1)
		end
	end
	npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
	local player = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, "mission")) then
		if(getPlayerStorageValue(cid,30) < 1 and getPlayerStorageValue(cid,120) == 7 and getPlayerStorageValue(cid,121) >= 5) then
			npcHandler:say("There is indeed something that needs our attention. In the far north, a new city named Yalahar was discovered. It seems to be incredibly huge. ...",cid)
			addEvent(selfSay, 3000,	"According to travelers, it's a city of glory and wonders. We need to learn as much as we can about this city and its inhabitants. ...",cid)
			addEvent(selfSay, 3000,	"Gladly the explorer's society already sent a representative there. Still, we need someone to bring us the information he was able to gather until now. ...",cid)
			addEvent(selfSay, 9000,	"Please look for the explorer's society's captain Maximilian in Liberty Bay. Ask him for a passage to Yalahar. There visit Timothy of the explorer's society and get his research notes. ...",cid)
			addEvent(selfSay, 12000,"It might be a good idea to explore the city a bit on your own before you deliver the notes here, but please make sure you don't lose them. ", cid)
			setPlayerStorageValue(cid,30, 1)
			npcHandler.topic[cid] = 0
		elseif(getPlayerStorageValue(cid,30) == 2) then
			npcHandler:say("Did you bring the papers I asked you for?", cid)
			TopicState[cid] = 1
		end
	elseif(msgcontains(msg, "yes")) then	
		if(TopicState[cid] == 1) then
			if(getPlayerItemCount(cid, 10090) >= 1) then
				doPlayerRemoveItem(cid, 10090, 1)
				setPlayerStorageValue(cid,30, 3)
				npcHandler:say("Oh marvellous, please excuse me. I need to read this text immediately. Here, take this small reward of 500 gold pieces for your efforts.", cid)
				doPlayerAddMoney(cid, 500)
				TopicState[cid] = 0
			end
		end
	--The New Frontier
	elseif(msgcontains(msg, "farmine")) then
		if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 15) then
			npcHandler:say("I've heard some odd rumours about this new dwarven outpost. But tell me, what has the Edron academy to do with Farmine?", cid)
			TopicState[cid] = 30
		end
	elseif(msgcontains(msg, "plea")) then
		if(TopicState[cid] == 30) then
			if(getPlayerStorageValue(cid,TheNewFrontier.BribeWydrin) < 1) then
				npcHandler:say("Hm, you are right, we are at the forefront of knowledge and innovation. Our dwarven friends could learn much from one of our representatives.", cid)
				setPlayerStorageValue(cid,TheNewFrontier.BribeWydrin, 1)
				setPlayerStorageValue(cid,TheNewFrontier.Mission05, getPlayerStorageValue(cid,TheNewFrontier.Mission05) + 1) --Questlog, The New Frontier Quest "Mission 05: Getting Things Busy"
			end
		end
	end
	return true
end
 
npcHandler:setMessage(MESSAGE_GREET, "Hello, what brings you here?")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())