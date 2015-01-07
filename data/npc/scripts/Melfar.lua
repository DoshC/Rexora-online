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

local function creatureSayCallback(cid, type, msg)
	local player = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif(msgcontains(msg, "mission")) then
		if(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 4) then
			npcHandler:say("Ha! Men and wood you say? Well, I might be able to relocate some of our miners to the base. Acquiring wood is an entirely different matter though. ... ",cid)
			addEvent(selfSay, 3000,	"I can't spare any men for woodcutting right now but I have an unusual idea that might help. ... ",cid)
			addEvent(selfSay, 6000,	"As you might know, this area is troubled by giant beavers. Once a year, the miners decide to have some fun, so they lure the beavers and jump on them to have some sort of rodeo. ... ",cid)
			addEvent(selfSay, 9000,	"However, I happen to have some beaver bait left from the last year's competition. ... ",cid)
			addEvent(selfSay, 12000,"If you place it on trees on some strategic locations, we could let the beavers do the work and later on, I'll send men to get the fallen trees. ... ",cid)
			addEvent(selfSay, 15000,"Does this sound like something you can handle? ", cid)
			TopicState[cid] = 1
		elseif(getPlayerStorageValue(cid,TheNewFrontier.Questline) == 6) then
			npcHandler:say("Yes, I can hear them even from here. It has to be a legion of beavers! I'll send the men to get the wood as soon as their gnawing frenzy has settled! You can report to Ongulf that men and wood will be on their way!", cid)
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 7)
			setPlayerStorageValue(cid,TheNewFrontier.Mission02, 6) --Questlog, The New Frontier Quest "Mission 02: From Kazordoon With Love"
		end
	elseif(msgcontains(msg, "yes")) then
		if(TopicState[cid] == 1) then
			npcHandler:say("So take this beaver bait. It will work best on dwarf trees. I'll mark the three trees on your map. Here .. here .. and here! So now mark those trees with the beaver bait. ... ",cid)
			addEvent(selfSay, 3000,	"If you're unlucky enough to meet one of the giant beavers, try to stay calm. Don't do any hectic moves, don't yell, don't draw any weapon, and if you should carry anything wooden on you, throw it away as far as you can. ",cid)
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 5)
			setPlayerStorageValue(cid,TheNewFrontier.Mission02, 2) --Questlog, The New Frontier Quest "Mission 02: From Kazordoon With Love"
			doPlayerAddItem(cid,11100, 1)
			doPlayerAddMapMark(cid,{x = 32474, y = 31947, z = 7}, 2, "Tree 1")
			doPlayerAddMapMark(cid,{x = 32515, y = 31927, z = 7}, 2, "Tree 2")
			doPlayerAddMapMark(cid,{x = 32458, y = 31997, z = 7}, 2, "Tree 3")
			TopicState[cid] = 0
		elseif TopicState[cid] == 2 then 
			if getPlayerMoney(cid) >= 100 then
				doPlayerAddItem(cid,11100, 1)	
				npcHandler:say("Here you go.", cid)
				TopicState[cid] = 0
			else
				npcHandler:say("You dont have enough of gold coins.", cid)
				TopicState[cid] = 0
			end
		end
	elseif msgcontains(msg, "buy flask") or msgcontains(msg, "flask") then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 5 then
			npcHandler:say("You want to buy a Flask with Beaver Bait for 100 gold coins?", cid)
			TopicState[cid] = 2
		else
			npcHandler:say("Im out of stock.", cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
