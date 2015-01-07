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
	end
	
	if getPlayerStorageValue(cid,InServiceofYalahar.Questline) < 1 then
		setPlayerStorageValue(cid,InServiceofYalahar.Questline, 3)
	end
	
	if msgcontains(msg, "job") and not getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 54 then
		npcHandler:say("I'm an Augur of the city of Yalahar. My special duty consists of coordinating the efforts to keep the city and its services running.", cid)
	elseif msgcontains(msg, "job") then
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 54 then
			npcHandler:say("Did you bring me the vampiric crest?", cid)
			TopicState[cid] = 6
		end
	elseif msgcontains(msg, "mission") then
		if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 3 then
			npcHandler:say("You probably heard that we have numerous problems in different quarters of our city. Our forces are limited, so we really could need some help from outsiders. ...",cid)
			addEvent(selfSay, 3000,"Would you like to assist us in re-establishing order in our city?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 4 then
			setPlayerStorageValue(cid,InServiceofYalahar.Mission01, 1) -- StorageValue for Questlog "Mission 01: Something Rotten"
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 5)
			npcHandler:say("I hope your first mission will not scare you off. Even though, we cut off our sewer system from other parts of the city to prevent the worst, it still has deteriorated in the last decades. ...",cid)
			addEvent(selfSay, 5000,"Certain parts of the controls are rusty and the drains are stuffed with garbage. Get yourself a crowbar, loosen the controls and clean the pipes from the garbage. ...",cid)
			addEvent(selfSay, 10000,"We were able to locate the 4 worst spots in the sewers. I will mark them for you on your map so you have no trouble finding them. Report to me when you have finished your {mission}. ...", cid)
			doPlayerAddMapMark(cid,{x=32823, y=31161, z=8}, 4, "Sewer Problem 1")
			doPlayerAddMapMark(cid,{x=32795, y=31152, z=8}, 4, "Sewer Problem 2")
			doPlayerAddMapMark(cid,{x=32842, y=31250, z=8}, 4, "Sewer Problem 3")
			doPlayerAddMapMark(cid,{x=32796, y=31192, z=8}, 4, "Sewer Problem 4")
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 5 then
			npcHandler:say("So are you done with your work?", cid)
			TopicState[cid] = 2
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 6 then
			npcHandler:say("We are still present at each quarter's city wall, even though we can do little to stop the chaos from spreading. Still, our garrisons are necessary to maintain some sort of order in the city. ...",cid) 
			addEvent(selfSay, 5000,"My superiors ask for a first hand report about the current situation in the single city quarters. I need someone to travel to our garrisons to get the reports from the guards. Are you willing to do that?",cid) 
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) >= 7 and getPlayerStorageValue(cid,InServiceofYalahar.Questline) <= 14 then
			npcHandler:say("Did you get all the reports my superiors asked for? ", cid)
			TopicState[cid] = 4
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 15 then
			npcHandler:say("I did my best to impress my superiors with your accomplishments and it seems that it worked quite well. They want you for their own missions now. ...",cid)
			addEvent(selfSay, 5000,"Missions that are more important than the ones you've fulfilled for me. However, before you leave, there are still some things I need to tell you. ...",cid)
			addEvent(selfSay, 10000," Listen, I can't explain you everything in detail right now and here. You never know who might be eavesdropping. ...",cid)
			addEvent(selfSay, 150000,"I left some notes in the small room there. Get them and read them. Talk to me again when you've read the notes.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 1) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 16)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,649) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 16 then
			npcHandler:say("Now you know as much as we do about the things happening in Yalahar. It's up to you what you do with this information. ...",cid)
			addEvent(selfSay, 5000,"Now leave and talk to my superior Azerus in the city centre to get your next mission. I urge you, though, to talk to me whenever he sends you on a new mission. ...",cid)
			addEvent(selfSay, 10000," I think it is important that you hear my opinion about them. Now hurry. I suppose Azerus is already waiting.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 2) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 17)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 20 then
			npcHandler:say("This quarter has been sealed off years ago. To send someone there poses a high risk to spread the plague. I assume these research notes you've mentioned must be very important. ...",cid)
			addEvent(selfSay, 5000,"After all those years it is more than strange that someone shows interest in these notes now. Considering what has happened to the alchemists, it is rather unlikely that they contain harmless information. ...",cid)
			addEvent(selfSay, 10000,"I fear these notes will be used to turn the plague into some kind of weapon. Someone with this plague at his disposal could subdue the whole city by blackmailing. ...","I beg you to destroy these notes. Just put them into some burning oven to get rid of them and report that you did not find the notes.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 21)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission03, 5) -- StorageValue for Questlog "Mission 03: Death to the Deathbringer"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 23 then
			npcHandler:say("Mr. West is a little paranoid. That's the reason for his immense private army of bodyguards. He could surely be helpful, especially as he rules over the former trade quarter. ...",cid)
			addEvent(selfSay, 5000,"If you were able to reach him without killing his henchmen, you could probably convince him that you mean no harm to him. ...",cid)
			addEvent(selfSay, 10000,"That would certainly cement our relationship without any needless bloodshed. Perhaps you could use the way through the sewers to avoid his men. ...",cid)
			addEvent(selfSay, 15000,"Mr. West is not a bad man. We should be able to work out some plans to reconstruct the city's safety as soon as he overcomes his paranoia towards us.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 24)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 2) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 25 and getPlayerStorageValue(cid,InServiceofYalahar.MrWestStatus) == 1 then
			npcHandler:say("You did quite well in gaining a new friend who will work together with us. ...",cid)
			addEvent(selfSay, 4000," I'm sure he'll still try to gain some profit but that's still better than his former one-man rule during which he dictated his own laws.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) + 1 or 0)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 26)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission04, 5) -- StorageValue for Questlog "Mission 04: Good to be Kingpin"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 28 then	
			npcHandler:say("Warbeasts? Is this true? People are already starving. ...",cid)
			addEvent(selfSay, 4500,"How can we afford to feed an army of hungry beasts? They will not only strengthen the power of the Yalahari over the citizens, they also mean starvation and deathfor the poor. ...",cid)
			addEvent(selfSay, 9000,"Instead of breeding warbeasts, this druid should breed cattle to feed our people. Please I beg you, convince him to do that!",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 29)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 2) -- StorageValue for Questlog "Mission 05: Food or Fight"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 32 and getPlayerStorageValue(cid,InServiceofYalahar.TamerinStatus) == 1 then
			npcHandler:say("These are great news indeed. The people of Yalahar will be grateful. The Yalahari probably not, so take care of yourself. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) + 1 or 0) -- Side Storage
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 33)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission05, 8) -- StorageValue for Questlog "Mission 05: Food or Fight"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 35 then
			npcHandler:say("What a sick idea to misuse tortured souls to power some device! Though, this charm might be useful to free these poor souls. ...",cid)
			addEvent(selfSay, 4500,"Please capture the souls as you have been instructed and then bring the charm to me. I will see to it that the souls are freed to go to the afterlife in peace.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 36)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 2) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 37 then
			if getPlayerItemCount(cid,9742) >= 1 then
				doPlayerRemoveItem(cid,9742, 1)
				npcHandler:say("I thank you also in the name of these poor lost souls. I will send the charm to a priest who is able to release them. ...", cid)
				addEvent(selfSay, 3500,"Tell the Yalahari that the charm was destroyed by the energy it contained.", cid)
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 38)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission06, 4) -- StorageValue for Questlog "Mission 06: Frightening Fuel"
				setPlayerStorageValue(cid,InServiceofYalahar.QuaraState, 1)
				setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) + 1 or 0) -- Side Storage
				TopicState[cid] = 0
			end
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 40 then
			npcHandler:say("The quara are indeed a threat. Yet, they are numerous and reproduce quickly. Slaying some of them will only enrage them even more. ...",cid)
			addEvent(selfSay, 4500,"The quara have been there for many generations. They have never threatened anyone who stayed out of their watery realm. ...",cid)
			addEvent(selfSay, 9000,"It would be much more useful to find out what the quara are so upset about. Better avoid slaying their leaders as this will only further the animosities.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 41)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission07, 2) -- StorageValue for Questlog "Mission 07: A Fishy Mission"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 42 and getPlayerStorageValue(cid,InServiceofYalahar.QuaraState) == 1 then
			npcHandler:say("Oh no! So that's the reason for the quara attacks! I will do my best to close these sewage pipes. We will have to use other drains. ", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 43)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission07, 5) -- StorageValue for Questlog "Mission 07: A Fishy Mission"
			setPlayerStorageValue(cid,InServiceofYalahar.GoodSide, getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) >= 0 and getPlayerStorageValue(cid,InServiceofYalahar.GoodSide) + 1 or 0) -- Side Storage
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 44 then
			npcHandler:say("The constant unrest in the city is to a great extent caused by the lack of food. Weapons will only serve to suppress the poor. ...",cid)
			addEvent(selfSay, 4500,"The factory you were sent to was once used for the production of food. Somewhere in the factory you might find an old pattern crystal for the production of food. ...",cid)
			addEvent(selfSay, 9000,"If you use it on the controls instead of the weapon pattern, you will ensure that our people are supplied with the desperately needed food. ...", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 45)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission08, 2) -- StorageValue for Questlog "Mission 08: Dangerous Machinations"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 48 then
			npcHandler:say("Listen, I know you have worked for Azerus and his friends, but it is not too late to change your mind! I beg you to rethink your loyalties. ...",cid)
			addEvent(selfSay, 3500,"The fate of the whole city might depend on your decision! Think about your options carefully.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 49)
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 49 or getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 48 then
			npcHandler:say("So do you want to side with me? ", cid)
			TopicState[cid] = 5
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 50 and getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 1 then
			npcHandler:say("I cannot tell you how we acquired this information, but we have heard that a circle of Yalahari is planning some kind of ritual. ...",cid)
			addEvent(selfSay, 5000,"They plan to create a portal for some powerful demons and to unleash them in the city to 'purge' it once and for all. ...",cid)
			addEvent(selfSay, 10000,"I doubt those poor fools will be able to control such entities. I can't figure out how they came up with such an insane idea, but they have to be stopped. ...",cid)
			addEvent(selfSay, 15000,"The entrance to their inner sanctum has been opened for you. Please hurry and stop them before it's too late. Be prepared for a HARD battle! Better gather some friends to assist you.", cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 51)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 2) -- StorageValue for Questlog "Mission 10: The Final Battle"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 52 and getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 1 then
			npcHandler:say("So the Yalahari that opposed us are dead or fled from the city. This should bring us more stability and perhaps a true chance to rebuild the city. ...",cid)
			addEvent(selfSay, 5000,"Still, I wonder from where they gained some of the Yalahari secrets. Did they find some source of knowledge? ...",cid)
			addEvent(selfSay, 10000,"And if so, is this source still around so that we can use it for the benefit of our city? What really troubles me is that none of those false Yalahari had the personality of agreat leader. ...",cid)
			addEvent(selfSay, 15000,"Quite the opposite, they were opportunistic and not exactly bold. Perhaps they were led by some greater power which stayed behind the scenes. ...",cid)
			addEvent(selfSay, 25000,"I'm afraid we have not seen the last chapter of Yalahar's drama. But anyhow, I wish to thank you for putting your life at stake for our cause. ...",cid)
			addEvent(selfSay, 30000,"I allow you to enter the Yalaharian treasure room. I'm sure that you can put what you find inside to better use than them. Choose one chest, but think before takingone! ...",cid)
			addEvent(selfSay, 35000,"Also, take this Yalaharian outfit. Depending on which side you chose previously, you can also acquire one specific addon. Thank you again for your help.",cid)
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 53)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 4) -- StorageValue for Questlog "Mission 10: The Final Battle"
			doSendMagicEffect(getCreaturePosition(cid),CONST_ME_MAGIC_BLUE)
			TopicState[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if TopicState[cid] == 1 then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 4)
			npcHandler:say("I'm pleased to hear that. Rarely we meet outsiders that care about our problems. Most people come here looking for wealth and luxury. ...",cid)
			addEvent(selfSay, 4000,"However, I have to tell you that our ranking system is quite rigid. So, I'm not allowed to entrust you with important missions as long as you haven't proven yourself as reliable. ...",cid)
			addEvent(selfSay, 8000,"If you are willing to work for the city of Yalahar, you can ask me for a {mission} any time, be it night or day.",cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 2 then
			if getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe01) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe02) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe03) == 1 and getPlayerStorageValue(cid,InServiceofYalahar.SewerPipe04) == 1 then
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 6)
				setPlayerStorageValue(cid,InServiceofYalahar.Mission01, 6) -- StorageValue for Questlog "Mission 01: Something Rotten"
				npcHandler:say("Thank you very much. You have no idea how hard it was to find someone volunteering for that job. If you feel ready for further {missions}, just tell me.", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 3 then
			setPlayerStorageValue(cid,InServiceofYalahar.Mission02, 1) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 7)
			npcHandler:say("You'll find our seven guards at the gates of each quarter. Just ask them for their report and they will tell you all you need to know.", cid)
			addEvent(selfSay, 3500,"I must warn you, the quarters are in a horrible state. I strongly advise you to stay on the main roads whenever possible while you get those reports. ...", cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 4 then
			if getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 14 then
				setPlayerStorageValue(cid,InServiceofYalahar.Mission02, 8) -- StorageValue for Questlog "Mission 02: Watching the Watchmen"
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 15)
				npcHandler:say("Excellent! My superiors will be pleased to get these reports. I will for sure emphasise your efforts in this mission. Please come back soon to see if there are any more {missions} available for you. ", cid)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 5 then
			setPlayerStorageValue(cid,InServiceofYalahar.Questline, 50)
			setPlayerStorageValue(cid,InServiceofYalahar.Mission09, 2) -- StorageValue for Questlog "Mission 09: Decision"
			setPlayerStorageValue(cid,InServiceofYalahar.Mission10, 1) -- StorageValue for Questlog "Mission 10: The Final Battle"
			setPlayerStorageValue(cid,InServiceofYalahar.SideDecision, 1)
			npcHandler:say("I knew that you were smart enough to make the right decision! Your next mission will be a special one! ", cid)
			TopicState[cid] = 0
		elseif TopicState[cid] == 6 then
			if getPlayerItemCount(cid,9956) >= 1 and getPlayerStorageValue(cid,InServiceofYalahar.Questline) == 54 then
				setPlayerStorageValue(cid,InServiceofYalahar.Questline, 55)
				npcHandler:say("Great! Here, take this yalaharian addon in a return.", cid)
				if getPlayerSex(cid) == 1 then
				doPlayerAddOutfitAddon(cid,325, getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 1 and 1 or 2)
				elseif getPlayerSex(cid) == 0 then
				doPlayerAddOutfitAddon(cid,324, getPlayerStorageValue(cid,InServiceofYalahar.SideDecision) == 1 and 1 or 2)
				doSendMagicEffect(getCreaturePosition(cid),CONST_ME_MAGIC_BLUE)
				TopicState[cid] = 0
			else
				npcHandler:say("Come back when you do.", cid)
				TopicState[cid] = 0
				end
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Greetings.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")  
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())