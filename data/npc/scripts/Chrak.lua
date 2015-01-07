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
	elseif msgcontains(msg, "battle") then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 24 then
			npcHandler:say("Zo you want to enter ze arena, you know ze rulez and zat zere will be no ozer option zan deaz or victory?",cid)
			addEvent(selfSay, 3000,	"My mazter wantz to zurprize hiz opponentz by an unexpected move. He will uze warriorz from ze outzide, zomeone zat no one can azzezz. ... ",cid)
			addEvent(selfSay, 3000,	"One of ziz warriorz could be you. Or you could ztay here and rot in ze dungeon. Are you interezted in ziz deal? ", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "mission") then
		if getPlayerStorageValue(cid,TheNewFrontier.Questline) == 26 then
			npcHandler:say("You have done ze impozzible and beaten ze champion. Your mazter will be pleazed. Hereby I cleanze ze poizon from your body. You are now allowed to leave. ...",cid)
			addEvent(selfSay, 3000,	"For now ze mazter will zee zat you and your alliez are zpared of ze wraz of ze dragon emperor az you are unimportant for hiz goalz. ...",cid)
			addEvent(selfSay, 3000,	"You may crawl back to your alliez and warn zem of ze gloriouz might of ze dragon emperor and hiz minionz.", cid)
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 27)
			setPlayerStorageValue(cid,TheNewFrontier.Mission09, 3) --Questlog, The New Frontier Quest "Mission 09: Mortal Combat"
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("Asss you wishzz.", cid)
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 25)
			setPlayerStorageValue(cid,TheNewFrontier.Mission08, 2) --Questlog, The New Frontier Quest "Mission 08: An Offer You Can't Refuse"
			setPlayerStorageValue(cid,TheNewFrontier.Mission09, 1) --Questlog, The New Frontier Quest "Mission 09: Mortal Combat"
			TopicState[cid] = 0
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
