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



function creatureSayCallback(cid, type, msg)

	if (msgcontains(msg, "hello") or msgcontains(msg, "hi")) and (not npcHandler:isFocused(cid)) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor) == 1) then
		npcHandler:say("Wh .. What? How did you get here? Where are all the guards? You .. you could have killed me but yet you chose to talk? What a relief! ... So what brings you here my friend, if I might call you like that? ", cid)
		elseif(getPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor) == 2) then	
		npcHandler:say("Murderer! But .. I give in, you won! ... Dictate me your conditions but please, I beg you, spare my life. What do you want?",cid)
		npcHandler:addFocus(cid)
		TopicState[cid] = 0
		end
		
	elseif msgcontains(msg, "mission") then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 24) then
			if(getPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor) == 1) then
		npcHandler:say("Indeed, I can see the benefits of a mutual agreement. I will later read the details and send a letter to your superior. ", cid)
		setPlayerStorageValue(cid,InServiceofYalahar.Questline, 25)
		setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 3) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
		setPlayerStorageValue(cid,InServiceofYalahar.MrWestStatus, 1)
		TopicState[cid] = 0
	elseif(getPlayerStorageValue(cid,InServiceofYalahar.MrWestDoor) == 2) then
		npcHandler:say("Yes, for the sake of my life I'll accept those terms. I know when I have lost. Tell your master I will comply with his orders. ", cid)
		setPlayerStorageValue(cid,InServiceofYalahar.Questline, 25)
		setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 4) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
		setPlayerStorageValue(cid,InServiceofYalahar.MrWestStatus, 2)
		TopicState[cid] = 0
	end
	end
	end
	return true

end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
