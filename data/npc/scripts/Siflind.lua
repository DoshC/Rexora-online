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
	elseif msgcontains(msg, "mission") then
		if getPlayerStorageValue(cid,TheIceIslands.Questline) == 5 then
			npcHandler:say("I heard you have already helped our cause. Are you interested in another mission, even when it requires you to travel to a distant land?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 7 then
			npcHandler:say("Well done. The termites caused just the distraction that we needed. Are you ready for the next step of my plan?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 9 then
			npcHandler:say("You saved the lives of many innocent animals. Thank you very much. If you are looking for another mission, just ask me.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 10)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 10 then
			npcHandler:say("Our warriors need a more potent yet more secure berserker elixir to fight our enemies. To brew it, I need several ingredients. The first things needed are 5 bat wings. Bring them to me and Ill tell you the next ingredients we need.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 11)
			setPlayerStorageValue(cid,TheIceIslands.Mission05, 1) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 11 then
			npcHandler:say("Do you have the 5 bat wings I requested?", cid)
			TopicState[cid] = 5
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 12 then
			npcHandler:say("The second things needed are 4 bear paws. Bring them to me and Ill tell you the next ingredients we need.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 13)
			setPlayerStorageValue(cid,TheIceIslands.Mission05, 2) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 13 then
			npcHandler:say("Do you have the 4 bear paws I requested?", cid)
			TopicState[cid] = 6
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 14 then
			npcHandler:say("The next things needed are 3 bonelord eyes. Bring them to me and Ill tell you the next ingredients we need.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 15)
			setPlayerStorageValue(cid,TheIceIslands.Mission05, 3) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 15 then
			npcHandler:say("Do you have the 3 bonelord eyes I requested?", cid)
			TopicState[cid] = 7 
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 16 then
			npcHandler:say("The next things needed are 2 fish fins. Bring them to me and Ill tell you the next ingredients we need.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 17)
			setPlayerStorageValue(cid,TheIceIslands.Mission05, 4) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 17 then
			npcHandler:say("Do you have the 2 fish fins I requested?", cid)
			TopicState[cid] = 8
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 18 then
			npcHandler:say("The last thing needed is a green dragon scale. Bring them to me and Ill tell you the next ingredients we need.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 19)
			setPlayerStorageValue(cid,TheIceIslands.Mission05, 5) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,TheIceIslands.Questline) == 19 then
			npcHandler:say("Do you have the green dragon scale I requested?", cid)
			TopicState[cid] = 9
		else 
		npcHandler:say("I have now no mission for you.", cid)
		TopicState[cid] = 0
		end
	elseif msgcontains(msg, "jug") then
		npcHandler:say("Do you want to buy a jug for 1000 gold?", cid)
		TopicState[cid] = 2
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("I am pleased to hear that. On the isle of Tyrsung foreign hunters have set up camp. They are hunting the animals there with no mercy. We will haveto find something that distracts them from hunting ...",cid)
			addEvent(selfSay, 4000,	"Take this jug here and travel to the jungle of Tiquanda. There you will find a race of wood eating ants called termites. Use the jug on one of their hills to catch some of them ...",cid)
			addEvent(selfSay, 8000,	"Then find someone in Svargrond that brings you to Tyrsung. There, release the termites on the bottom of a mast in the hull of the hunters' ship. If you are done, report to me about your mission.", cid)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 6)
			setPlayerStorageValue(cid,TheIceIslands.Mission03, 1) -- Questlog The Ice Islands Quest, Nibelor 2: Ecological Terrorism
			doPlayerAddItem(cid,7243, 1)
			TopicState[cid] = 0
		elseif TopicState[cid] == 2 then
			if getPlayerMoney(cid) >= 1000 then
				doPlayerRemoveMoney(cid,1000)
				npcHandler:say("Here you are.", cid)
				TopicState[cid] = 0
				doPlayerAddItem(cid,7243, 1)
			end
		elseif TopicState[cid] == 3 then
			npcHandler:say("Good! Now listen. To protect the animals there, we have to harm the profit of the hunters. Therefor, I ask you to ruin their best source of earnings. Are you willing to do that?", cid)
			TopicState[cid] = 4
		elseif TopicState[cid] == 4 then
			npcHandler:say("So let's proceed. Take this vial of paint. Travel to Tyrsung again and ruin as many pelts of baby seals as possible before the paint runs dry or freezes. Then return here to report about your mission. ", cid)
			doPlayerAddItem(cid,7253, 1)
			setPlayerStorageValue(cid,TheIceIslands.Questline, 8)
			setPlayerStorageValue(cid,TheIceIslands.Mission04, 1) -- Questlog The Ice Islands Quest, Nibelor 3: Artful Sabotage
			TopicState[cid] = 0
		elseif TopicState[cid] == 5 then -- Wings
			if getPlayerItemCount(cid,5894) >= 5 then
				doPlayerRemoveItem(cid,5894, 5)
				npcHandler:say("Thank you very much.", cid)
				setPlayerStorageValue(cid,TheIceIslands.Questline, 12)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 6 then -- Paws
			if getPlayerItemCount(cid,5896) >= 4 then
				doPlayerRemoveItem(cid,5896, 4)
				npcHandler:say("Thank you very much.", cid)
				setPlayerStorageValue(cid,TheIceIslands.Questline, 14)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 7 then -- Eyes
			if getPlayerItemCount(cid,5898) >= 3 then
				doPlayerRemoveItem(cid,5898, 3)
				npcHandler:say("Thank you very much.", cid)
				setPlayerStorageValue(cid,TheIceIslands.Questline, 16)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 8 then -- Fins
			if getPlayerItemCount(cid,5895) >= 2 then
				doPlayerRemoveItem(cid,5895, 2)
				npcHandler:say("Thank you very much.", cid)
				setPlayerStorageValue(cid,TheIceIslands.Questline, 18)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 9 then -- Scale
			if getPlayerItemCount(cid,5920) >= 1 then
				doPlayerRemoveItem(cid,5920, 1)
				npcHandler:say("Thank you very much. This will help us to defend Svargrond. But I heard young Nilsor is in dire need of help. Please contact him immediately.", cid)
				setPlayerStorageValue(cid,TheIceIslands.Questline, 20)
				setPlayerStorageValue(cid,TheIceIslands.Mission05, 6) -- Questlog The Ice Islands Quest, Nibelor 4: Berserk Brewery
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
			end
			TopicState[cid] = 0
		end
	end
	if msgcontains(msg, "buy animal cure") or msgcontains(msg, "animal cure") then -- animal cure for in service of yalahar
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 30 and getPlayerStorageValue(cid,InServiceofYalahar.Questline) <= 54 then
			npcHandler:say("You want to buy animal cure for 400 gold coins?", cid)
			TopicState[cid] = 13
		else
			npcHandler:say("Im out of stock.", cid)
		end
	elseif msgcontains(msg, "yes") and TopicState[cid] == 13 then
		if TopicState[cid] == 13 and doPlayerRemoveMoney(cid,400) then
			doPlayerAddItem(cid,9734, 1)	
			npcHandler:say("Here you go.", cid)
			TopicState[cid] = 0
		else
			npcHandler:say("You dont have enough of gold coins.", cid)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())