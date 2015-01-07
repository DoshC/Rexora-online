local talk_start = 0
local target = 0
local following = false
local attacking = false

function onThingMove(creature, thing, oldpos, oldstackpos)

end


function onCreatureAppear(creature)

end


function onCreatureDisappear(cid, pos)
      if focus == cid then
          selfSay('Good bye then.')
          focus = 0
          talk_start = 0
      end
end


function onCreatureTurn(creature)

end


function msgcontains(txt, str)
      return (string.find(txt, str) and not string.find(txt, '(%w+)' .. str) and not string.find(txt, str .. '(%w+)'))
end


function onCreatureSay(cid, type, msg)
      msg = string.lower(msg)

      if (msgcontains(msg, 'hi') and (focus == 0)) and getDistanceToCreature(cid) < 4 then
          selfSay('Hola ' .. getCreatureName(cid) .. 'Yo vendo todas las bless entre estas tenemos: bless1,bless2,bless3,bless4! ')
          focus = cid
          talk_start = os.clock()

      elseif msgcontains(msg, 'hi') and (focus ~= cid) and getDistanceToCreature(cid) < 4 then
          selfSay('Sorry, ' .. getCreatureName(cid) .. '!Yo te atiendo en un minuto')

      elseif focus == cid then
        talk_start = os.clock()

        if msgcontains(msg, 'blessings') then
     selfSay('Para comprar las bless solo diga: bless1,bless2,bless3 o bless4 .')
     
     
     elseif msgcontains(msg, 'bless1') then
     if getPlayerBlessing(cid, 1) then
selfSay('Disculpa, tu ya tienes esta bless.')
else
     if pay(cid,10000) then
     doPlayerAddBlessing(cid,1)
     selfSay('Tu compraste la primera bless.')
     else
     selfSay('Diculpa, tu necesitas 10k.')
     
     end
     
          end

     elseif msgcontains(msg, 'bless2') then
     if getPlayerBlessing(cid, 2) then
     selfSay('Disculpa, tu ya tienes esta bless.')
     else
     if getPlayerBlessing(cid, 1) then
     if pay(cid,10000) then
     doPlayerAddBlessing(cid,2)
     selfSay('Tu compraste la segunda bless.')    
     setPlayerStorageValue(cid,750299,1)
     else
     selfSay('Diculpa, tu necesitas 10k.')
     end
     else
     selfSay('Disculpa, tu necesitas la primera bless.')
     end
     end    
   
     elseif msgcontains(msg, 'bless3') then
     if getPlayerBlessing(cid, 3) then
     selfSay('Disculpa, tu ya tienes esta bless.')
else
     if getPlayerBlessing(cid, 2) then
     if pay(cid,10000) then
     doPlayerAddBlessing(cid,3)
     selfSay('Tu compraste la tercera bless.')
     setPlayerStorageValue(cid,750399,1)
     else
     selfSay('Diculpa, tu necesitas 10k.')
     end
     else
     selfSay('Disculpa, tu necesitas la segunda bless.')
     end
     end

     elseif msgcontains(msg, 'bless4') then
     if getPlayerBlessing(cid, 4) then
     selfSay('Disculpa, tu ya tienes esta bless.')
else
     if getPlayerBlessing(cid, 3) then
     if pay(cid,20000) then
     doPlayerAddBlessing(cid,4)
     doPlayerAddBlessing(cid,5)
     selfSay('Muy bien, ahora tienes todas las bless.')
     else
     selfSay('Diculpa, tu necesitas 20k.')
     end
     else
     selfSay('Disculpa, tu necesitas la tercera bless.')
     end
     end      

        elseif msgcontains(msg, 'bye') and focus == cid and getDistanceToCreature(cid) < 4 then
            selfSay('Good bye, ' .. getCreatureName(cid) .. '!')
            focus = 0
            talk_start = 0
        end
    end
end


function onCreatureChangeOutfit(creature)

end

function onThink()

if (os.clock() - talk_start) > 20 then
          if focus > 0 then
              selfSay('...')
          end
              focus = 0
      end
    if focus ~= 0 then
        if getDistanceToCreature(focus) > 5 then
            selfSay('...')
            focus = 0
        end
    end
end