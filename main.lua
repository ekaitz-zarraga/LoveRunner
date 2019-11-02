-- Some global conf
local tilesize = 16
local zoom = 2

local entities = {}
local data = require "data"
local animation = require "animation"

-- Systems
local physicsSystem = require('systems/physics_system')

-- Pause Mechanism
local gameIsPaused = false
function togglePause() gameIsPaused = not gameIsPaused end

-- TODO
local inspect = require "lib.inspect"

function love.quit()
  print "Thanks for playing! Come back soon!"
  -- Maybe store the state?
end

-- Handle focus lose
function love.focus(f) gameIsPaused = not f end

function love.load()
    -- This function loads everything
    love.window.setMode(tilesize * 28 * zoom, tilesize * 16 * zoom, { vsync=false, fullscreen=false })
    love.graphics.setDefaultFilter( "nearest", "nearest", 1)
    entities = data.init_level( 1, tilesize )

    -- Systems initialization
    physicsSystem.init()

    -- Create the renderable elements
    entities.renderable = {}
    local valid = {"brick", "solidbrick", "ladder", "heart", "rope", "player"}
    for _, i in ipairs(valid) do
        for k,v in pairs(entities[i]) do
            physicsSystem.add(v)
            table.insert(entities.renderable, v) 
        end
    end

    -- Player animation
    for _,player in ipairs(entities.player) do
        player.anim.fs = player.idle_anim_l
    end
end

function love.update(dt)
    if gameIsPaused then return end
    -- This function is called often: dt means delta time since last execution

    -- Serious shit
    --[[
    Para los malos y el personaje:
    Si no tienen suelo o no están en una escalera su velocidad cambia en Y a la
    gravedad (no hay aceleración gravitatoria, sólo una velocidad estática),
    hasta que toquen suelo.

    Si están en escalera la tecla hacia arriba puede cambiar la velocidad en Y,
    si no nada.

    Si las personas tienen pared debajo y a los lados se tuestan durante N
    segundos

    Si tocas al malo mueres

    Si tocas el corazón ganas puntos

    Si el malo toca el corazón se lo queda hasta que lo encierres
    --]]

    -- movePeople()
    -- checkCollisions()
    --

    local moveX = 0
    local moveY = 0
    local speed = 100

    if (love.keyboard.isDown('up')) then
        moveY = moveY - speed
    end

    if (love.keyboard.isDown('down')) then
        moveY = moveY + speed
    end

    if (love.keyboard.isDown('right')) then
        moveX = moveX + speed
    end

    if (love.keyboard.isDown('left')) then
        moveX = moveX - speed
    end

    local heart = entities.heart[1]
    physicsSystem.move(heart, moveX * dt, moveY * dt)

    animation.advance(entities.player, dt)
end


function love.draw()
    -- Render loop
    -- any call to love.graphics out of here won't work
    --love.graphics.draw(player.img, player.x, player.y)

    love.graphics.scale(zoom,zoom)

    -- Only render elements in "renderable" list
    for _,v in pairs(entities.renderable) do
        if not (v.img == nil) then
            love.graphics.draw(v.img, v.x, v.y)
        end
    end

end

-- Input handling
function love.keypressed(key, scancode, isrepeat)
    if (key == 'p') then
        togglePause()
    end
end
