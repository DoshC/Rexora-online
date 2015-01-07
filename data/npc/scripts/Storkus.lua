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
	elseif(msgcontains(msg, "mission")) then
		if(getPlayerStorageValue(cid,TheInquisition.Questline) == 6) then
			if(getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust) < 0) then
				setPlayerStorageValue(cid,TheInquisition.StorkusVampiredust, 0)
			end
			if(getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust) < 20) then
				getPlayerItemCount(cid,5905)
				npcHandler:say("So far ye've brought me of 20 {vampire dusts}. Do ye' have any more with ye'? ", cid)
				TopicState[cid] = 1
			elseif(getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust) == 20) then
				npcHandler:say("Fine, you're done! Ye' should talk to me about your {mission} again now.", cid)
				TopicState[cid] = 2
				setPlayerStorageValue(cid,TheInquisition.Questline, 7)
				setPlayerStorageValue(cid,TheInquisition.Mission03, 2) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			end
		elseif(getPlayerStorageValue(cid,TheInquisition.Questline) == 7) then
			npcHandler:say("While ye' were keeping the lower ranks busy, I could get valuable information about some vampire lords. ...",cid)
			addEvent(selfSay, 5000,"One of them is hiding somewhere beneath the Green Claw Swamp. I expect ye' to find him and kill him. ...",cid)
			addEvent(selfSay, 10000,"But be warned: Without good preparation, ye' might get into trouble. I hope for ye' he will be sleeping in his coffin when ye' arrive. ...",cid)
			addEvent(selfSay, 15000,"Before ye' open his coffin and drag that beast out to destroy it, I advise ye' to place some garlic necklaces on the stone slabs next to his coffin. That will weaken him considerably. ...",cid)
			addEvent(selfSay, 20000,"Bring me his ring as proof for his death. And now hurry and good hunt to ye'.",cid)
			setPlayerStorageValue(cid,TheInquisition.Questline, 8)
			setPlayerStorageValue(cid,TheInquisition.Mission03, 3) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			TopicState[cid] = 0
		elseif(getPlayerStorageValue(cid,TheInquisition.Questline) == 8 or getPlayerStorageValue(cid,TheInquisition.Questline) == 9) then
			if(doPlayerRemoveItem(cid,8752, 1)) then
				npcHandler:say("Ding, dong, the vampire is dead, eh? So I guess ye' can return to Henricus and tell him that ye' finished your job here. I'm quite sure he has some more challenging task up his sleeve. ...",cid)
				addEvent(selfSay, 4000,"One more thing before ye' leave: I already mentioned the master vampires. ...",cid)
				addEvent(selfSay, 8000,"They are quite hard to find. If ye' stumble across one of them and manage to kill him, he will surely drop some token that proves his death. Bring me these tokens. ...",cid)
				addEvent(selfSay, 12000,"If ye' kill enough of them, I might have a little surprise for ye'.",cid)
				setPlayerStorageValue(cid,TheInquisition.Questline, 10)
				setPlayerStorageValue(cid,TheInquisition.Mission03, 5) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say("Have ye' killed the vampire lord? Because ye' have no his ring.", cid)
			end
			TopicState[cid] = 0
		end
	elseif(msgcontains(msg, "vampire lord token") and getPlayerStorageValue(cid,TheInquisition.Questline) == 10) then
		if(getPlayerStorageValue(cid,402) < 1) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 3
		elseif(getPlayerStorageValue(cid,402) == 1) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 4
		elseif(getPlayerStorageValue(cid,402) == 2) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 5
		elseif(getPlayerStorageValue(cid,402) == 3) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 6
		elseif(getPlayerStorageValue(cid,402) == 4) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 7
		elseif(getPlayerStorageValue(cid,402) == 5) then
			npcHandler:say("Would ye' like to give me vampire tokens?", cid)
			TopicState[cid] = 8
		end
	elseif(msgcontains(msg, "yes")) then
		if(TopicState[cid] == 1) then
			count = getPlayerItemCount(cid,5905)
			requiredCount = 20 - getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust)
			if(count > requiredCount) then
				count = requiredCount
			end
			setPlayerStorageValue(cid,TheInquisition.StorkusVampiredust, getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust) + count)
			doPlayerRemoveItem(cid,5905, count)
			npcHandler:say("Ye've brought me " .. count .. " vampire dusts. " .. (20 - getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust)) == 0 and ("Ask me for a {mission} to continue your quest.") or ("Ye' need to bring " .. (20 - getPlayerStorageValue(cid,TheInquisition.StorkusVampiredust)) .. " more."), cid)
			TopicState[cid] = 0
		elseif(TopicState[cid] == 3) then
			if(getPlayerItemCount(cid,9020) >= 1) then
				npcHandler:say("Ye' brought the token needed to advance to the first vampire hunter rank. I consider that a fluke, but still, congrats! Let me share some of my experience with ye'.", cid)
				setPlayerStorageValue(cid,402, 1)
				doPlayerRemoveItem(cid,9020, 1)
				doPlayerAddExp( 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		elseif(TopicState[cid] == 4) then
			if(getPlayerItemCount(cid,9020) >= 4) then
				npcHandler:say("Ye' brought the four tokens needed to advance to the second vampire hunter rank. Pretty lucky ye' are! Let me share some of my experience with ye'.", cid)
				setPlayerStorageValue(cid,402, 2)
				doPlayerRemoveItem(cid,9020, 4)
				doPlayerAddExp( 5 * 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		elseif(TopicState[cid] == 5) then
			if(getPlayerItemCount(cid,9020) >= 5) then
				npcHandler:say("Ye' brought the five tokens needed to advance to the third vampire hunter rank. Wow, you're pretty determined! Let me share some of my experience with ye'.", cid)
				setPlayerStorageValue(cid,402, 3)
				doPlayerRemoveItem(cid,9020, 5)
				doPlayerAddExp( 10 * 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		elseif(TopicState[cid] == 6) then
			if(getPlayerItemCount(cid,9020) >= 10) then
				npcHandler:say("Ye' brought the ten tokens needed to advance to the fourth vampire hunter rank. You're absolutely painstaking! Let me share some of my experience with ye'.", cid)
				setPlayerStorageValue(cid,402, 4)
				doPlayerRemoveItem(cid,9020, 10)
				doPlayerAddExp( 20 * 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		elseif(TopicState[cid] == 7) then
			if(getPlayerItemCount(cid,9020) >= 30) then
				npcHandler:say("Ye' brought the thirty tokens needed to advance to the fifth vampire hunter rank. You're completely obliterative, kid! Let me share some of my experience with ye'.", cid)
				setPlayerStorageValue(cid,402, 5)
				doPlayerRemoveItem(cid,9020, 30)
				doPlayerAddExp( 50 * 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		elseif(TopicState[cid] == 8) then
			if(getPlayerItemCount(cid,9020) >= 50) then
				npcHandler:say("Ye' brought the fifty tokens needed to advance to the last vampire hunter rank. Now that's something. You're razing-amazing! Let me share some of my experience and a little something with ye'!", cid)
				setPlayerStorageValue(cid,402, 6)
				doPlayerRemoveItem(cid,9020, 50)
				player:addItem(9019, 1)
				doPlayerAddExp( 100 * 1000, false, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", cid)
			end
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())