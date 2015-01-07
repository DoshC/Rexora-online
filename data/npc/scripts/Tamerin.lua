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
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 30) then
		npcHandler:say("Have you the {animal cure}", cid)
		elseif(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 31) then
		npcHandler:say("Have you killed {morik}",cid)
		else
		npcHandler:say("Hello, what brings you here?",cid)
		npcHandler:addFocus(cid)
		TopicState[cid] = 0
		end
		
	elseif(msgcontains(msg, "mission")) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 29) then
			npcHandler:say("Why should I do something for another human being? I have been on my own for all those years. Hmm, but actually there is something I could need some assistance with. ... ",cid)
			addEvent(selfSay, 4000,"If you help me to solve my problems, I will help you with your mission. Do you accept?",cid)
			TopicState[cid] = 1
		elseif(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 32) then
			npcHandler:say("You have kept your promise. Now, it's time to fulfil my part of the bargain. What kind of animals shall I raise? {Warbeasts} or {cattle}?", cid)
			TopicState[cid] = 2
		end
	elseif(msgcontains(msg, "animal cure")) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 30 and getPlayerItemCount(cid, 9734) >= 1) then
			doPlayerRemoveItem(cid,9734, 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 31)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 4) -- StorageValue for Questlog "Mission 05: Food or Fight"
			npcHandler:say("Thank you very much. As I said, as soon as you have helped me to solve both of my problems, we will talk about your mission. Have you killed {morik}? ", cid)
			TopicState[cid] = 0
		else
			npcHandler:say("Come back when you have the cure.", cid)
		end
	elseif(msgcontains(msg, "cattle")) then
		if(TopicState[cid] == 2) then
			setPlayerStorageValue(cid,InServiceofYalahar.TamerinStatus, 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 32)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 6) -- StorageValue for Questlog "Mission 05: Food or Fight"
			npcHandler:say("So be it! ", cid)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "warbeast")) then
		if(TopicState[cid] == 2) then
			setPlayerStorageValue(cid,InServiceofYalahar.TamerinStatus, 2)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 32)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 7) -- StorageValue for Questlog "Mission 05: Food or Fight"
			npcHandler:say("So be it! ", cid)
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "morik")) then
		if(getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 31 and getPlayerItemCount(cid, 9735) >= 1) then
			doPlayerRemoveItem(cid,9735, 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 32)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 5) -- StorageValue for Questlog "Mission 05: Food or Fight"
			npcHandler:say("So he finally got what he deserved. As I said, as soon as you have helped me to solve both of my problems, we will talk about your {mission}. ", cid)
			TopicState[cid] = 0
		else
			npcHandler:say("Come back when you got rid with Morik.", cid)
		end
	elseif(msgcontains(msg, "yes")) then
		if(TopicState[cid] == 1) then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 30)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 3) -- StorageValue for Questlog "Mission 05: Food or Fight"
			npcHandler:say("I ask you for two things! For one thing, I need an animal cure and for another thing, I ask you to get rid of the gladiator Morik for me. ", cid)
			TopicState[cid] = 0
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)