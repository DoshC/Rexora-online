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
local pricePerLevel = 0 --(Real Tibia Price: 50000) this price only applies to players between level 30 & 120, formula=((pricePerLevel*playerLevel)+lowLevelPrice)
--Text
local text = "Do you want to buy all five blessings for " --leave this unfinished (it will add the price to the end)
local thankyou = "You have bought all 5 of my blessings for " --leave this unfinished (it will add the price to the end)
local help = "I can give all of you my {blessings} for free. Blessings will protect you from losing items on death and reduce the amount of levels you lose when you die."
local already = "You already have my blessings."
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
		if playerLevel[talkUser] < 30 then
		  amount[talkUser] = lowLevelPrice*1
		  str = "{"..amount[talkUser].."}gp?"
			elseif playerLevel[talkUser] > 50 and playerLevel[talkUser] < 99 then
				amount[talkUser] = (((playerLevel[talkUser]-30)*pricePerLevel)+lowLevelPrice)*5
				str = "{"..amount[talkUser].."}gp?"
					elseif playerLevel[talkUser] >= 100 then
						amount[talkUser] = highLevelPrice*1
						str = "{"..amount[talkUser].."}gp?"
		end
	end
	
	str = text..str
	
		if (msgcontains(msg, "help") or msgcontains(msg, "job")) then
			talktopic[talkUser] = 0
			npcHandler:say(help, cid)
	
		elseif talktopic[talkUser] == 0 and (msgcontains(msg, "yes") or msgcontains(msg, "blessings") or msgcontains(msg, "bless")) then
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

npcHandler:setMessage(MESSAGE_GREET, "Welcome, young |PLAYERNAME|! If you are heavily wounded or poisoned, I can heal you for free.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Remember: If you are heavily wounded or poisoned, I can heal you for free.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May the gods bless you, |PLAYERNAME|!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())