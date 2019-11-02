local bump = require('../lib/bump')

local physicsSystem = {
    bumpWorld = nil
}

function physicsSystem.init()
    print("Physics System - Init")
    physicsSystem.bumpWorld = bump.newWorld(64)
end

function physicsSystem.add(entity)
    print(("Adding entity to x=%d y=%d"):format(entity.x, entity.y))
    physicsSystem.bumpWorld:add(entity, entity.x, entity.y, 16, 16)
end

function physicsSystem.move(entity, x, y)
    oldY = entity.y
    local actualX, actualY, cols, len = physicsSystem.bumpWorld:move(entity, entity.x + x, entity.y + y, collisionFilter)
    entity.x = actualX
    entity.y = actualY
    if len > 1 then
        print(cols[1].other.type)
        if cols[1].other.type == "rope" then
            entity.y = oldY
        end
        if cols[1].other.type == "ladder" then
            entity.x = cols[1].other.x
        end
        if cols[1].other.type == "heart" then
            cols[1].other.x = -10000
            cols[1].other.y = -10000
            physicsSystem.bumpWorld:remove(cols[1].other)
        end
    end
end

function collisionFilter(item, other)
    if other.type == "ladder" then
        return "cross"
    end
    if other.type == "heart" then
        return "cross"
    end
    if other.type == "rope" then
        return "cross"
    end
    return "slide"
end

return physicsSystem
