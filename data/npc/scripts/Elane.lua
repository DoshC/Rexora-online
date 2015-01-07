local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, "addon") or msgcontains(msg, "outfit") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterHatAddon) < 1 then
			npcHandler:say("Oh, my winged tiara? Those are traditionally awarded after having completed a difficult {task} for our guild, only to female aspirants though. Male warriors will receive a hooded cloak.", cid)
			TopicState[cid] = 1
		end
	elseif msgcontains(msg, "task") then
		if TopicState[cid] == 1 then
			npcHandler:say("So you are saying that you would like to prove that you deserve to wear such a hooded cloak?", cid)
			TopicState[cid] = 2
		end
	elseif msgcontains(msg, "crossbow") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterHatAddon) == 1 then
			npcHandler:say("I'm so excited! Have you really found my crossbow?", cid)
			TopicState[cid] = 4
		end
	elseif msgcontains(msg, "leather") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterHatAddon) == 2 then
			npcHandler:say("Did you bring me 100 pieces of lizard leather and 100 pieces of red dragon leather?", cid)
			TopicState[cid] = 5
		end
	elseif msgcontains(msg, "chicken wing") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterHatAddon) == 3 then
			npcHandler:say("Were you able to get hold of 5 enchanted chicken wings?", cid)
			TopicState[cid] = 6
		end
	elseif msgcontains(msg, "steel") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterHatAddon) == 4 then
			npcHandler:say("Ah, have you brought one piece of royal steel, draconian steel and hell steel each?", cid)
			TopicState[cid] = 7
		end
	elseif msgcontains(msg, "sniper gloves") then
		if getPlayerStorageValue(cid,OutfitQuest.HunterBodyAddon) < 1 then
			npcHandler:say("You found sniper gloves?! Incredible! Listen, if you give them to me, I will grant you the right to wear the sniper gloves accessory. How about it?", cid)
			TopicState[cid] = 8
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 2 then
			npcHandler:say("Alright, I will give you a chance. Pay close attention to what I'm going to tell you now. ...",cid)
			addEvent(selfSay, 3000,	"Recently, one of our members moved to Liberty Bay out of nowhere, talking about some strange cult. That is not the problem, but he took my favourite crossbow with him. ...",cid)
			addEvent(selfSay, 6000,	"Please find my crossbow. It has my name engraved on it and is very special to me. ...",cid)
			addEvent(selfSay, 9000,	"Secondly, we need a lot of leather for new quivers. 100 pieces of lizard leather and 100 pieces of red dragon leather should suffice. ...",cid)
			addEvent(selfSay, 12000,	"Third, since we are giving out tiaras, we are always in need of enchanted chicken wings. Please bring me 5, that would help us tremendously. ...",cid)
			addEvent(selfSay, 15000,	"Lastly, for our arrow heads we need a lot of steel. Best would be one piece of royal steel, one piece of draconian steel and one piece of hell steel. ...",cid)
			addEvent(selfSay, 18000,	"Did you understand everything I told you and are willing to handle this task?", cid)
			TopicState[cid] = 3
		elseif TopicState[cid] == 3 then
			npcHandler:say("That's the spirit! I hope you will find my crossbow, " .. getCreatureName(cid) .. "!", cid)
			setPlayerStorageValue(cid,OutfitQuest.HunterHatAddon, 1)
			setPlayerStorageValue(cid,OutfitQuest.DefaultStart, 1) --this for default start of Outfit and Addon Quests
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			if doPlayerRemoveItem(cid,5947, 1) then
				npcHandler:say("Yeah! I could kiss you right here and there! Besides, you're a handsome one. <giggles> Please bring me 100 pieces of lizard leather and 100 pieces of red dragon leather now!", cid)
				setPlayerStorageValue(cid,OutfitQuest.HunterHatAddon, 2)
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif TopicState[cid] == 5 then
			if getPlayerItemCount(cid,5876) >= 100 and getPlayerItemCount(cid,5948) >= 100  then
				npcHandler:say("Good work, " .. getCreatureName(cid) .. "! That is enough leather for a lot of sturdy quivers. Now, please bring me 5 enchanted chicken wings.", cid)
				doPlayerRemoveItem(cid,5876, 100)
				doPlayerRemoveItem(cid,5948, 100)
				setPlayerStorageValue(cid,OutfitQuest.HunterHatAddon, 3)
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif TopicState[cid] == 6 then
			if doPlayerRemoveItem(cid,5891, 5) then
				npcHandler:say("Great! Now we can create a few more Tiaras. If only they weren't that expensive... Well anyway, please obtain one piece of royal steel, draconian steel and hell steel each.", cid)
				setPlayerStorageValue(cid,OutfitQuest.HunterHatAddon, 4)
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif TopicState[cid] == 7 then
			if getPlayerItemCount(cid,5887) >= 1 and getPlayerItemCount(cid,5888) >= 1 and getPlayerItemCount(cid,5889) >= 1  then
				npcHandler:say("Wow, I'm impressed, " .. getCreatureName(cid) .. ". Your really are a valuable member of our paladin guild. I shall grant you your reward now. Wear it proudly!", cid)
				doPlayerRemoveItem(cid,5887, 1)
				doPlayerRemoveItem(cid,5888, 1)
				doPlayerRemoveItem(cid,5889, 1)
				setPlayerStorageValue(cid,OutfitQuest.HunterHatAddon, 5)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 129, 1)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 137, 2)
				end
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		elseif TopicState[cid] == 8 then
			if doPlayerRemoveItem(cid,5875, 1) then
				npcHandler:say("Great! I hereby grant you the right to wear the sniper gloves as accessory. Congratulations!", cid)
				setPlayerStorageValue(cid,OutfitQuest.HunterBodyAddon, 1)
				doSendMagicEffect(getPlayerPosition(cid),CONST_ME_MAGIC_BLUE)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfit(cid, 129, 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfit(cid, 137, 1)
				end
				TopicState[cid] = 0
			else
				npcHandler:say("You don't have it...", cid)
			end
		end
	elseif msgcontains(msg, "no") then
		if npcHandler.topic[cid] > 1 then
			npcHandler:say("Then no.", cid)
			TopicState[cid] = 0
		end
	return true
	end
end

keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = "I am the leader of the Paladins. I help our members."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am the leader of the Paladins. I help our members."})
keywordHandler:addKeyword({'paladins'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins are great warriors and magicians. Besides that we are excellent missile fighters. Many people in Tibia want to join us."})
keywordHandler:addKeyword({'warriors'}, StdModule.say, {npcHandler = npcHandler, text = "Of course, we aren't as strong as knights, but no druid or sorcerer will ever defeat a paladin with a sword."})
keywordHandler:addKeyword({'magicians'}, StdModule.say, {npcHandler = npcHandler, text = "There are many magic spells and runes paladins can use."})
keywordHandler:addKeyword({'missile'}, StdModule.say, {npcHandler = npcHandler, text = "Paladins are the best missile fighters in Tibia!"})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "I am a paladin, not a storyteller."})
keywordHandler:addKeyword({'members'}, StdModule.say, {npcHandler = npcHandler, text = "Every paladin profits from his vocation. It has many advantages to be a paladin."})
keywordHandler:addKeyword({'advantages'}, StdModule.say, {npcHandler = npcHandler, text = "We will help you to improve your skills. Besides I offer spells for paladins."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, text = "Harkath Bloodblade is the royal general."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "Some paladins serve in the kings army."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, text = "He has some potential."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, text = "How spineless do you have to be to become a jester?"})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, text = "The McRonalds are simple farmers."})
keywordHandler:addKeyword({'eclesius'}, StdModule.say, {npcHandler = npcHandler, text = "He must have been skilled before he became the way he is now. Such a pity."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, text = "Yes?"})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, text = "The alcohol he sells shrouds the mind and the eye."})
keywordHandler:addKeyword({'galuna'}, StdModule.say, {npcHandler = npcHandler, text = "One of the most important members of our guild. She makes all the bows and arrows we need."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, text = "He sells a lot of useful equipment."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, text = "He and his guildfellows lack the grace of a true warrior."})
keywordHandler:addKeyword({'harkath bloodblade'}, StdModule.say, {npcHandler = npcHandler, text = "A fine warrior and a skilled general."})
keywordHandler:addKeyword({'king tibianus'}, StdModule.say, {npcHandler = npcHandler, text = "King Tibianus is a wise ruler."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, text = "A follower of evil that will get what he deserves one day."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, text = "Mhm, a little too nice for my taste. Still, it's amazing how she endures all those men stalking her, especially this creepy Oswald."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, text = "A skilled healer, that's for sure."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, text = "Just another arrogant sorcerer."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, text = "If there wouldn't be higher powers to protect him..."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, text = "A humble monk and a wise man."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, text = "Strong man. But a little shy."})

npcHandler:setMessage(MESSAGE_GREET, "Welcome to the paladins' guild, |PLAYERNAME|! How can I help you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())