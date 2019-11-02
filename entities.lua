local entities = {}

function entities.newBrick( x, y )
    return {
        x   = x,
        y   = y,
        time_to_appear = nil,
        img = love.graphics.newImage('assets/brick.png'),
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
        last_direction = nil,
        fall_anim_l = {
            love.graphics.newImage('assets/character/Fall_l_0.png'),
            love.graphics.newImage('assets/character/Fall_l_1.png'),
            love.graphics.newImage('assets/character/Fall_l_2.png'),
            love.graphics.newImage('assets/character/Fall_l_3.png'),
        },
        walk_anim_l = {
            love.graphics.newImage('assets/character/Walk_l_0.png'),
            love.graphics.newImage('assets/character/Walk_l_1.png'),
            love.graphics.newImage('assets/character/Walk_l_2.png'),
            love.graphics.newImage('assets/character/Walk_l_3.png'),
        },
        idle_anim_l = {
            love.graphics.newImage('assets/character/Idle_l_0.png'),
            love.graphics.newImage('assets/character/Idle_l_1.png'),
            love.graphics.newImage('assets/character/Idle_l_2.png'),
            love.graphics.newImage('assets/character/Idle_l_3.png'),
        },
        fall_anim_r = {
            love.graphics.newImage('assets/character/Fall_r_0.png'),
            love.graphics.newImage('assets/character/Fall_r_1.png'),
            love.graphics.newImage('assets/character/Fall_r_2.png'),
            love.graphics.newImage('assets/character/Fall_r_3.png'),
        },
        walk_anim_r = {
            love.graphics.newImage('assets/character/Walk_r_0.png'),
            love.graphics.newImage('assets/character/Walk_r_1.png'),
            love.graphics.newImage('assets/character/Walk_r_2.png'),
            love.graphics.newImage('assets/character/Walk_r_3.png'),
        },
        idle_anim_r = {
            love.graphics.newImage('assets/character/Idle_r_0.png'),
            love.graphics.newImage('assets/character/Idle_r_1.png'),
            love.graphics.newImage('assets/character/Idle_r_2.png'),
            love.graphics.newImage('assets/character/Idle_r_3.png'),
        },
        anim = {
            fpos     = 1,
            fs       = nil, -- will be an array-like table
        },
    }
end


return entities
