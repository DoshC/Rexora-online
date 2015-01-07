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

local random_texts = {
	'Free escort to the depot for newcomers!',
	'Hello, is this your first visit to Thais? I can show you around a little.',
	'Need some help finding your way through Thais? Let me assist you.',
	'Talk to me if you need directions.'
}

local rnd_sounds = 0
function onThink()
	if rnd_sounds < os.time() then
		rnd_sounds = (os.time() + 10)
		if math.random(100) < 20 then
			npcHandler:say(cid,random_texts[math.random(#random_texts)], TALKTYPE_SAY)
		end
	end
	npcHandler:onThink()
end

local configMarks = {
	mark1 = {x = 32367, y = 32197, z = 7},
	mark2 = {x = 32321, y = 32212, z = 7}, 
	mark3 = {x = 32369, y = 32241, z = 7}
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if isInArray({"map", "marks"}, msg) then
		npcHandler:say("Would you like me to mark locations like - for example - the depot, bank and shops on your map?", player)
		TopicState[cid] = 1
	elseif msgcontains(msg, "yes") and TopicState[cid] == 1 then
		npcHandler:say("Here you go.", player)
		for _, a in pairs(configMarks) do
			doPlayerAddMapMark(cid, configMarks.mark1, MAPMARK_CROSS, 'Shops')
			doPlayerAddMapMark(cid, configMarks.mark2, MAPMARK_CROSS, 'Depot')
			doPlayerAddMapMark(cid, configMarks.mark3, MAPMARK_CROSS, 'Temple')
		end
		TopicState[cid] = 0
	elseif msgcontains(msg, "no") and npcHandler.topic[cid] >= 1 then
		npcHandler:say("Well, nothing wrong about exploring the town on your own. Let me know if you need something!", player)
		TopicState[cid] = 0	
	end
	return true
end

keywordHandler:addKeyword({'information'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I can tell you all about the {town}, its {temple}, the {bank}, {shops}, {spell trainers} and the {depot}, as well as about the {world status}.'})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The temple is in the centre of Thais. Walk east from the harbour and pass by the {depot} until you reach the infamous crossroads, then turn south.'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'We have two bankers, Suzy and Naji. Naji is right in the depot. For Suzi, exit the {depot} to the west and walk south-west. Don\'t forget that I can {mark} important locations on your map.'})
keywordHandler:addKeyword({'shops'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You can buy {weapons}, {armor}, {tools}, {gems}, {magical} equipment, {furniture} and {food} here.'})
keywordHandler:addKeyword({'depot'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The depot is a place where you can safely store your belongings. You are also protected against attacks there. I {escort} newcomers there.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I\'m a guide, overworked and underpaid. I can mark important locations on your map and give you some information about the town and the world status.'})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Thais is the oldest settlement in Tibia. You can hear its history whisper when walking through the streets. Beware of criminals, but else it\'s a fine city.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I\'m Luke. No jokes, please, I heard them all!'})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Hello there, |PLAYERNAME| and welcome to Thais! Would you like some {information} and a {map} guide?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye and enjoy your stay in Thais, |PLAYERNAME|.")
npcHandler:addModule(FocusModule:new())
