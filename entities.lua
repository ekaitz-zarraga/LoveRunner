local entities = {}

function entities.newBrick( x, y )
    return {
        x   = x,
        y   = y,
        time_to_appear = nil,
        img = love.graphics.newImage('assets/brick.png'),
        reappearing_anim = {
            love.graphics.newImage('assets/brick.png'),
            love.graphics.newImage('assets/empty.png'),
        },
        anim = {
            fpos = 1,
            fs = nil,
        }
    }
end

function entities.newSolidBrick( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/solidbrick.png')
    }
end

function entities.newFalseBrick( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/brick.png')
    }
end

function entities.newLadder( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/ladder.png')
    }
end

function entities.newEndLadder( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/ladder.png')
    }
end

function entities.newRope( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/rope.png')
    }
end

function entities.newHeart( x, y )
    return {
        x   = x,
        y   = y,
        img = love.graphics.newImage('assets/heart.png')
    }
end

function entities.newEnemy( x, y )
    return {
        x   = x,
        y   = y,
        vx  = 0,
        vy  = 0,
        img = nil,
        anim = {
            fpos     = 1,
            fs       = nil, -- will be an array-like table
        },
    }
end

function entities.newPlayer( x, y )
    return {
        x   = x,
        y   = y,
        vx  = 0,
        vy  = 0,
        img = nil,
        anim = {
            fpos     = 1,
            fs       = nil, -- will be an array-like table
        },
    }
end


return entities
