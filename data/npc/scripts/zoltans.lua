local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local TopicState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	local player = isPlayer(cid)
	if not npcHandler:isFocused(cid) then
		return false
	elseif msgcontains(msg, "myra") then
		if getPlayerStorageValue(cid,OutfitQuest.MageSummonerTiaraCloakAddon) == 10 then
			if getPlayerSex(cid) == 1 then
			doPlayerAddOutfit(cid, 133, 2)
			elseif getPlayerSex(cid) == 0 then
			doPlayerAddOutfit(cid, 138, 2)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
			setPlayerStorageValue(cid,OutfitQuest.MageSummonerTiaraCloakAddon, 11)
			npcHandler:say("Bah, I know. I received some sort of 'nomination' from our outpost in Port Hope. ...", cid)
			addEvent(selfSay, 3000,"Usually it takes a little more than that for an award though. However, I honour Myra's word. ...", cid)
		end
	end
	elseif msgcontains(msg, "proof") then
		if not getCreatureOutfit(getPlayerSex(cid) == 0 and 141 or 130, 2) then
			npcHandler:say("... I cannot believe my eyes. You retrieved this hat from Ferumbras' remains? That is incredible. If you give it to me, I will grant you the right to wear this hat as addon. What do you say?", cid)
			TopicState[cid] = 1
		else
			npcHandler:say("You already have second " .. (getPlayerSex(cid) == 0 and "summoner" or "mage") .. " addon.", cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "yes") and TopicState[cid] == 1 then
		if doPlayerRemoveItem(cid,5903, 1) then
			if getPlayerSex(cid) == 1 then
			doPlayerAddOutfit(cid, 130, 2)
			elseif getPlayerSex(cid) == 0 then
			doPlayerAddOutfit(cid, 141, 2)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_RED)
			npcHandler:say("I bow to you, player, and hereby grant you the right to wear Ferumbras´ hat as accessory. Congratulations!", cid)
		else
			npcHandler:say("Sorry you don't have the ferumbras hat.", cid)
			end
		end
		TopicState[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())