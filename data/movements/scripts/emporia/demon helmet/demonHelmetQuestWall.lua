local c = {
    rockID = 1050, -- ID de la pared.
    playerPos = {9992, 9993}, -- Mismos UniqueID de ambos tiles que le hayas puesto a la línea del Movements.xml
    rockPos = {
      {x = 33210, y = 31630, z = 13, stackpos = 1}, -- Coordenada del lugar donde se hallará la pared.
      {x = 33211, y = 31630, z = 13, stackpos = 1}, -- Coordenada del lugar donde se hallará la pared.
      {x = 33212, y = 31630, z = 13, stackpos = 1}, -- Coordenada del lugar donde se hallará la pared.
    },
  }

function onStepIn(cid, item, position, fromPos, toPos)
  local p = {
    player1 = isPlayer(getTopCreature(getThingPos(c.playerPos[1])).uid),
    player2 = isPlayer(getTopCreature(getThingPos(c.playerPos[2])).uid),
  }
    if isPlayer(cid) then
        if (item.uid == c.playerPos[1] and p.player2) or (item.uid == c.playerPos[2] and p.player1) then
            for i = 1, #c.rockPos do
              local Rock = getTileItemById(c.rockPos[i], c.rockID).uid
                if Rock > 0 then
                    doRemoveItem(Rock, 1)
					end
                end
            end
        end
  return true
end

function onStepOut(cid, item, position, fromPos, toPos)
  local p = {
    player1 = getTopCreature(getThingPos(c.playerPos[1])).uid,
    player2 = getTopCreature(getThingPos(c.playerPos[2])).uid,
  }
    if isPlayer(cid) then
        if (item.uid == c.playerPos[1] and p.player2 > 0) or (item.uid == c.playerPos[2] and p.player1 > 0) then
            for i = 1, #c.rockPos do
              local Rock = getTileItemById(c.rockPos[i], c.rockID).uid
                if Rock < 1 then
                    doCreateItem(c.rockID, 1, c.rockPos[i])
                    end
                end
            end
        end
  return true
end