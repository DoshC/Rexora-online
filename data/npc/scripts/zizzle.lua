local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid)
	npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
	npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
	npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
	npcHandler:onThink()
end
function creatureSayCallback(cid, type, msg)
	if(not(npcHandler:isFocused(cid))) then
		return false
	end
	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(msgcontains(msg, "mission") and getPlayerStorageValue(cid, STORAGE_ZLAK) == 4) then
		if(getPlayerStorageValue(cid, STORAGE_ZIZZLE) < 1 and getPlayerPosition(cid).z == 12) then
			npcHandler:say("You made it! Az zoon az you are prepared, I will brief you for your nexzt mizzion. ", cid)
			setPlayerStorageValue(cid, STORAGE_ZIZZLE, 1)
		elseif(getPlayerStorageValue(cid, STORAGE_ZIZZLE) == 1 and getPlayerPosition(cid).z == 15) then
			npcHandler:say("Ze dragon emperor controlz ze whole empire wiz hiz willpower. But even he iz not powerful enough to uze ziz control continuouzly wizout zome form of aid. ...", cid)
			npcHandler:say("From what I learnt from my informantz, ze emperor uzez zome kind of magic cryztalz zat amplify hiz powerz and tranzmit hiz will into ze land. ...", cid, true)
			npcHandler:say("Wiz ze ancient zeptre zat you acquired for uz earlier, I can charge ozer zeptrez wiz azpectz of power of ze Great Znake. If you manage to touch one of ze tranzmitter cryztalz wiz ze zeptre, itz godly power will realign ze cryztal. ...", cid, true)
			npcHandler:say("Not only will ze cryztal ztop zending ze orderz of ze emperor into ze mindz of my opprezzed people, it will alzo zend a mezzage of freedom and zelf-rezpect inztead. ...", cid, true)
			npcHandler:say("Dizabling ze cryztalz will probably alert ze emperor. It will likely be too late for him to intervene in perzon but a creature of hiz power might have ozer wayz to intervene. ...", cid, true)
			npcHandler:say("But zere iz more. To reach ze emperor, you will need accezz to hiz inner realmz. Ze zecret to enter iz guarded by a dragon. ...", cid, true)
			npcHandler:say("But ziz iz not ze catch - ze catch iz, zat ze key iz buried in hiz vazt mind. Ze emperor haz bound ze dragon to himzelf, forzing him into an eternal zlumber. ...", cid, true)
			npcHandler:say("A zignificant part of ze emperor'z power iz uzed to reztrain ze dragon. Ze only way to free him will be to enter hiz dreamz. Are you prepared for ziz?", cid, true)
			talkState[talkUser] = 1
		elseif(getPlayerStorageValue(cid, STORAGE_DRAGON) == 2 and getPlayerStorageValue(cid, STORAGE_LAST) < 1) then
			npcHandler:say("You freed ze dragon! And you pozzezz ze key to enter ze inner realmz of ze emperor, well done. ...", cid)
			npcHandler:say("Now you are ready to reach ze inner zanctum of ze emperor. Zalamon'z revelationz showed him zat zere are four cryztalz channelling ze will of ze emperor into ze land. ...", cid, true)
			npcHandler:say("Wiz ze relic you gained from Zalamon we were able to create powerful replicaz of ze zeptre. Take ziz wiz you. ...", cid, true)
			npcHandler:say("You will have to realign ze cryztalz one after ze ozer. Ztart wiz ze one in ze norz-wezt and work your way clockwize zrough ze room. ...", cid, true)
			npcHandler:say("Uzing ze zeptre will forze a part of ze emperor'z willpower out of ze cryztal. You will have to kill zoze manifeztationz. ...", cid, true)
			npcHandler:say("Zen uze your zeptre on ze remainz to deztroy ze emperor'z influenze over ze cryztal. ...", cid, true)
			npcHandler:say("I recommend not to go alone becauze it will be very dangerouz - but ALL of you will have to uze zeir zeptre replicaz on ze emperor'z remainz to prozeed! ...", cid, true)
			npcHandler:say("Good luck. You will need it. ", cid)
			setPlayerStorageValue(cid, STORAGE_LAST, 1)
			doPlayerAddItem(cid, 12318, 1)
		end
	elseif(msgcontains(msg, "yes")) then
		if(talkState[talkUser] == 1) then
			npcHandler:say("Didn't exzpect anyzing lezz from you. Alright, zankz to your effortz to build an effective reziztanze, our comradez zalvaged ziz potion and ze formula you need to utter to breach hiz zubconzciouznezz. ...", cid)
			npcHandler:say("Drink it and when you are cloze to ze dragon zpeak: Z...z.. well, juzt take ze sheet wiz ze word and read it yourzelf. A lot of rebelz have died to retrieve ziz information, uze it wizely. ...", cid, true)
			npcHandler:say("Now go and try to find a way to reach ze emperor and to free ze land from it'z opprezzor. Onze you have found a way, return to me and I will explain what to do wiz ze cryztalz. May ze Great Znake guide you! ", cid, true)
			setPlayerStorageValue(cid, STORAGE_ZIZZLE, 2)
			talkState[talkUser] = 0
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
