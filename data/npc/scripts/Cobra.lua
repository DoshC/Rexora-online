local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function greetCallback(cid)
	local player = isPlayer(cid)
	if getCreatureCondition(cid,CONDITION_POISON) then
		doPlayerSendTextMessage(cid,MESSAGE_STATUS_WARNING, "Venture the path of decay!")
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
		doTeleportThing(cid,{x=33396, y=32836, z=14})
		doSendMagicEffect(getPlayerPosition(cid),CONST_ME_TELEPORT)
		return false
	else
		npcHandler:say("Begone! Hissssss! You bear not the mark of the cobra!", cid)
		return false
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new())