local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'spellbook'}, 2175, 150, 'spellbook')


shopModule:addBuyableItem({'blank'}, 2260, 10, 1, 'blank rune')
shopModule:addBuyableItem({'stone shower rune'}, 2288, 37, 4, 'stone shower rune')
shopModule:addBuyableItem({'thunderstorm rune'}, 2315, 37, 4, 'thunderstorm rune')
shopModule:addBuyableItem({'icicle rune'}, 2271, 30, 5, 'icicle rune')
shopModule:addBuyableItem({'holy missile rune'}, 2295, 16, 5, 'holy missile rune')
shopModule:addBuyableItem({'desintegrate rune'}, 2310, 26, 3, 'desintegrate rune')
shopModule:addBuyableItem({'poison bomb rune'}, 2286, 85, 2, 'poison bomb rune')
shopModule:addBuyableItem({'energy bomb rune'}, 2262, 162, 2, 'energy bomb rune')
shopModule:addBuyableItem({'soulfire rune'}, 2308, 46, 3, 'soulfire rune')
shopModule:addBuyableItem({'magic wall rune'}, 2293, 116, 3, 'magic wall rune')
shopModule:addBuyableItem({'animate dead rune'}, 2316, 375, 1, 'animate dead rune')
shopModule:addBuyableItem({'paralyze rune'}, 2278, 700, 1, 'paralyze rune')
shopModule:addBuyableItem({'fireball rune'}, 2302, 30, 5, 'fireball rune')
shopModule:addBuyableItem({'wild growth rune'}, 2269, 160, 2, 'wild growth rune')


shopModule:addBuyableItem({'wand of vortex', 'vortex'}, 2190, 100, 'wand of vortex')
shopModule:addBuyableItem({'wand of dragonbreath', 'dragonbreath'}, 2191, 500, 'wand of dragonbreath')
shopModule:addBuyableItem({'wand of decay', 'decay'}, 2188, 2000, 'wand of decay')
shopModule:addBuyableItem({'wand of draconia', 'draconia'}, 8921, 3000, 'wand of draconia')
shopModule:addBuyableItem({'wand of cosmic energy', 'cosmic energy'}, 2189, 3000, 'wand of cosmic energy')
shopModule:addBuyableItem({'wand of inferno', 'inferno'}, 2187, 5000, 'wand of inferno')
shopModule:addBuyableItem({'wand of starstorm', 'starstorm'}, 8920, 8000, 'wand of starstorm')
shopModule:addBuyableItem({'wand of voodoo', 'voodoo'}, 8922, 10000, 'wand of voodoo')

shopModule:addBuyableItem({'snakebite rod', 'snakebite'}, 2182, 100, 'snakebite rod')
shopModule:addBuyableItem({'moonlight rod', 'moonlight'}, 2186, 1000, 'moonlight rod')
shopModule:addBuyableItem({'necrotic rod', 'necrotic'}, 2185, 2000, 'necrotic rod')
shopModule:addBuyableItem({'northwind rod', 'northwind'}, 8911, 5000, 'northwind rod')
shopModule:addBuyableItem({'terra rod', 'terra'}, 2181, 3000, 'terra rod')
shopModule:addBuyableItem({'hailstorm rod', 'hailstorm'}, 2183, 6000, 'hailstorm rod')
shopModule:addBuyableItem({'springsprout rod', 'springsprout'}, 8912, 8000, 'springsprout rod')
shopModule:addBuyableItem({'underworld rod', 'underworld'}, 8910, 10000,  'underworld rod')

shopModule:addBuyableItem({'life ring', 'life ring'}, 2168, 900, 1, 'life ring')
shopModule:addBuyableItem({'crystal ball', 'crystal ball'}, 2192, 530, 1, 'crystal ball')


shopModule:addSellableItem({'spellbook of enlightenment', 'spellbook of enlightenment'}, 8900, 4000, 'spellbook of enlightenment')
shopModule:addSellableItem({'spellbook of warding', 'spellbook of warding'}, 8901, 8000, 'spellbook of warding')
shopModule:addSellableItem({'spellbook of mind control', 'spellbook of mind control'}, 8902, 13000, 'spellbook of mind control')
shopModule:addSellableItem({'spellbook of lost souls', 'spellbook of lost souls'}, 8903, 19000, 'spellbook of lost souls')
shopModule:addSellableItem({'crystal ball', 'crystal ball'}, 2192, 190, 'crystal ball')
shopModule:addSellableItem({'life Crystal', 'life Crystal'}, 2177, 85, 'life crystal')
shopModule:addSellableItem({'mind Stone', 'mind Stone'}, 2178, 170, 'mind stone')

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	end

	

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())