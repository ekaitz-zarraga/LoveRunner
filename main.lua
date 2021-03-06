-- Some global conf
local tilesize = 16
local zoom = 2

local entities = {}
local data = require "data"
local animation = require "animation"
local endladderShown = false
local level = 1

-- Systems
local physicsSystem = require('systems/physics_system')
local enemySystem = require('systems/enemy_system')
local brickSystem = require('systems/brick_system')
local soundSystem = require('systems/sound_system')

-- Pause Mechanism
local gameIsPaused = false
function togglePause() gameIsPaused = not gameIsPaused end

-- To dump vars
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
    soundSystem.init()
    loadLevel()
end

function loadLevel()
    entities = data.init_level( level, tilesize )

    -- Systems initialization
    physicsSystem.init(soundSystem)
    enemySystem.init(physicsSystem)
    brickSystem.init(physicsSystem)

    -- Create the renderable elements
    entities.renderable = {}
    local valid = {"brick", "solidbrick", "ladder", "heart", "rope", "player", "enemy"}
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

    for k,v in pairs(entities.enemy) do
        enemySystem.add(v)
    end

    for k,v in pairs(entities.brick) do
        brickSystem.add(v)
    end

    -- Sound test
    soundSystem.play('finish')
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

    local speed = 50

    local player = entities.player[1]
    if (love.keyboard.isDown('up')) then
        player.vy = -speed
    elseif (love.keyboard.isDown('down')) then
        player.vy = speed
    else
        player.vy = 0
    end

    if (love.keyboard.isDown('right')) then
        player.vx = speed
    elseif (love.keyboard.isDown('left')) then
        player.vx = -speed
    else
        player.vx = 0
    end

    physicsSystem.move(player, player.vx * dt, player.vy * dt)
    enemySystem.update(dt, player)
    brickSystem.update(dt)

    if physicsSystem.isGameOver then
        print("Game over")
        soundSystem.play("finish")
        togglePause()
    end

    if player.vx < 0 then
        player.anim.fs = player.walk_anim_l
        player.last_direction = "l"
    elseif player.vx > 0 then
        player.anim.fs = player.walk_anim_r
        player.last_direction = "r"
    else
        if player.last_direction == "r" then
            player.anim.fs = player.idle_anim_r
        else
            player.anim.fs = player.idle_anim_l
        end
    end

    physicsSystem.move(player, player.vx * dt, player.vy * dt)

    animation.advance(entities.player, dt)

    if player.hearts == #entities.heart and not endladderShown then
        endladderShown = true
        print("adding endladder")
        for k,v in pairs(entities["endladder"]) do
            physicsSystem.add(v)
            table.insert(entities.renderable, 0, v)
        end
    end

    if player.y < -16 then
        togglePause()
        level = level + 1
        endladderShown = false
        physicsSystem.clear()
        enemySystem.clear()
        entities = {}
        loadLevel()
        togglePause()
    end

    if player.y > tilesize*9* zoom then --FIXME: can't make love.window.getHeight() work
        physicsSystem.isGameOver = true
    end
end


function love.draw()
    -- Render loop
    -- any call to love.graphics out of here won't work
    --love.graphics.draw(player.img, player.x, player.y)

    love.graphics.scale(zoom,zoom)

    love.graphics.print(("Hearts: %d"):format(entities.player[1].hearts))

    -- Only render elements in "renderable" list
    for _,v in pairs(entities.renderable) do
        if not (v.img == nil) then
            love.graphics.draw(v.img, v.x, v.y)
        end
    end

    if physicsSystem.isGameOver then
        -- TODO: this is not properly centered
        love.graphics.print({{255, 0, 0}, ("Game over (level %d)"):format(level)}, 128, 112, 0, 2, 2)
    end

end

-- Input handling
function love.keypressed(key, scancode, isrepeat)
    if (key == 'p' and not physicsSystem.isGameOver) then
        togglePause()
    end
    if (key == 'r') then
        love.event.quit("restart")
    end
    if (key == 'escape') then
        love.event.quit()
    end

    local player = entities.player[1]
    if (key == 'z') then
        physicsSystem.dig(player, tilesize)
    end
    if (key == 'x') then
        physicsSystem.dig(player, -tilesize)
    end
end
