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
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 17 then
			npcHandler:say("With all the coming and going of strangers here, it would be quite tedious to explain everything again and again. So we have written a manifesto. ...",cid)
			addEvent(selfSay, 3500,"Grab a copy from the room behind me. Let's talk about your further career in our ranks once you've read it.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 18)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 3) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,650) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 18 then
			npcHandler:say("I'm mildly impressed by your previous deeds in our service. So I'm willing to grant you some more important {missions}. ...",cid)
			addEvent(selfSay, 3500,"If you please us, a life of luxury as an important person in our city is ensured. If you fail, you will be replaced by someone more capable than you. ...",cid)
			addEvent(selfSay, 7000,"So if you are up for a challenge, ask me for a {mission}.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 19)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 19 then
			npcHandler:say("The former alchemist quarter was struck by even more disasters than the rest of the city. Fires, explosions, poisonous fumes - all sorts of catastrophes. ...",cid)
			addEvent(selfSay, 5000,"The worst plague, however, are unknown diseases that have spread in this quarter and eradicated any human population. We must stop it before other quarters areafflicted. We already identified certain carriers responsible for spreading the plague. ...",cid)
			addEvent(selfSay, 10000,"It will be your task to eliminate them. This spell will protect you from becoming infected yourself. Enter the alchemist quarter and kill the three plague carriers, and atbest anything else you might find there. ...",cid)
			addEvent(selfSay, 15000,"Even more important, retrieve the last research notes that the local alchemists made before the plague killed them. They might be the key for a cure or something else. ...","At least we have to make sure that these scientists did not die in vain, and honour their researches. So please bring us these research notes. ...",cid)
			addEvent(selfSay, 20000,"Also, I will inform the guards that you are allowed to pass the centre gate to the alchemist quarter. Just use the gate mechanism to pass.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 20)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 4) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 21 and getPlayerStorageValue(cid,InServiceofYalahar.AlchemistFormula) == 1 then
			npcHandler:say("So you have killed the plague carriers. Have you also retrieved the research papers? ", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 22 then
			npcHandler:say("We surely cannot allow some underworld kingpin to rule a significant part of the city. Although, I have to admit that his firm grip on the former trade quarter might be useful....",cid)
			addEvent(selfSay, 5000,"I expect you to fight your way through his minions and to show him that we are determined and powerful enough to retake the quarter, if necessary by force. Talk to himafter killing some of his henchmen. ...",cid)
			addEvent(selfSay, 10000,"I'm sure he'll understand that he will succumb to a greater power. That's how his little empire has worked after all. ...",cid)
			addEvent(selfSay, 15000,"Also, I will inform the guards that you are allowed to pass the centre gate to the trade quarter now. Just use the gate mechanism to pass.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 23)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 1) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 26 then
			npcHandler:say("So he has been too uncooperative for you? Well, you weren't the first we have sent and you won't be the last. ...",cid)
			addEvent(selfSay, 3500,"However, if you cannot even serve us as a bully, we might have to rethink if you are the right person for us. That was a bad job and we don't tolerate many of them.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 27)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 6) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 25 and getPlayerStorageValue(cid,InServiceofYalahar.MrWestStatus) == 2 then
			npcHandler:say("I hope you gave this criminal a real scare! I'm sure he'll remember what he has to expect if he arouses our anger again. ...",cid)
			addEvent(selfSay, 4000,"You have proven yourself as quite valuable with this mission! That was just the first step on your rise through the ranks of our helpers. ...",cid)
			addEvent(selfSay, 8000,"Just ask me for more missions and we will see what you are capable of!", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.BadSide, getPlayerStorageValue(cid,InServiceofYalahar.BadSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.BadSide) + 1 or 0) -- Side Storage
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 27)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 6) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 27 then
			npcHandler:say("As you probably noticed, once our city had a park and a zoo around a grand arena. It was a favourite pastime of our citizens to visit this quarter in their spare time. ...",cid)
			addEvent(selfSay, 5000,"Nowadays, the quarter is lost. The animals are on the loose, and an attempt to revitalise the city with new arena games resulted in a revolt of the foreign gladiators. ...",cid)
			addEvent(selfSay, 10000,"Now all kinds of beasts roam the park, and gladiators challenge them and visitors to test their skills. One of the residents is an ancient druid that rather cares foranimals than for people. ...",cid)
			addEvent(selfSay, 15000,"It is said that he is able to use magic to breed animals with changed abilities and appearances. Such skills are of course quite useful for us. ...",cid)
			addEvent(selfSay, 20000,"We lack the manpower to retake all quarters, or just to defend ourselves adequately. If he bred us some guards and warbeasts, we could strengthen our positionconsiderably. ...", cid)
			addEvent(selfSay, 25000,"Travel to the arena quarter and gain his assistance for us. I will inform the guards that you are allowed to pass the centre gate to the arena quarter now. Just use thegate mechanism to pass.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 28)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 1) -- StorageValue for Questlog "Mission 05: Food or Fight"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 33 then
			npcHandler:say("This druid dares to affront us? We will look into this when we have enough time. But there are other things that needs to be settled. ...",cid)
			addEvent(selfSay, 3000,"Although, we probably should not do so after your last failure, we are willing to grant you another mission.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 34)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 32 and getPlayerStorageValue(cid,InServiceofYalahar.TamerinStatus) == 2 then
			npcHandler:say("So have you won us a new ally? Excellent. I knew you would not dare to ruin this mission. Soon we might be able to strengthen our defences and even relocate some of our guards. ...",cid)
			addEvent(selfSay, 3500,"Perhaps some day soon, you lead your own unit of men. However, there are more missions that need to be accomplished. Let's talk about them.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.BadSide, getPlayerStorageValue(cid,InServiceofYalahar.BadSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.BadSide) + 1 or 0) -- Side Storage
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 34)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 8) -- StorageValue for Questlog "Mission 05: Food or Fight"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 34 then
			npcHandler:say("The old cemetery of the city has been abandoned decades ago when the activity of the various undead there became unbearable. The reason for their appearance was never found out or researched. ...",cid)
			addEvent(selfSay, 5000,	"However, those undead could be useful, at least some of them. Particular ghosts consist of a substance that is very similar to the energy source that powered some of our devices. ...",cid)
			addEvent(selfSay, 10000,"Since we lack most of the original sources, some substitute might come in handy. Take this ghost charm and place it on the strange carving in the cemetery. ...",cid)
			addEvent(selfSay, 15000,"Use it to attract ghosts and slay them. Then use the residues of the ghosts on the charm to capture the essence. ...",cid)
			addEvent(selfSay, 20000,"Once it is filled, ghosts will not be attracted any longer. Then return the charm to me. I will inform the guards that you are allowed to pass the centre gate to the cemetery quarter now. Just use the gate mechanism to pass.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 35)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 1) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
			doPlayerAddItem(cid,9737, 1)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 38 then
			npcHandler:say("Destroyed you say? That's impossible! I'm not sure if I can trust you in this matter? One might assume, you fled from the ghosts in terror and left the charm there. ...",cid)
			addEvent(selfSay, 3500,"You will have to work twice as hard on your next missions to restore the trust you have lost.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 39)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 5) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 37 then
			if getPlayerItemCount(cid,9742) >= 1 then
				doPlayerRemoveItem(cid, 9742, 1)
				npcHandler:say("Ah, what an unexpected sight. I can almost feel the energy of the charm. It will help to recover some of the past wealth. ...",cid)
				addEvent(selfSay, 3500,"You did quite an impressive job. I'm considering to introduce you to my ma.. to my direct superior one day. But there are still other missions to fulfil.",cid)
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 39)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 5) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
				setPlayerStorageValue(cid,InServiceofYalahar.QuaraState, 2)
				setPlayerStorageValue(cid,InServiceofYalahar.BadSide, getPlayerStorageValue(cid,InServiceofYalahar.BadSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.BadSide) + 1 or 0) -- Side Storage
				TopicState[cid] = 0
			end
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 39 then
			npcHandler:say("Recently, our fishermen have been attacked by a maritime race called the quara. They live in the sunken quarter and are a significant threat to our people. I ask you to enter the sunken quarter and slay all their leaders. ...",cid)
			addEvent(selfSay, 3500,"We believe that there are three leaders in this area. Your task is simple enough, so you better don't fail! ...",cid)
			addEvent(selfSay, 7000,"I will inform the guards that you are allowed to pass the centre gate to the sunken quarter now. Just use the gate mechanism to pass.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 40)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission07, 1) -- StorageValue for Questlog "Mission 07: A Fishy Mission"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 41 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraInky) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraSharptooth) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraSplasher) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraState) == 2 then
			npcHandler:say("This will teach these fishmen who is the ruler of that area. You have earned yourself a special privilege. But we will talk about that when we speak about your next mission. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 43)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission07, 5) -- StorageValue for Questlog "Mission 07: A Fishy Mission"
			setPlayerStorageValue(cid,InServiceofYalahar.BadSide, getPlayerStorageValue(cid,InServiceofYalahar.BadSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.BadSide) + 1 or 0) -- Side Storage
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 43 then
			npcHandler:say("In the past, we had many magical factories providing the citizens with everything they needed. Now that most of these factories are shut down, we have trouble getting enough supplies. ...",cid)
			addEvent(selfSay, 4500,"We need you to enter one of the lesser damaged factories. Go to the factory district and look for a pattern crystal used for weapon production. Use it on the factory controller. ...",cid)
			addEvent(selfSay, 9000,"It will ensure that the factory will provide us with a suitable amount of weapons which we dearly need to reclaim and secure the most dangerous parts of the city. ...",cid)
			addEvent(selfSay, 13500,"I will inform the guards that you are allowed to pass the centre gate to the factory quarter now. Just use the gate mechanism to pass.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 44)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission08, 1) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 46 then
			if getPlayerStorageValue(cid,InServiceofYalahar.MatrixState) == 1 then
				npcHandler:say("Your failure is an outrage! I think we have to talk about the missions you have accomplished so far. ", cid)
				setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) + 1 or 0) -- Side Storage
			elseif getPlayerStorageValue(cid,InServiceofYalahar.MatrixState) == 2 then
				npcHandler:say("Now we will have power we truly deserve!...", cid)
				setPlayerStorageValue(cid,InServiceofYalahar.BadSide, getPlayerStorageValue(cid,InServiceofYalahar.BadSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.BadSide) + 1 or 0) -- Side Storage
			end
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 47)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission08, 4) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 47 then
			npcHandler:say("I'm impressed by your support for our cause. Still, I'm aware that this scheming Palimuth tried to influence you. Think about who are your real friends and who can assist you in your career. ...",cid)
			addEvent(selfSay, 3500,"Come back if you have decided to which side you want to belong.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 48)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission09, 1) -- StorageValue for Questlog "Mission 09: Decision"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 49 or getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 48 then
			npcHandler:say("So do you want to side with me " .. getCreatureName(cid) .. "? ", cid)
			TopicState[cid] = 2
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 50 and getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 2 then
			npcHandler:say("For your noble deeds, we would like to invite you to a special celebration ceremony. ...",cid)
			addEvent(selfSay, 4500,"Only the most prominent Yalahari are allowed to join the festivities. I assume you can imagine what honour it is that you'vebeen invited to join us. Meet us in the inner city's centre. ...",cid)
			addEvent(selfSay, 9000,	"As our most trusted ally, you may pass all doors to reach the festivity hall. There you will receive your reward for the achievements you have gained so far. ...",cid)
			addEvent(selfSay, 13500,"I'm convinced your reward will be beyond your wildest dreams. And that is just the beginning!",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 51)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 1) -- StorageValue for Questlog "Mission 10: The Final Battle"
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 2) -- StorageValue for Questlog "Mission 10: The Final Battle"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 52 and getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 2 then
			npcHandler:say("Great work, take this outfit and you are able to open the door to the reward room.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 53)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 4) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doPlayerAddOutfit(cid,324, 0)
			doPlayerAddOutfit(cid,325, 0)
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_MAGIC_BLUE)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			if getPlayerItemCount(cid,9733) >= 1 then
				doPlayerRemoveItem(cid, 9733, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.BadSide, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 22)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 6) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
				npcHandler:say("Impressive indeed! Someone with your skills will quickly raise in our ranks of helpers. You have great potential, and if you are upfor further missions, just ask for them. ", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 2 then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 50)
			setPlayerStorageValue(cid,InServiceofYalahar.SideDecision, 2)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission09, 2) -- StorageValue for Questlog "Mission 09: Decision"
			npcHandler:say("I knew that you were smart enough to make the right decision! Your next mission will be a special one! ", cid)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "no") then
		if TopicState[cid] == 1 then
			setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, 1)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 22)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 6) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			npcHandler:say("Hm, no sign of any notes you say? That's odd - odd and a bit suspicious. I doubt you have tried hard enough. ...",cid)
			addEvent(selfSay, 3000,"There are only a few chances to impress us. For those who please us great rewards are in store. If you fail though, you might lose more than you can imagine.",cid)
			TopicState[cid] = 0
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())