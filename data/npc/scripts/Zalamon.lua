local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local TopicState = {}

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local marks = {
	ChildrenOfTheRevolution = {
		{position = Position(33235, 31177, 7), type = 4, description = 'entrance of the camp'},
		{position = Position(33257, 31172, 7), type = 3, description = 'building 1 which you have to spy'},
		{position = Position(33227, 31163, 7), type = 3, description = 'building 2 which you have to spy'},
		{position = Position(33230, 31156, 7), type = 3, description = 'building 3 which you have to spy'}
	},
	WrathOfTheEmperor = {
		{position = Position(33356, 31180, 7), description = 'tunnel to hideout'},
		{position = Position(33173, 31076, 7), description = 'the rebel hideout'}
	},
}

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = isPlayer(cid)
	if msgcontains(msg, "mission") then
		-- CHILDREN OF REVOLUTION QUEST
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) < 1 then
			npcHandler:say("Zzo you are offering your help to a lizzard? Hmm, unuzzual. I don't know if I can fully truzzt you yet. ...",cid)
			addEvent(selfSay, 3000,"You'll have to work to earn my truzzt. Are you zzure you want to offer me your help?", cid)
			TopicState[cid] = 1
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 2 then
			npcHandler:say("What newzz do you bring? Did you find any cluezz about zzeir whereaboutzz? ", cid)
			TopicState[cid] = 3
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 3 then
			npcHandler:say("Zzurely you have zzeen zze black pondzz and puddlezz all over zze mountain pazz, palezzkin. It izz zze corruption zzat pervadezz zze landzz. It would be wizze not to drink or tazzte from zzem. ... ",cid)
			addEvent(selfSay, 3000,	"It zzoakzz zze land, itzz people and even zze air itzzelf. But zzere are zztill zzpotzz not tainted by zze darknezz. ... ",cid)
			addEvent(selfSay, 6000,"A temple, norzzwezzt of zze barricaded outpozzt wizztood zze evil influenzze. However, I lozzt contact to itzz inhabitantzz when zze lizzardzz tightened zzeir grip. ... ",cid)
			addEvent(selfSay, 9000,	"No one made it zzrough zze mountainzz for quite zzome time now - exzzept you. Maybe you can find out what happened zzere? ",cid)
			TopicState[cid] = 5
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 5 then
			npcHandler:say("Zzo you found zze temple... lozzt you zzay. It wazz our lazzt remaining bazztion of hope for help from wizzin zze plainzz. ... ",cid)
			addEvent(selfSay, 3000,	"Zzat meanzz zze plainzz are now in zze handzz of zze emperor and hizz army. I'm afraid zzat even zze great gate izz zzealed and zze landzz beyond it tainted azz well. ... ",cid)
			addEvent(selfSay, 6000,	"Dark timezz, and I fear we know nozzing about our enemy yet. ",cid)
			TopicState[cid] = 0
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 6)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission01, 3) --Questlog, Children of the Revolution "Mission 1: Corruption"
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 6 then
			npcHandler:say("Large partzz of zze empire are tainted. I zzee now zzat zzere izz almozzt nozzing left of our onzze zzo zztrong zzivilizzation. But I zztill don't know which danger our enemy really pozzezz. ... ",cid)
			addEvent(selfSay, 3000,	"Zzere uzzed to be a remote and quiet zzettlement in zze middle of zze valley. If it hazz not been dezztroyed by zze corruption, I'm zzure zze army of zze emperor will have confizzcated it to gazzer rezzourzzezz. ... ",cid)
			addEvent(selfSay, 6000,	"If you can get inzzide zze village, find out anyzzing you can about zzeir zzituation. Zze clever hawk hidezz itzz clawzz. ... ",cid)
			addEvent(selfSay, 9000,	"I'm mozzt interezzted in zzeir weaponzz, food and zze zztrengzz of zzeir forzzezz. ... ",cid)
			addEvent(selfSay, 120000,	"Are you prepared for zzizz mizzion? ",cid)
			TopicState[cid] = 6
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 7 then
			if getPlayerStorageValue(cid,ChildrenoftheRevolution.SpyBuilding01) == 1 and getPlayerStorageValue(cid,ChildrenoftheRevolution.SpyBuilding02) == 1 and getPlayerStorageValue(cid,ChildrenoftheRevolution.SpyBuilding03) == 1 then
				npcHandler:say("Zzizz izz mozzt unfortunate. Zzo many warriorzz? Large amountzz of food? And how many weaponzz did you zzay? I zzee, hmm. ... ",cid)
				addEvent(selfSay, 3000,"Direct confrontation izz futile. We'll have to find ozzer wayzz to approach zze emperor and hizz army. ",cid)
				setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 8)
				setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission02, 5) --Questlog, Children of the Revolution "Mission 2: Imperial Zzecret Weaponzz"
				TopicState[cid] = 0
			end
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 8 then
			npcHandler:say("Your lazzt excurzzion revealed a terrifying truzz. Zze enemy'zz forzzezz are overwhelming, zzeir zztrengzz probably unrivaled. We cannot attack an army of zzizz zzize unlezz - unlezz we zzin out zzeir rankzz a little. ... ",cid)
			addEvent(selfSay, 3000,	"A zzingle individual can be azz zztrong azz an army if he zztrikezz zze army azz a whole. ... ",cid)
			addEvent(selfSay, 6000,	"Are you ready for your nexzzt tazzk? ", cid)
			TopicState[cid] = 7
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 11 then
			npcHandler:say("You accomplished an important tazzk in breaking zze defenzze of zze emperor. Not everyzzing might be lozzt yet. ... ",cid)
			addEvent(selfSay, 3000,"I've got anozzer mizzion for you which will be even more dangerouzz zzan zze lazzt one. Return to me when you're ready. ", cid)
			TopicState[cid] = 0
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 12)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission03, 3) --Questlog, Children of the Revolution "Mission 3: Zee Killing Fieldzz"
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 12 then
			npcHandler:say("Wizz zze enemy'zz forzzezz weakened like zzizz, we will be able to zzneak pazzt zze defenzze and furzzer inzzpect zze norzz. You should travel to zze mountain range furzzer eazzt of zze village. ... ",cid)
			addEvent(selfSay, 3000,"Zze old route to zze gate hazz been taken by darknezz. You'll have to find ozzer wayzz. Are you up to zzizz, palezzkin? ", cid)
			TopicState[cid] = 10
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 17 then
			npcHandler:say("You have zzolved zze riddle? Imprezzive, palezzkin. Zze humming you hear in zze chamber mozzt zzertainly comezz from a magic portal zzomewhere in zze temple. ...",cid)
			addEvent(selfSay, 3000,	"Have you zzearched zze ozzer chamberzz for any magical devizzezz or portalzz?", cid)
			TopicState[cid] = 12
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 18 then
			npcHandler:say("If I'm correct, zze portal in zze chamber beyond zze mechanizzm will lead you to zze great gate. It izz perfectly pozzible, however, zzat you will not be tranzzported directly into zze area. ...",cid)
			addEvent(selfSay, 3000,	"You will razzer be brought to a plazze clozze by your goal. Where exzzactly, I cannot zzay. ...",cid)
			addEvent(selfSay, 6000,	"Take all your courage and walk zze pazz zzrough zze portal. At leazzt TRY it - after all, I didn't make you my pupil for nozzing, Kohei. Are you prepared?", cid)
			TopicState[cid] = 13
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 20 then
			npcHandler:say("Too clozze, far too clozze. I felt a huge impact not long after you left. Zze war machinery of zze emperor muzzt finally have been zztarted. ...",cid)
			addEvent(selfSay, 3000,	"I focuzzed and could only hope zzat I would reach you before everyzzing wazz too late. If I hadn't been able to tranzzport you here, our cauzze would have been lozzt. ...",cid)
			addEvent(selfSay, 6000,	"I'm afraid we cannot continue zzizz fight here today. Zze rezzizztanzze izz zztill fragile. I'm afraid, zzere izz zztill much left to do. We'll have to prepare for war. ...",cid)
			addEvent(selfSay, 9000,	"You've helped uzz a great deal during zzezze dark hourzz, I've got zzomezzing for you my friend. Pleazze, take zzizz zzerpent crezzt azz a zzign of my deep rezzpect. ...",cid)
			addEvent(selfSay, 12000,"Rezzt for now, you will need it - you have earned it.", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 21)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05, 3) --Questlog, Children of the Revolution "Mission 5: Phantom Army"
			doPlayerAddItem(cid,11116, 1)
			doPlayerAddExperience(cid,10000, true)
			TopicState[cid] = 0
		-- CHILDREN OF REVOLUTION QUEST

		-- WRATH OF THE EMPEROR QUEST
		elseif getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 21 and getPlayerStorageValue(cid,WrathoftheEmperor.Questline) < 1 then
			npcHandler:say("Zze attackzz have weakened our enemy zzignificantly. Yet, your quezzt continuezz. Bezzidezz zzome tazzkzz you could take, zze zzreat of zze emperor izz zztill hanging over our headzz like a rain cloud. ... ",cid)
			addEvent(selfSay, 3000,	"Zzo, are you indeed willing to continue zze fight for our cauzze? ", cid)
			TopicState[cid] = 14
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 1 then
			npcHandler:say("Ah you have returned. I azzume you already found zzome itemzz to build a proper dizzguizze? ", cid)
			TopicState[cid] = 16
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 6 then
			npcHandler:say("You ezztablished zze connection to zze hideout, good. But zzizz izz no time to rezzt. Your new tazzk will be quite different. ... ",cid)
			addEvent(selfSay, 3000,	"Zze gardenzz are plagued by a creature. Zze former keeper of zzizz garden became an abomination of madnezz zzat needzz to be zztopped. ... ",cid)
			addEvent(selfSay, 6000,	"He hidezz deep underground and it will be dangerouzz to challenge him in hizz lair but I am willing to rizzk it. ... ",cid)
			addEvent(selfSay, 9000,	"Find him, dezztroy him, bring me hizz - I uhm, mean it izz utterly nezzezzary for you to deliver me a proof of hizz deazz. ... ",cid)
			addEvent(selfSay, 12000,"Now go - what are you waiting for, zzoftzzkin? Ready to finish what needzz to be finished? ", cid)
			TopicState[cid] = 19
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 8 then
			npcHandler:say("Zzo... you finished him. Show me hizz head, will you? ", cid)
			TopicState[cid] = 20
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 9 then
			npcHandler:say("At zze dawn of time, zze children of zze Great Zznake were numerouzz. Zzey daringly colonizzed many partzz of zze world. But all bravery did not help againzzt zze sheer number of enemiezz zzey encountered. ... ", cid)
			addEvent(selfSay, 3000,	"And while zze entitiezz zze unbelieverzz call godzz battled for power out of vanity, zze fazze of zze world changed violently. ... ", cid)
			addEvent(selfSay, 6000,	"Many zzentrezz of our magnifizzent zzivilizzation were dezztroyed and only two realmzz zzat we know of remained intact but lozzt contact to each ozzer. ... ", cid)
			addEvent(selfSay, 9000,	"In vizzionzz, zze Great Zznake revealed to Zalamon zze exzzizztenzze of ozzer lizzard people in a vazzt jungle in a far away land. ...", cid)
			addEvent(selfSay, 12000, "Zzough zze lizardzz of zze land failed zze Great Zznake and lozzt itzz favour, zzey are zztill in pozzezzion of ancient reliczz of immenzze power, onzze imbued by zze Great Zznake himzzelf. ... ", cid)
			addEvent(selfSay, 15000, "I had vizzionzz of an - item. Yezz. It may be uzzeful for uzz - I mean you, ezzpecially you. ... ", cid)
			addEvent(selfSay, 18000, "We need a zzeptre of power zzat can be found in zze underground of an ancient temple. It hazz been overrun by zzavage apezz and you will have to fight zzem and zze ancient guardianzz of zze temple azz well. Get uzz zzat zzeptre wherever it might be. ... ", cid)
			addEvent(selfSay, 21000, "It wazz revealed zzat it hazz been zzplit into 3 partzz for reazzonzz zzat are of no importanzze anymore. Zzizz powerful devizze could help uzz in our battle againzzt zze emperor. ... ", cid)
			addEvent(selfSay, 24000, "A shaft, a cuzzp, and an emerald form a zzeptre of zzuch power zzat zze partzz were hidden and are now guarded by vile creaturezz. ... ", cid)
			addEvent(selfSay, 27000, "Find it. Retrieve it. And bring it back to me. ", cid)
			setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 10)
			setPlayerStorageValue(cid,WrathoftheEmperor.Mission04, 1) --Questlog, Wrath of the Emperor "Mission 04: Sacrament of the Snake"
			TopicState[cid] = 0
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 11 then
			npcHandler:say("You - azzembled zze zzeptre? Hand it out, give it to me, will you? ", cid)
			TopicState[cid] = 21
		elseif getPlayerStorageValue(cid,WrathoftheEmperor.Questline) == 12 then
			npcHandler:say("Now we need to get clozzer to zze emperor himzzelf. A hive of beezz would defend zzeir queen wizz zzeir lives in cazze an enemy gained entranzze. Zzizz makezz a formidable defenzze line, nearly inviolable. ... ", cid)
			addEvent(selfSay, 3000,	"But a zztranger directly in zze midzzt of zze hive will be acczzepted - after all it izz not pozzible to overcome zzuch a formidable defenzze which izz nearly inviolable, or izz it? Ha. ... ", cid)
			addEvent(selfSay, 6000,	"Now zzat you overcame zzeir linezz of defenzze at zze great gate, you only need to find a way to enter zzeir home. ... ", cid)
			addEvent(selfSay, 9000,	"Head zztraight to zze entranzze of zze zzity. If you can convinzze zze guardzz to let you enter zze zzity, you should be able to reach our contact zzere wizz eazze. ... ", cid)
			addEvent(selfSay, 12000, "We have alzzo forged zome paperzz for you and zzent zzem to zze zzity. Your victory in zze arena iz well known in our land. Wizz zze help of zzezze paperzz you will pretend zzat zzome of zze higher officialzz want to talk to you about your battle. ... ", cid)
			addEvent(selfSay, 15000, "Zzizz way you will be able to enter zze zzity of zze dragon emperor and meet our contact zzere in zze imperial offizze. He will give you zze next inzztructionzz. ", cid)
			setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 13)
			setPlayerStorageValue(cid,WrathoftheEmperor.Mission05, 1) --Questlog, Wrath of the Emperor "Mission 05: New in Town"
			TopicState[cid] = 0
		-- WRATH OF THE EMPEROR QUEST
		end

	-- WRATH OF THE EMPEROR QUEST
	elseif msgcontains(msg, "crate") then
		if TopicState[cid] == 17 then
			npcHandler:say("Ah I zzee. You are ready for your mizzion and waiting for me to create and mark zze crate? ", cid)
			TopicState[cid] = 18
		end
	-- WRATH OF THE EMPEROR QUEST

	-- CHILDREN OF REVOLUTION QUEST
	elseif msgcontains(msg, "symbols") then
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols) == 1 then
			npcHandler:say("Mh, zze zzymbolzz of zze chamber you dezzcribe are very common in our culture, palezzkin. You should have come accrozz zzem in many a plazze already. ...",cid)
			addEvent(selfSay, 3000,"Zze zzymbolzz zzeem to be arranged in zzome way you zzay? Were zzere any notizzeable devizzezz? Zzwitchezz or leverzz? ", cid)
			TopicState[cid] = 11
		end
	-- CHILDREN OF REVOLUTION QUEST
	elseif msgcontains(msg, "poison") or msgcontains(msg, "poizzon") then
		if getPlayerStorageValue(cid,ChildrenoftheRevolution.Questline) == 9 then
			npcHandler:say("Zze emperor of zze dragonzz hazz tranzzformed himzzelf into an undead creature to lazzt for all eternity, to cheat deazz. Hizz corruption flowzz to zzozze he bound, and from zzem to zzozze zzey bound, and from zzem into zze land.", cid)
			TopicState[cid] = 0
		end
	-- CHILDREN OF REVOLUTION QUEST
	elseif msgcontains(msg, "yes") then
		-- CHILDREN OF REVOLUTION QUEST
		if TopicState[cid] == 1 then
			npcHandler:say("Zzen indeed, I have a tazzk for you. Lizzten carefully and you might even learn zzomezzing. A wizze being hearzz one zzing and underzztandzz ten. ...",cid)
			addEvent(selfSay, 3000,	"Zze mountainzz to zze norzz are overrun by corrupted lizzardzz. ...",cid)
			addEvent(selfSay, 6000,	"Beyond zzem, you'll find a lush valley, zze Muggy Plainzz. Find out about zzeir planzz, zzeir tacticzz. Zze lizzardzz' art of war izz characterizzed by dizzguizze and zzecrezzy. ...",cid)
			addEvent(selfSay, 9000,	"A traveller told me about a barricaded zzettlement zzey ezztablished. It'zz a weak and in all zzeir arroganzze, poorly guarded outpozzt beyond zze mountainzz. ...",cid)
			addEvent(selfSay, 12000,"If you can find any documentzz about zzeir zztrategiezz, zze rezzizztanzze will be very grateful. ...",cid)
			addEvent(selfSay, 15000,"Are you interezzted, palezzkin?", cid)
			TopicState[cid] = 2
		elseif TopicState[cid] == 2 then
			npcHandler:say("Be warned. Zze mountain pazzezz have been dezzerted for zzeveral weekzz now. No one made it acrozz and I fear you won't meet a zzingle friendly zzoul up zzere.", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 1)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission00, 1) --Questlog, Children of the Revolution "Prove Your Worzz!"
			TopicState[cid] = 0
		elseif TopicState[cid] == 3 then
			npcHandler:say("Exzztraordinary. We are mozzt fortunate to have zzezze documentzz in our handzz now. Zzizz would zzertainly help me to build an effective rezzizztanzze. Will you give zzem to me? ", cid)
			TopicState[cid] = 4
		elseif TopicState[cid] == 4 then
			if getPlayerItemCount(cid,11101) >= 1 then
				npcHandler:say("Aaah, zzezze look zzertainly interezzting. Zzezze manuzzcriptzz show uzz zzeveral locationzz of zze enemy troopzz. ... ",cid)
				addEvent(selfSay, 3000,"I'm imprezzed, zzoftzzkin. Maybe you can be of zzome more help. ", cid)
				doPlayerRemoveItem(cid,11101, 1)
				setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 3)
				setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission00, 2) --Questlog, Children of the Revolution "Prove Your Worzz!"
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 5 then
			npcHandler:say("I've marked itzz location on your map. Go and find out what happened zzere. In zze pazzt it wazz known azz zze Temple of Equilibrium. ", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 4)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission01, 1) --Questlog, Children of the Revolution "Mission 1: Corruption"
			doPlayerAddMapMark(cid,Position(33177, 31193, 7), 5, "Temple of Equilibrium")
			TopicState[cid] = 0
		elseif TopicState[cid] == 6 then
			npcHandler:say("I'll mark zze entranzze to Chaochai on your map. ... ",cid)
			addEvent(selfSay, 3000,"Conzzentrate on one location at a time. Zze one who chazzezz after two harezz, won't catch even one. ", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 7)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission02, 1) --Questlog, Children of the Revolution "Mission 2: Imperial Zzecret Weaponzz"
			for i = 1, #marks.ChildrenOfTheRevolution do
				local mark = marks.ChildrenOfTheRevolution[i]
				doPlayerAddMapMark(cid,mark.position, mark.type, mark.description)
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 7 then
			npcHandler:say("Not far to zze eazzt of zze village, you'll find rizze fieldzz. Zzey uzze zzem to rezztore zzeir food suppliezz. ... ",cid)
			addEvent(selfSay, 3000,"In zze zztorage accrozz zzizz room, you'll find a zzpecial poizzon which will zzignificantly weaken zzem if uzzed on zze water and zzoil zze rizze growzz in. ... ",cid)
			addEvent(selfSay, 6000,"Are you fully prepared for zzizz?", cid)
			TopicState[cid] = 8
		elseif TopicState[cid] == 8 then
			npcHandler:say("Good. Zze fieldzz should be not far from Xiachai in zze eazzt. Go to zze top terrazze and mix zze poizzon wizz zze water. ... ",cid)
			addEvent(selfSay, 3000,"{Poizzon} izz often uzzed by cowardzz, yet it grantzz great power to zze opprezzed. ", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 9)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission03, 1) --Questlog, Children of the Revolution "Mission 3: Zee Killing Fieldzz"
			TopicState[cid] = 0
		elseif TopicState[cid] == 10 then
			npcHandler:say("Perhapzz you can find a way to enter zze norzz of zze valley and find a pazzage to zze great gate itzzelf. Zzearch any templezz or zzettlementzz you come accrozz for hidden pazzagezz. ... ",cid)
			addEvent(selfSay, 3000,"I wish for a zzafe return wizz good newzz. ", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 13)
			if getPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04) <= 1 then
				setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04, 1) --Questlog, Children of the Revolution "Mission 4: Zze Way of Zztonezz"
			end
			TopicState[cid] = 0
		elseif TopicState[cid] == 11 then
			npcHandler:say("Interezzting. It'zz a riddle, zzoftzzkin. Zzuch gamezz are very popular in our culture. I believe zze leverzz will alter zze arrangement. ... ",cid)
			addEvent(selfSay, 3000,	"Not too far from zze lever, zzere muzzt be a hint of zzome zzort. An image of how zze zzymbolzz muzzt be arranged. Zzurely zze mechanizzm will trigger a zzecret pazzage, maybe a moving wall or a portal. ... ",cid)
			addEvent(selfSay, 6000,	"Zzizz should be our pazz to zze great gate. Head to zze zztorage onzze again. Zzere should be zzome extra greazzy oil which should work wizz zzuch a large mechanizzm. Zze leverzz should zzen be movable again. ", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.StrangeSymbols, 2)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04, 3) --Questlog, Children of the Revolution "Mission 4: Zze Way of Zztonezz"
			TopicState[cid] = 0
		elseif TopicState[cid] == 12 then
			npcHandler:say("Zzen zzizz izz zze way which will lead you to zze great gate. ...",cid)
			addEvent(selfSay, 3000,	"By zze way, before I forget it - zzinzze you are zzkilled in zzolving riddlezz, maybe you can make uzze of zzizz old tome I've found? It containzz ancient knowledge and truly izz a tezztament of our culture, treat it wizz care. ...",cid)
			addEvent(selfSay, 6000,	"I may alzzo have anozzer mizzion for you if you are interezzted.", cid)
			doPlayerAddItem(cid,11134, 1)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 18)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission04, 6) --Questlog, Children of the Revolution "Mission 4: Zze Way of Zztonezz"
			TopicState[cid] = 0
		elseif TopicState[cid] == 13 then
			npcHandler:say("You did well on your quezzt zzo far. I hope you will reach zze great gate in time. If we are lucky, it will zztill be open. ... Zalamon: If not, it will already be overrun by enemy zzoldierzz. Direct confrontation will be inevitable in zzat cazze, palezzkin. Now clear your mind and approach zze portal.", cid)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Questline, 19)
			setPlayerStorageValue(cid,ChildrenoftheRevolution.Mission05, 1) --Questlog, Children of the Revolution "Mission 5: Phantom Army"
			TopicState[cid] = 0
		-- CHILDREN OF REVOLUTION QUEST

		-- WRATH OF THE EMPEROR QUEST
		elseif TopicState[cid] == 14 then
			npcHandler:say("You continue to imprezz, zzoftzzkin. ... ",cid)
			addEvent(selfSay, 3000,	"A contact of zze rezzizztanzze izz located furzzer in zze norzz of Zao. ... ",cid)
			addEvent(selfSay, 6000,	"Zze emperor will drag hizz forzzezz to zze great gate now to bolzzter hizz defenzze. Zzinzze we attacked zze gate directly, he will not expect uzz taking a completely different route to reach zze norzzern territoriezz. ... ",cid)
			addEvent(selfSay, 7000,	"I azzume you are already geared up and ready to conquer zze norzz? ", cid)
			TopicState[cid] = 15
		elseif TopicState[cid] == 15 then
			npcHandler:say("Your determination izz highly appreciated. To zzneak pazzt zze eyezz of zze enemy, you will have to uzze a diverzzion. Zzere are zzeveral old tunnelzz beneazz zze zzoil of Zzao. ... ",cid)
			addEvent(selfSay, 3000,	"One of zzem izz uzzed azz a maintenanzze connection by enemy lizardzz. To enter it, you will have to uzze a dizzguizze. Zzomezzing like a crate perhapzz. ... ",cid)
			addEvent(selfSay, 3000,	"Mh, if you can find zzome nailzz - 3 should be enough - and 1 piezze of wood, I should be able to create an appropriate cazzing. Return to me if you found zze itemzz and we will talk about zze next zztep. ", cid)
			setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 1)
			setPlayerStorageValue(cid,WrathoftheEmperor.Mission01, 1) --Questlog, Wrath of the Emperor "Mission 01: Catering the Lions Den"
			TopicState[cid] = 0
		elseif TopicState[cid] == 16 then
			npcHandler:say("Very good, I am confident zzizz will zzuffizze. Now I can build and mark a {crate} large enough for you to fit in - while zztill being able to breazze of courzze - and I will mark it in our tongue zzo it will look lezz zzuzzpizziouzz. ... ",cid)
			addEvent(selfSay, 3000,	"Wizz zzeir eyezz towardzz zze gate, your chanzzezz to zzlip zzrough have never been better. I will keep zze zzpare materialzz here wizz me, we can alwayzz build a new one if you need to. ", cid)
			TopicState[cid] = 17
		elseif TopicState[cid] == 18 then
			if getPlayerItemCount(cid,8309) >= 3 and getPlayerItemCount(cid,5901) >= 1 then
				doPlayerRemoveItem(cid,5901, 1)
				doPlayerRemoveItem(cid,8309, 3)
				setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 2)
				setPlayerStorageValue(cid,WrathoftheEmperor.Mission01, 2) --Questlog, Wrath of the Emperor "Mission 01: Catering the Lions Den"
				doPlayerAddItem(cid,12284, 1)
				npcHandler:say("Alright. Let uzz create a crate. Hm. Let me zzee. ... ",cid)
				addEvent(selfSay, 3000,"Good. Zzat will do. ... ",cid)
				addEvent(selfSay, 6000,	"Zze maintenanzze tunnelzz are in zze eazzt of zze plainzz, near ze coazt. Here, I will mark zzem on your map. ... ",cid)
				addEvent(selfSay, 9000,	"Uzze zze dizzguizze wizzely, try to hide in zze dark and avoid being zzeen at all cozzt. ... ",cid)
				addEvent(selfSay, 12000, "Onzze you have reached zze norzz, you can find zze rezzizztanzze hideout at zze ozzer zzpot I marked on your map. Now hurry. ", cid)
				for i = 1, #marks.WrathOfTheEmperor do
					local mark = marks.WrathOfTheEmperor[i]
					doPlayerAddMapMark(cid,mark.position, 19, mark.description)
				end
				TopicState[cid] = 0
			end
		elseif TopicState[cid] == 19 then
			npcHandler:say("Fine. I guezz poizzoning zzome of hizz plantzz will be enough to lure him out of hizz conzzealment. Zzizz plant poizzon here should allow you to do zzome zzignificant damage, take it. ... ",cid)
			addEvent(selfSay, 3000,	"You can find him eazzt of zze corrupted gardenzz. Zzere uzzed to be a zzmall domizzile zzere but it hazz probably been conzzumed by zze corruption zzo beware. And now - go. ", cid)
			setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 7)
			setPlayerStorageValue(cid,WrathoftheEmperor.Mission03, 1) --Questlog, Wrath of the Emperor "Mission 03: The Keeper"
			doPlayerAddItem(cid,12320, 1)
			TopicState[cid] = 0
		elseif TopicState[cid] == 20 then
			if getPlayerItemCount(cid,12323) >= 1 then
				doPlayerRemoveItem(cid,12323, 1)
				npcHandler:say("Zzizz izz not hizz head but clearly belonged to zze keeper. I - I am imprezzed. You can go now. Leave me alone for a zzecond. ", cid)
				setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 9)
				setPlayerStorageValue(cid,WrathoftheEmperor.Mission03, 3) --Questlog, Wrath of the Emperor "Mission 03: The Keeper"
				TopicState[cid] = 0
			end

		elseif TopicState[cid] == 21 then
			if getPlayerItemCount(cid,12327) >= 1 then
				doPlayerRemoveItem(cid,12327, 1)
				setPlayerStorageValue(cid,WrathoftheEmperor.Questline, 12)
				setPlayerStorageValue(cid,WrathoftheEmperor.Mission04, 3) --Questlog, Wrath of the Emperor "Mission 04: Sacrament of the Snake"
				npcHandler:say("Finally. At lazzt. Zze zzeptre izz - ourzz. Ourzz of courzze. A weapon we should uzze wizzely for our cauzze. I need a zzecond or two. Do you leave me already? ", cid)
				TopicState[cid] = 0
			end
		-- WRATH OF THE EMPEROR QUEST
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())