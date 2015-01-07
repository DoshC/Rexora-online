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
	elseif msgcontains(msg, "cough syrup") then
		npcHandler:say("I had some cough syrup a while ago. It was stolen in an ape raid. I fear if you want more cough syrup you will have to buy it in the druids guild in carlin.", cid)
	elseif msgcontains(msg, "addon") then
		if getPlayerStorageValue(cid,OutfitQuest.DruidBodyAddon) < 1 then
			npcHandler:say("Would you like to wear bear paws like I do? No problem, just bring me 50 bear paws and 50 wolf paws and I'll fit them on.", cid)
			setPlayerStorageValue(cid,OutfitQuest.DruidBodyAddon, 1)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "paws") then
		if getPlayerStorageValue(cid,OutfitQuest.DruidBodyAddon) == 1 then
			npcHandler:say("Have you brought 50 bear paws and 50 wolf paws?", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			if getPlayerItemCount(cid,5896) >= 50 and getPlayerItemCount(cid,5897) >= 50 then
				npcHandler:say("Excellent! Like promised, here are your bear paws. ", cid)
				doPlayerRemoveItem(cid,5896, 50)
				doPlayerRemoveItem(cid,5897, 50)
				setPlayerStorageValue(cid,OutfitQuest.DruidBodyAddon, 2)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 148, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 144, 2)
				end
				TopicState[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())