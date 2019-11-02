local bump = require('../lib/bump')

local debugEnabled = false

local physicsSystem = {
    bumpWorld = nil
}

function physicsSystem.init()
    -- print("Physics System - Init")
    physicsSystem.bumpWorld = bump.newWorld(128)
end

function physicsSystem.add(entity)
    -- print(("Adding entity to x=%d y=%d"):format(entity.x, entity.y))
    physicsSystem.bumpWorld:add(entity, entity.x, entity.y, 16, 16)
end

function physicsSystem.move(entity, x, y)
    oldY = entity.y
    local items, len = physicsSystem.bumpWorld:queryRect(entity.x, entity.y + 16, 16, 1)
    if len == 0 then
        -- TODO: player is not falling completely to the ground because move() rounds it
        y = 0.25
    end
    local actualX, actualY, cols, len = physicsSystem.bumpWorld:move(entity, entity.x + x, entity.y + y, collisionFilter)
    entity.x = actualX
    entity.y = actualY

    -- Process collisions
    if #cols > 0 then

        debug(("Had %d collisions"):format(#cols))
        for i, col in pairs(cols) do

            local collidedEntity = col.other
            debug((" - Collision type: %s"):format(col.type))
            debug((" -    Entity type: %s"):format(collidedEntity.type))

            if collidedEntity.type == "rope" then
                entity.y = oldY
            end

            if collidedEntity.type == "ladder" or collidedEntity.type == "endladder" then
                entity.x = collidedEntity.x
            end

            if entity.type == "player" and collidedEntity.type == "heart" then
                collidedEntity.x = -10000
                collidedEntity.y = -10000
                entity.hearts = entity.hearts + 1
                debug(("player has %d hearts"):format(entity.hearts))
                physicsSystem.bumpWorld:remove(collidedEntity)
            end

        end

    end
end

function collisionFilter(item, other)
    if other.type == "ladder" or other.type == "endladder" or other.type == "heart" or other.type == "rope" then
        return "cross"
    end
    return "slide"
end

function debug(text)
    if (debugEnabled) then print(text) end
end

return physicsSystem
