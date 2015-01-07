--[[
	!---------------------------------!
	!---Created by Teh Maverick-------!
	!-------www.otland.net------------!
	!---------------------------------!
]]

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talktopic, amount, playerLevel = {}, {}, {}
local str = ""

--Config
local highLevelPrice = 100000 --(Real Tibia Price: 100000) price for players level 120+, per blessing
local lowLevelPrice = 10000 --(Real Tibia Price: 10000) price for players level 30 and lower, per blessing
local pricePerLevel = 50000 --(Real Tibia Price: 10000) this price only applies to players between level 30 & 120, formula=((pricePerLevel*playerLevel)+lowLevelPrice)
--Text
local text = "Do you want to buy all five blessings for " --leave this unfinished (it will add the price to the end)
local thankyou = "You have bought all 5 of my blessings for " --leave this unfinished (it will add the price to the end)
local help = "There are five different blessings available in five sacred places. These blessings are: the {spiritual} shielding, the spark of the {phoenix}, the {embrace} of Tibia, the fire of the {suns} and the wisdom of {solitude}. Additionally, you can receive the {twist of fate} here. I can also provide you with {all} blessings at once."
local already = "You already possess all blessings."
local nomoney = "Oh. You do not have enough money."

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg) 			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink() 					npcHandler:onThink()					end

function greetCallback(cid)
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	talktopic[talkUser], amount[talkUser], playerLevel[talkUser] = 0, 0, 0
    return true
end

function creatureSayCallback(cid, type, msg)

talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid

	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
playerLevel[talkUser] = getPlayerLevel(cid)
amount[talkUser] = 0
	if (getPlayerBlessing(cid,1)
		and getPlayerBlessing(cid,2)
			and getPlayerBlessing(cid,3)
				and getPlayerBlessing(cid,4)
					and getPlayerBlessing(cid,5)) then
				npcHandler:say(already, cid)
				return false
	else
		if playerLevel[talkUser] < 49 then
		  amount[talkUser] = lowLevelPrice*1
		  str = "{"..amount[talkUser].."?"
			elseif playerLevel[talkUser] >= 50 and playerLevel[talkUser] <= 99 then
				amount[talkUser] = pricePerLevel*1
				str = "{"..amount[talkUser].."?"
					elseif playerLevel[talkUser] >= 100 then
						amount[talkUser] = highLevelPrice*1
						str = "{"..amount[talkUser].."}?"
		end
	end
	
	str = text..str
	
		if (msgcontains(msg, "blessings") or msgcontains(msg, "bless")) then
			talktopic[talkUser] = 0
			npcHandler:say(help, cid)
	
		elseif talktopic[talkUser] == 0 and (msgcontains(msg, "yes") or msgcontains(msg, "all") or msgcontains(msg, "blessing")) then
			talktopic[talkUser] = 1
			npcHandler:say(str, cid)
			
		elseif talktopic[talkUser] == 1 and (msgcontains(msg, "yes") or msgcontains(msg, "ok")) then
			talktopic[talkUser] = 2
				if doPlayerRemoveMoney(cid, amount[talkUser]) then
					for i = 1,5 do
					doPlayerAddBlessing(cid,i)
					end
					npcHandler:say(thankyou.."{"..amount[talkUser].."}", cid)
				else
				  npcHandler:say("Oh. You do not have enough money.", cid)
				  return false
				end
		end
	return true
end

keywordHandler:addKeyword({'pilgrimage'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Whenever you receive a lethal wound, your vital force is damaged and there is a chance that you lose some of your equipment. With every single of the five {blessings} you have, this damage and chance of loss will be reduced.'})
keywordHandler:addKeyword({'spiritual'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You can ask for the blessing of spiritual shielding in the whiteflower temple south of Thais.'})
keywordHandler:addKeyword({'phoenix'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The spark of the phoenix is given by the dwarven priests of earth and fire in Kazordoon.'})
keywordHandler:addKeyword({'embrace'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The druids north of Carlin will provide you with the embrace of Tibia.'})
keywordHandler:addKeyword({'suns'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You can ask for the blessing of the two suns in the suntower near Ab\'Dendriel.'})
keywordHandler:addKeyword({'solitude'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Talk to the hermit Eremo on the isle of Cormaya about this blessing.'})

npcHandler:setMessage(MESSAGE_GREET, "Welcome, young |PLAYERNAME|! If you are heavily wounded or poisoned, I can heal you for free.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Remember: If you are heavily wounded or poisoned, I can heal you for free.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the gods bless you, |PLAYERNAME|!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())