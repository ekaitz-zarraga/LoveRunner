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

function enemySystem.update(dt, player)
	for _,enemy in ipairs(enemySystem.enemies) do
		if enemy.x - player.x < 0 then
			moveX = 50
		else
			moveX = - 50
		end
		if enemy.y - player.y < 0 then
			moveY = 50
		else
			moveY = - 50
		end
        enemySystem.ps.move(enemy, moveX*dt, moveY*dt)
    end
end

function enemySystem.add(enemy)
    print(("Adding enemy to x=%d y=%d"):format(enemy.x, enemy.y))
    table.insert(enemySystem.enemies,enemy)
end

return enemySystem
