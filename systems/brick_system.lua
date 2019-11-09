local bump = require('../lib/bump')
local debugBrickEnabled = false

local brickSystem = {
	bricks = {},
	ps = nil
}

function brickSystem.init(physicsSytem)
    print("Brick System - Init")
    brickSystem.ps = physicsSytem
end

function brickSystem.clear()
	brickSystem.bricks = {}
	brickSystem.ps = nil
end

function brickSystem.update(dt)
	for _,brick in ipairs(brickSystem.bricks) do

		if brick.time_to_appear>0 then
			brick.time_to_appear=brick.time_to_appear-10*dt
		end

		if brick.time_to_appear<0 then
			brick.time_to_appear=0
		end

		if brick.time_to_appear>0 then
			brickSystem.ps.remove(brick)
		else
			brickSystem.ps.add(brick)
		end

	end
end

function brickSystem.add(brick)
    debugBrick(("Adding brick to x=%d y=%d"):format(brick.x, brick.y))
    table.insert(brickSystem.bricks,brick)
    brickSystem.ps.add(brick)
end

function brickSystem.remove(brick)
    debugBrick(("Adding brick to x=%d y=%d"):format(brick.x, brick.y))
    table.remove(brickSystem.bricks,brick)
    brickSystem.ps.remove(brick)
end

function debugBrick(text)
    if (debugBrickEnabled) then print(text) end
end

return brickSystem
