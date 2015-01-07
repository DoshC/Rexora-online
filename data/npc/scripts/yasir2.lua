local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) 			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) 		end
function onCreatureSay(cid, type, msg) 		npcHandler:onCreatureSay(cid, type, msg) 	end
function onThink() 							npcHandler:onThink() 						end
function onPlayerEndTrade(cid)				npcHandler:onPlayerEndTrade(cid)			end
function onPlayerCloseChannel(cid)			npcHandler:onPlayerCloseChannel(cid)		end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)


shopModule:addSellableItem({'acorn'}, 11213, 10, 'acorn') 
shopModule:addSellableItem({'ancient Stone'}, 10549, 200, 'ancient stone') 
shopModule:addSellableItem({'antlers'}, 11214, 50, 'antlers') 
shopModule:addSellableItem({'ape fur'}, 5883, 120, 'ape fur') 
shopModule:addSellableItem({'badger fur'}, 11216, 15, 'badger fur') 
shopModule:addSellableItem({'bat wing'}, 5894, 50, 'bat wing') 
shopModule:addSellableItem({'bamboo stick'}, 12401, 30, 'bamboo stick')
shopModule:addSellableItem({'banana sash'}, 12467, 55, 'banana sash') 
shopModule:addSellableItem({'battle stone'}, 12403, 290, 'battle stone') 
shopModule:addSellableItem({'bear paw'}, 5896, 100, 'bear paw')
shopModule:addSellableItem({'behemoth claw'}, 5930, 2000, 'behemoth claw')
shopModule:addSellableItem({'beholder eye'}, 5898, 80, 'beholder eye')
shopModule:addSellableItem({'black hood'}, 10562, 190, 'black hood')
shopModule:addSellableItem({'black wool'}, 12404, 300, 'black wool')
shopModule:addSellableItem({'blood preservation'}, 12405, 320, 'blood preservation')
shopModule:addSellableItem({'bloody pincers'}, 10550, 100, 'bloody pincers')
shopModule:addSellableItem({'boggy dreads'}, 10584, 200, 'boggy dreads')
shopModule:addSellableItem({'bone shoulderplate'}, 11321, 150, 'bone shoulderplate')
shopModule:addSellableItem({'bony tail'}, 11194, 210, 'bony tail')
shopModule:addSellableItem({'book of necromantic rituals'}, 11237, 180, 'book of necromantic rituals')
shopModule:addSellableItem({'book of prayers'}, 10563, 120, 'book of prayers')
shopModule:addSellableItem({'brimstone fangs'}, 12619, 350, 'brimstone fangs')
shopModule:addSellableItem({'brimstone shell'}, 12658, 210, 'brimstone shell')
shopModule:addSellableItem({'broken crossbow'}, 12407, 30, 'broken crossbow')
shopModule:addSellableItem({'broken draken mail'}, 12616, 350, 'broken draken mail')
shopModule:addSellableItem({'broken gladiator shield'}, 10573, 180, 'broken gladiator shield')
shopModule:addSellableItem({'broken halberd'}, 11335, 100, 'broken halberd')
shopModule:addSellableItem({'broken helmet'}, 12409, 20, 'broken helmet')
shopModule:addSellableItem({'broken key ring'}, 12608, 8000, 'broken key ring')
shopModule:addSellableItem({'broken shamanic staff'}, 12408, 35, 'broken shamanic staff')
shopModule:addSellableItem({'broken slicer'}, 12617, 120, 'broken slicer')
shopModule:addSellableItem({'bunch of troll hair'}, 10605, 30, 'bunch of troll hair')
shopModule:addSellableItem({'bundle of cursed straw'}, 10606, 800, 'bundle of cursed straw')
shopModule:addSellableItem({'carniphila seeds'}, 11217, 50, 'carniphila seeds')
shopModule:addSellableItem({'carrion worm fang'}, 11186, 35, 'carrion worm fang')
shopModule:addSellableItem({'centipede leg'}, 11192, 28, 'centipede leg')
shopModule:addSellableItem({'chicken feather'}, 5890, 30, 'chicken feather')
shopModule:addSellableItem({'cobra tongue'}, 10551, 15, 'cobra tongue')
shopModule:addSellableItem({'colourful feather'}, 12470, 110, 'colourful feather')
shopModule:addSellableItem({'compass'}, 11219, 45, 'compass')
shopModule:addSellableItem({'corrupted flag'}, 11326, 700, 'corrupted flag')
shopModule:addSellableItem({'crab pincers'}, 11189, 35, 'crab pincers')
shopModule:addSellableItem({'cultish mask'}, 10555, 280, 'cultish mask')
shopModule:addSellableItem({'cultish robe'}, 10556, 150, 'cultish robe')
shopModule:addSellableItem({'cultish symbol'}, 12411, 500, 'cultish symbol')
shopModule:addSellableItem({'cursed shoulder spikes'}, 11327, 320, 'cursed shoulder spikes')
shopModule:addSellableItem({'cyclops toe'}, 10574, 55, 'cyclops toe')
shopModule:addSellableItem({'dark rosary'}, 11220, 48, 'dark rosary')
shopModule:addSellableItem({'demon dust'}, 5906, 300, 'demon dust')
shopModule:addSellableItem({'demon horn'}, 5954, 1000, 'demon horn')
shopModule:addSellableItem({'demonic skeletal hand'}, 10564, 80, 'demonic skeletal hand')
shopModule:addSellableItem({'dirty turban'}, 12373, 120, 'dirty turban')
shopModule:addSellableItem({'downy feather'}, 12412, 20, 'downy feather') 
shopModule:addSellableItem({'dragon claw'}, 10020, 8000, 'dragon claw')
shopModule:addSellableItem({'dragon priests wandtip'}, 11361, 175, 'dragon priests wandtip')
shopModule:addSellableItem({'dragon tail'}, 12413, 100, 'dragon tail')
shopModule:addSellableItem({'draken sulphur'}, 12614, 550, 'draken sulphur')
shopModule:addSellableItem({'draken wristbands'}, 12615, 430, 'draken wristbands')
shopModule:addSellableItem({'elder bonelord tentacle'}, 11193, 150, 'elder bonelord tentacle')
shopModule:addSellableItem({'elven astral observer'}, 12421, 90, 'elven astral observer')
shopModule:addSellableItem({'elven scouting glass'}, 12420, 50, 'elven scouting glass')
shopModule:addSellableItem({'elvish talisman'}, 10552, 45, 'elvish talisman')
shopModule:addSellableItem({'essence of a bad dream'}, 11223, 360, 'essence of a bad dream') 
shopModule:addSellableItem({'eye of corruption'}, 12627, 390, 'eye of corruption')
shopModule:addSellableItem({'ferumbras hat'}, 5903, 50000, 'ferumbras hat')
shopModule:addSellableItem({'fiery heart'}, 10553, 375, 'fiery heart')
shopModule:addSellableItem({'fish fin'}, 5895, 150, 'fish fin')
shopModule:addSellableItem({'flask of embalming fluid'}, 12422, 30, 'flask of embalming fluid')
shopModule:addSellableItem({'frost giant pelt'}, 10575, 160, 'frost giant pelt')
shopModule:addSellableItem({'frosty ear of a troll'}, 10565, 30, 'frosty ear of a troll')
shopModule:addSellableItem({'frosty heart'}, 10578, 280, 'frosty heart')
shopModule:addSellableItem({'gauze bandage'}, 10566, 90, 'gauze bandage')
shopModule:addSellableItem({'gear crystal'}, 10572, 200, 'gear crystal')
shopModule:addSellableItem({'geomancers robe'}, 12414, 80, 'geomancers robe')
shopModule:addSellableItem({'geomancers staff'}, 12419, 120, 'geomancers staff')
shopModule:addSellableItem({'ghastly dragon head'}, 11366, 700, 'ghastly dragon head')
shopModule:addSellableItem({'ghostly tissue'}, 10607, 90, 'ghostly tissue')
shopModule:addSellableItem({'ghoul snack'}, 12423, 60, 'ghoul snack')
shopModule:addSellableItem({'giant eye'}, 11197, 380, 'giant eye')
shopModule:addSellableItem({'girlish hair decoration'}, 12399, 30, 'girlish hair decoration')
shopModule:addSellableItem({'glob of acid slime'}, 9967, 25, 'glob of acid slime')
shopModule:addSellableItem({'glob of mercury'}, 9966, 20, 'glob of mercury')
shopModule:addSellableItem({'glob of tar'}, 9968, 30, 'glob of tar')
shopModule:addSellableItem({'goblin ear'}, 12472, 20, 'goblin ear')
shopModule:addSellableItem({'green dragon leather'}, 5877, 100, 'green dragon leather')
shopModule:addSellableItem({'green dragon scale'}, 5920, 100, 'green dragon scale')
shopModule:addSellableItem({'hair of a banshee'}, 12402, 350, 'hair of a banshee')
shopModule:addSellableItem({'half-digested piece of meat'}, 11200, 55, 'half-digested piece of meat')
shopModule:addSellableItem({'half-eaten brain'}, 10576, 85, 'half-eaten brain')
shopModule:addSellableItem({'hardened bone'}, 5925, 70, 'hardened bone')
shopModule:addSellableItem({'haunted piece of wood'}, 10600, 115, 'haunted piece of wood')
shopModule:addSellableItem({'hellhound slobber'}, 10554, 500, 'hellhound slobber')
shopModule:addSellableItem({'hellspawn tail'}, 11221, 475, 'hellspawn tail')
shopModule:addSellableItem({'high guard flag'}, 11332, 550, 'high guard flag')
shopModule:addSellableItem({'high guard shoulderplates'}, 11333, 130, 'high guard shoulderplates')
shopModule:addSellableItem({'honeycomb'}, 5902, 40, 'honeycomb')
shopModule:addSellableItem({'hunters quiver'}, 12425, 80, 'hunters quiver')
shopModule:addSellableItem({'hydra egg'}, 4850, 500, 'hydra egg')
shopModule:addSellableItem({'hydra head'}, 11199, 600, 'hydra head')
shopModule:addSellableItem({'jewelled belt'}, 12426, 180, 'jewelled belt')
shopModule:addSellableItem({'kongras shoulderpad'}, 12427, 100, 'kongras shoulderpad')
shopModule:addSellableItem({'lancer beetle shell'}, 11372, 80, 'lancer beetle shell')
shopModule:addSellableItem({'legionnaire flags'}, 11334, 500, 'legionnaire flags')
shopModule:addSellableItem({'lions mane'}, 10608, 60, 'lions mane')
shopModule:addSellableItem({'lizard essence'}, 12636, 300, 'lizard essence')
shopModule:addSellableItem({'lizard leather'}, 5876, 150, 'lizard leather')
shopModule:addSellableItem({'lizard scale'}, 5881, 120, 'lizard scale')
shopModule:addSellableItem({'luminous orb'}, 12410, 1000, 'luminous orb')
shopModule:addSellableItem({'lump of dirt'}, 10609, 10, 'lump of dirt')
shopModule:addSellableItem({'lump of earth'}, 11222, 130, 'lump of earth')
shopModule:addSellableItem({'mammoth tusk'}, 11238, 100, 'mammoth tusk')
shopModule:addSellableItem({'mantassin tail'}, 12445, 28, 'mantassin tail')
shopModule:addSellableItem({'metal spike'}, 11215, 320, 'metal spike')
shopModule:addSellableItem({'minotaur horn'}, 12428, 75, 'minotaur horn')
shopModule:addSellableItem({'minotaur leather'}, 5878, 80, 'minotaur leather')
shopModule:addSellableItem({'miraculum'}, 12430, 60, 'miraculum')
shopModule:addSellableItem({'morgaroths heart'}, 5943, 15000, 'morgaroths heart')
shopModule:addSellableItem({'mutated bat ear'}, 10579, 420, 'mutated bat ear')
shopModule:addSellableItem({'mutated flesh'}, 11225, 50, 'mutated flesh')
shopModule:addSellableItem({'mutated rat tail'}, 10585, 150, 'mutated rat tail')
shopModule:addSellableItem({'mystical hourglass'}, 10577, 700, 'mystical hourglass')
shopModule:addSellableItem({'necromantic robe'}, 12431, 250, 'necromantic robe')
shopModule:addSellableItem({'nettle blossom'}, 11231, 75, 'nettle blossom')
shopModule:addSellableItem({'noble turban'}, 12442, 430, 'noble turban')
shopModule:addSellableItem({'orc leather'}, 12435, 30, 'orc leather')
shopModule:addSellableItem({'orc tooth'}, 11113, 150, 'orc tooth')
shopModule:addSellableItem({'orcish gear'}, 12433, 85, 'orcish gear')
shopModule:addSellableItem({'orshabaals brain'}, 5808, 12000, 'orshabaals brain')
shopModule:addSellableItem({'pelvis bone'}, 12437, 30, 'pelvis bone')
shopModule:addSellableItem({'perfect behemoth fang'}, 5893, 250, 'perfect behemoth fang')
shopModule:addSellableItem({'petrified scream'}, 11337, 250, 'petrified scream')
shopModule:addSellableItem({'piece of archer armor'}, 12439, 20, 'piece of archer armor')
shopModule:addSellableItem({'piece of crocodile leather'}, 11196, 15, 'piece of crocodile leather') 
shopModule:addSellableItem({'piece of dead brain'}, 10580, 420, 'piece of dead brain')
shopModule:addSellableItem({'piece of hellfire armor'}, 10581, 550, 'piece of hellfire armor')
shopModule:addSellableItem({'piece of scarab shell'}, 10558, 45, 'piece of scarab shell')
shopModule:addSellableItem({'piece of warrior armor'}, 12438, 50, 'piece of warrior armor')
shopModule:addSellableItem({'pig foot'}, 10610, 10, 'pig foot')
shopModule:addSellableItem({'pile of grave earth'}, 12440, 25, 'pile of grave earth')
shopModule:addSellableItem({'poison spider shell'}, 12441, 10, 'poison spider shell')
shopModule:addSellableItem({'poisonous slime'}, 10557, 50, 'poisonous slime')
shopModule:addSellableItem({'polar bear paw'}, 10567, 30, 'polar bear paw')
shopModule:addSellableItem({'protective charm'}, 12400, 60, 'protective charm')
shopModule:addSellableItem({'purple robe'}, 12429, 110, 'purple robe')
shopModule:addSellableItem({'quara bone'}, 12447, 500, 'quara bone')
shopModule:addSellableItem({'quara eye'}, 12444, 350, 'quara eye')
shopModule:addSellableItem({'quara pincers'}, 12446, 410, 'quara pincers')
shopModule:addSellableItem({'quara tentacle'}, 12443, 140, 'quara tentacle')
shopModule:addSellableItem({'red dragon leather'}, 5948, 200, 'red dragon leather')
shopModule:addSellableItem({'red dragon scale'}, 5882, 200, 'red dragon scale')
shopModule:addSellableItem({'rope belt'}, 12448, 66, 'rope belt')
shopModule:addSellableItem({'rotten piece of cloth'}, 11208, 30, 'rotten piece of cloth')
shopModule:addSellableItem({'sabretooth'}, 11228, 400, 'sabretooth')
shopModule:addSellableItem({'safety pin'}, 12459, 120, 'safety pin')
shopModule:addSellableItem({'sandcrawler shell'}, 11373, 20, 'sandcrawler shell')
shopModule:addSellableItem({'scale of corruption'}, 12629, 680, 'scale of corruption')
shopModule:addSellableItem({'scarab pincers'}, 10548, 280, 'scarab pincers')
shopModule:addSellableItem({'scorpion tail'}, 10568, 25, 'scorpion tail')
shopModule:addSellableItem({'scroll of heroic deeds'}, 12466, 230, 'scroll of heroic deeds')
shopModule:addSellableItem({'scythe leg'}, 11229, 450, 'scythe leg')
shopModule:addSellableItem({'sea serpent scale'}, 10583, 520, 'sea serpent scale')
shopModule:addSellableItem({'shaggy tail'}, 11324, 25, 'shaggy tail')
shopModule:addSellableItem({'shamanic hood'}, 12434, 45, 'shamanic hood')
shopModule:addSellableItem({'shard'}, 7290, 2000, 'shard')
shopModule:addSellableItem({'shiny stone'}, 11227, 500, 'shiny stone')
shopModule:addSellableItem({'silky fur'}, 11209, 35, 'silky fur')
shopModule:addSellableItem({'skull belt'}, 12436, 80, 'skull belt')
shopModule:addSellableItem({'skunk tail'}, 11191, 50, 'skunk tail')
shopModule:addSellableItem({'small flask of eyedrops'}, 12468, 95, 'small flask of eyedrops')
shopModule:addSellableItem({'small notebook'}, 12406, 480, 'small notebook')
shopModule:addSellableItem({'small pitchfork'}, 12469, 70, 'small pitchfork')
shopModule:addSellableItem({'snake skin'}, 10611, 400, 'snake skin')
shopModule:addSellableItem({'spider fangs'}, 8859, 10, 'spider fangs')
shopModule:addSellableItem({'spider silk'}, 5879, 100, 'spider silk')
shopModule:addSellableItem({'spiked iron ball'}, 11325, 100, 'spiked iron ball')
shopModule:addSellableItem({'spooky blue eye'}, 10559, 95, 'spooky blue eye')
shopModule:addSellableItem({'stone wing'}, 11195, 120, 'stone wing')
shopModule:addSellableItem({'strand of medusa hair'}, 11226, 600, 'strand of medusa hair')
shopModule:addSellableItem({'striped fur'}, 11210, 50, 'striped fur')
shopModule:addSellableItem({'sulphurous stone'}, 11232, 100, 'sulphurous stone')
shopModule:addSellableItem({'swamp grass'}, 10603, 20, 'swamp grass')
shopModule:addSellableItem({'tail of corruption'}, 12628, 240, 'tail of corruption')
shopModule:addSellableItem({'tarantula egg'}, 11198, 80, 'tarantula egg')
shopModule:addSellableItem({'tattered piece of robe'}, 10601, 120, 'tattered piece of robe')
shopModule:addSellableItem({'tentacle piece'}, 12622, 5000, 'tentacle piece')
shopModule:addSellableItem({'terramite legs'}, 11371, 60, 'terramite legs')
shopModule:addSellableItem({'terramite shell'}, 11369, 170, 'terramite shell')
shopModule:addSellableItem({'terrorbird beak'}, 11190, 950, 'terrorbird beak')
shopModule:addSellableItem({'thick fur'}, 11224, 150, 'thick fur')
shopModule:addSellableItem({'thorn'}, 10560, 100, 'thorn')
shopModule:addSellableItem({'trollroot'}, 12471, 50, 'trollroot')
shopModule:addSellableItem({'turtle shell'}, 5899, 90, 'turtle shell')
shopModule:addSellableItem({'tusk'}, 8614, 100, 'tusk')
shopModule:addSellableItem({'undead heart'}, 11367, 200, 'undead heart')
shopModule:addSellableItem({'unholy bone'}, 11233, 480, 'unholy bone')
shopModule:addSellableItem({'vampire dust'}, 5905, 100, 'vampire dust')
shopModule:addSellableItem({'vampire teeth'}, 10602, 275, 'vampire teeth')
shopModule:addSellableItem({'war crystal'}, 10571, 460, 'war crystal')
shopModule:addSellableItem({'warmasters wristguards'}, 11322, 200, 'warmasters wristguards')
shopModule:addSellableItem({'warwolf fur'}, 11235, 30, 'warwolf fur')
shopModule:addSellableItem({'weavers wandtip'}, 11314, 250, 'weavers wandtip')
shopModule:addSellableItem({'werewolf fur'}, 11228, 380, 'werewolf fur')
shopModule:addSellableItem({'widows mandibles'}, 11328, 110, 'widows mandibles')
shopModule:addSellableItem({'winged tail'}, 11230, 800, 'winged tail')
shopModule:addSellableItem({'winter wolf fur'}, 11212, 20, 'winter wolf fur')
shopModule:addSellableItem({'witch broom'}, 10569, 60, 'witch broom')
shopModule:addSellableItem({'wolf paw'}, 5897, 70, 'wolf paw')
shopModule:addSellableItem({'wool'}, 11236, 15, 'wool')
shopModule:addSellableItem({'wyrm scale'}, 10582, 400, 'wyrm scale')
shopModule:addSellableItem({'wyvern talisman'}, 10561, 265, 'wyvern talisman')
shopModule:addSellableItem({'zaogun flag'}, 11330, 600, 'zaogun flag')
shopModule:addSellableItem({'zaoguns shoulderplates'}, 11331, 150, 'zaoguns shoulderplates') 

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
	if(msgcontains(msg, 'trade') or msgcontains(msg, 'ariki')) then
		elseif doPlayerAddAchievement then --Do you have an achievements system?
				doPlayerAddAchievement(cid, "Si, Ariki!", true)
		end
				selfSay('Si! Haneka ariki!', cid)
				talkState[talkUser] = 1
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())