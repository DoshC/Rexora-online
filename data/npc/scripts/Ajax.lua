local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
	local player = isPlayer(cid)
	if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 1 or getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) > 3 then
		npcHandler:setMessage(MESSAGE_GREET, "Whatcha do in my place?")
	elseif getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 2 and getPlayerStorageValue(cid,OutfitQuest.BarbarianAddonWaitTimer) < os.time() then
		npcHandler:setMessage(MESSAGE_GREET, "You back. You know, you right. Brother is right. Fist not always good. Tell him that!")
		setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 3)
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	-- PREQUEST
	if msgcontains(msg, "mine") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 1 then
			npcHandler:say("YOURS? WHAT IS YOURS! NOTHING IS YOURS! IS MINE! GO AWAY, YES?!", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "no") then
		if TopicState[cid] == 1 then
			npcHandler:say("YOU STUPID! STUBBORN! I KILL YOU! WILL LEAVE NOW?!", cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			npcHandler:say("ARRRRRRRRRR! YOU ME DRIVE MAD! HOW I MAKE YOU GO??", cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 3 then
			npcHandler:say("I GIVE YOU NO!", cid)
			TopicState[cid] = 4
		end
	elseif msgcontains(msg, "please") then
		if TopicState[cid] == 4 then
			npcHandler:say("Please? What you mean please? Like I say please you say bye? Please?", cid)
			TopicState[cid] = 5
		end
	-- OUTFIT
	elseif msgcontains(msg, "gelagos") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 4 then
			npcHandler:say("Annoying kid. Bro hates him, but talking no help. Bro needs {fighting spirit}!", cid)
			TopicState[cid] = 6
		end
	elseif msgcontains(msg, "fighting spirit") then
		if TopicState[cid] == 6 then
			npcHandler:say("If you want to help bro, bring him fighting spirit. Magic fighting spirit. Ask Djinn.", cid)
			setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 5)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "present") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 11 then
			npcHandler:say("Bron gave me present. Ugly, but nice from him. Me want to give present too. You help me?", cid)
			TopicState[cid] = 6
		end
	elseif msgcontains(msg, "ore") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 12 then
			npcHandler:say("You bring 100 iron ore?", cid)
			TopicState[cid] = 8
		end
	elseif msgcontains(msg, "iron") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 13 then
			npcHandler:say("You bring crude iron?", cid)
			TopicState[cid] = 9
		end
	elseif msgcontains(msg, "fangs") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 14 then
			npcHandler:say("You bring 50 behemoth fangs?", cid)
			TopicState[cid] = 10
		end
	elseif msgcontains(msg, "leather") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 15 then
			npcHandler:say("You bring 50 lizard leather?", cid)
			TopicState[cid] = 11
		end
	elseif msgcontains(msg, "axe") then
		if getPlayerStorageValue(cid,OutfitQuest.BarbarianAddon) == 16 and getPlayerStorageValue(cid,OutfitQuest.BarbarianAddonWaitTimer) < os.time() then
			npcHandler:say("Axe is done! For you. Take. Wear like me.", cid)
			setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 17)
			doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
			if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 147, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 143, 2)
		else
			npcHandler:say("Axe is not done yet!", cid)
		end
		end
	-- OUTFIT
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 5 then
			npcHandler:say("Oh. Easy. Okay. Please is good. Now don't say anything. Head aches. ", cid)
			setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 2)
			setPlayerStorageValue(cid,OutfitQuest.BarbarianAddonWaitTimer, os.time() + 60 * 60) -- 1 hour
			npcHandler:releaseFocus(cid)
			npcHandler:resetNpc(cid)
		elseif TopicState[cid] == 6 then
			npcHandler:say("Good! Me make shiny weapon. If you help me, I make one for you too. Like axe I wear. I need stuff. Listen. ...",cid)
			addEvent(selfSay, 3000,	"Me need 100 iron ore. Then need crude iron. Then after that 50 behemoth fangs. And 50 lizard leather. You understand?",cid)
			addEvent(selfSay, 6000,	"Help me yes or no?", cid)
			TopicState[cid] = 7
		elseif TopicState[cid] == 7 then
			npcHandler:say("Good. You get 100 iron ore first. Come back.", cid)
			TopicState[cid] = 0
			setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 12)
		elseif TopicState[cid] == 8 then
			if doPlayerRemoveItem(cid,5880, 100) then
				npcHandler:say("Good! Now bring crude iron.", cid)
				setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 13)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 9 then
			if doPlayerRemoveItem(cid,5892, 1) then
				npcHandler:say("Good! Now bring 50 behemoth fangs.", cid)
				setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 14)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 10 then
			if doPlayerRemoveItem(cid,5893, 50) then
				npcHandler:say("Good! Now bring 50 lizard leather.", cid)
				setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 15)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 11 then
			if doPlayerRemoveItem(cid,5876, 50) then
				npcHandler:say("Ah! All stuff there. I will start making axes now. Come later and ask me for axe.", cid)
				setPlayerStorageValue(cid,OutfitQuest.BarbarianAddon, 16)
				setPlayerStorageValue(cid,OutfitQuest.BarbarianAddonWaitTimer, os.time() + 2 * 60 * 60) -- 2 hours
				TopicState[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())