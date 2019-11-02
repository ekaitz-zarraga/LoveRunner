local math = require "math"
local animation = {}

-- TODO
local inspect = require "lib/inspect"

animation.framerate = 1/15
animation.timeout   = animation.framerate

function animation.advance(entities, dt)
    --[[
    This function receives all the entities to be animated and rotates their
    frames if the timeout has expired.

    Expects current animation in `entity.anim.fs`
    Expects current frame position in `entity.anim.fpos`
    ]]

    -- Make time advance
    animation.timeout = animation.timeout - dt

    -- If it's not the time yet just finish
    if animation.timeout > 0 then
        return
    end

    -- It's time, reset the timer
    animation.timeout = animation.framerate


    for i,entity in ipairs(entities) do
        if entity.anim.fs then -- Entity must have an animation

            -- Chooses the next image or starts again if timeout finished
            entity.anim.fpos = entity.anim.fpos % #entity.anim.fs + 1
            entity.img = entity.anim.fs[entity.anim.fpos]

        end
    end
end

return animation
