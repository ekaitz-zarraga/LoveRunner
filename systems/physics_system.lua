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
    local actualX, actualY, cols, len = physicsSystem.bumpWorld:move(entity, entity.x + x, entity.y + y)
    entity.x = actualX
    entity.y = actualY
end

return physicsSystem
