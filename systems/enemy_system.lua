local bump = require('../lib/bump')

local enemySystem = {
    enemies = {},
    ps = nil
}

function enemySystem.init(physicsSytem)
    print("Enemy System - Init")
    enemySystem.ps = physicsSytem
end

function enemySystem.clear()
    enemySystem.enemies = {}
    enemySystem.ps = nil
end

function enemySystem.update(dt)
    for _,enemy in ipairs(enemySystem.enemies) do
        enemySystem.ps.move(enemy,1*dt,0)
    end
end

function enemySystem.add(enemy)
    print(("Adding enemy to x=%d y=%d"):format(enemy.x, enemy.y))
    table.insert(enemySystem.enemies,enemy)
end

return enemySystem
