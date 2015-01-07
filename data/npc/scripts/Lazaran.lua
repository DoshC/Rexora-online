local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}
local

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, "mission") and getPlayerStorageValue(cid,TheNewFrontier.Questline) == 9 then
			npcHandler:say("Me people wanting peace. No war with others. No war with little men. We few. We weak. Need help. We not wanting make war. No hurt.", cid)
			TopicState[cid] = 10
		elseif TopicState[cid] == 10 then
			npcHandler:say("You mean you want help us?", cid)
			TopicState[cid] = 11
	elseif msgcontains(msg, "help") and getPlayerStorageValue(cid,UnnaturalSelection.Questline) < 1 then
		npcHandler:say("Big problem we have! Skull of first leader gone. He ancestor of whole tribe but died long ago in war. We have keep his skull on our sacred place. ...",cid)
		addEvent(selfSay, 3000,	"Then one night, green men came with wolves... and one of wolves took skull and ran off chewing on it! We need back - many wisdom and power is in skull. Maybe they took to north fortress. But can be hard getting in. You try get our holy skull back?",cid)
			TopicState[cid] = 1
	elseif msgcontains(msg, "mission") and getPlayerStorageValue(cid,UnnaturalSelection.Questline) >= 1 then
		if getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 1 then
			npcHandler:say("Oh! You found holy skull? In bone pile you found?! Thank Pandor you brought! Me can have it back?", cid)
			TopicState[cid] = 2
		elseif getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 2 then
			npcHandler:say("You brought back skull of first leader. Hero of tribe! But we more missions to do. ...", cid)
			addEvent(selfSay, 3000,"Me and Ulala talk about land outside. We wanting to see more of land! Land over big water! But us no can leave tribe. No can cross water. Only way is skull of first leader. ...",cid)
			addEvent(selfSay, 6000,"What holy skull sees, tribe sees. That we believe. Can you bring holy skull over big water and show places?", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 3 then
			npcHandler:say("You say you was to where sun is hot and burning? And where trees grow as high as mountain? And where Fasuon cries white tears? Me can't wait to see!! Can have holy skull back?", cid)
			TopicState[cid] = 4
		elseif getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 4 then
			npcHandler:say("We been weak for too long! We prepare for great hunt. But still need many doings! You can help us?", cid)
			TopicState[cid] = 5
		elseif getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 13 then
			npcHandler:say("You well did! Great hunt is under best signs now. We prepare weapons and paint faces and then go! ...",cid)
			addEvent(selfSay, 3000,"No no, you no need to help us. But can prepare afterparty! Little men sent us stuff some time ago. Was strange water in there. Brown and stinky! But when we tried all tribe became veeeeeeery happy. ...",cid)
			addEvent(selfSay, 6000,"Now brown water is gone and we sad! Can you bring POT of brown water for party after great hunt? Just bring to me and me trade for shiny treasure.", cid)
			setPlayerStorageValue(cid,UnnaturalSelection.Questline, 14)
			setPlayerStorageValue(cid,UnnaturalSelection.Mission06, 2) --Questlog, Unnatural Selection Quest "Mission 6: Firewater Burn"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,UnnaturalSelection.Questline) == 14 then
			npcHandler:say("You bring us big pot of strange water from little men?", cid)
			TopicState[cid] = 6
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			npcHandler:say("You hero of our tribe if bring back holy skull!", cid)
			setPlayerStorageValue(cid,UnnaturalSelection.Questline, 1)
			setPlayerStorageValue(cid,UnnaturalSelection.Mission01, 1) --Questlog, Unnatural Selection Quest "Mission 1: Skulled"
			TopicState[cid] = 0
		elseif TopicState[cid] == 2 then
			if doPlayerRemoveItem(cid,11076, 1) then
				npcHandler:say("Me thank you much! All wisdom safe again now.", cid)
				setPlayerStorageValue(cid,UnnaturalSelection.Questline, 2)
				setPlayerStorageValue(cid,UnnaturalSelection.Mission01, 3) --Questlog, Unnatural Selection Quest "Mission 1: Skulled"
				TopicState[cid] = 0
			else
				npcHandler:say("You do not have it!", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 3 then
			npcHandler:say("Here take holy skull. You bring where you think is good. See as much as possible! See where other people live!", cid)
			doPlayerAddItem(cid,11076, 1)
			setPlayerStorageValue(cid,UnnaturalSelection.Questline, 3)
			setPlayerStorageValue(cid,UnnaturalSelection.Mission02, 1) --Questlog, Unnatural Selection Quest "Mission 2: All Around the World"
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			if getPlayerStorageValue(cid,UnnaturalSelection.Mission02) == 12 and getPlayerItemCount(cid,11076) >= 1 then
				npcHandler:say("We make big ritual soon and learn much about world outside. Me thank you many times for teaching us world. Very wise and adventurous you are!", cid)
				doPlayerRemoveItem(cid,11076, 1)
				setPlayerStorageValue(cid,UnnaturalSelection.Questline, 4)
				setPlayerStorageValue(cid,UnnaturalSelection.Mission02, 13) --Questlog, Unnatural Selection Quest "Mission 2: All Around the World"
				TopicState[cid] = 0
			else
				npcHandler:say("The skull have not seen all yet!", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 5 then
			npcHandler:say("We need to calm and make happy gods. Best go to Ulala. She is priest of us and can tell what needs doing.", cid)
			setPlayerStorageValue(cid,UnnaturalSelection.Questline, 5)
			setPlayerStorageValue(cid,UnnaturalSelection.Mission03, 1) --Questlog, Unnatural Selection Quest "Mission 3: Dance Dance Evolution"
			TopicState[cid] = 0
		elseif TopicState[cid] == 6 then
			if doPlayerRemoveItem(cid,2562, 1, 3) then
				npcHandler:say("We make big ritual soon and learn much about world outside. Me thank you many times for teaching us world. Very wise and adventurous you are!", cid)
				doPlayerAddItem(cid,11115, 1)
				setPlayerStorageValue(cid,UnnaturalSelection.Questline, 15)
				setPlayerStorageValue(cid,UnnaturalSelection.Mission06, 3) --Questlog, Unnatural Selection Quest "Mission 6: Firewater Burn"
				TopicState[cid] = 0
			else
				npcHandler:say("You do not have the brown strange water!", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 11 then
			setPlayerStorageValue(cid,TheNewFrontier.Questline, 10)
			setPlayerStorageValue(cid,TheNewFrontier.Mission03, 2) --Questlog, The New Frontier Quest "Mission 03: Strangers in the Night"
			TopicState[cid] = 0
		end
	end
	return true
end
npcHandler:setMessage(MESSAGE_GREET, "Me greet.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")  
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())