local json     = require "lib/json"
local entities = require "entities"
local data     = {}

-- TODO
local inspect = require "lib/inspect"

local function read_levels()
    local file = io.open("data/levels.json", "r") -- r read mode and b binary mode
    if not file then error("File Doesn't exist") end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return json.decode(content)["data"]
end

data.levels = read_levels()

function data.init_level(level_n, tilesize)
    --[[
    Lode Runner Level value to map (10 different types):
    value | Character | Type
    ------+-----------+-----------
    0x0 |  <space>  | Empty space
    0x1 |     #     | Normal Brick
    0x2 |     @     | Solid Brick
    0x3 |     H     | Ladder
    0x4 |     -     | Hand-to-hand bar (Line of rope)
    0x5 |     X     | False brick
    0x6 |     S     | Ladder appears at end of level
    0x7 |     $     | Gold chest
    0x8 |     0     | Guard
    0x9 |     &     | Player
    ]]
    local conversion = {}
    conversion["#"] = { name="brick",      func = entities.newBrick }
    conversion["@"] = { name="solidbrick", func = entities.newSolidBrick }
    conversion["X"] = { name="falsebrick", func = entities.newFalseBrick }
    conversion["H"] = { name="ladder",     func = entities.newLadder }
    conversion["S"] = { name="endladder",  func = entities.newEndLadder}
    conversion["-"] = { name="rope",       func = entities.newRope }
    conversion["$"] = { name="heart",      func = entities.newHeart }
    conversion["0"] = { name="enemy",      func = entities.newEnemy }
    conversion["&"] = { name="player",     func = entities.newPlayer }
    conversion[" "] = { name="space",      func = function() return end }

    local entities = {}
    for k,v in pairs(conversion) do
        entities[v.name] = {}
    end

    local level = data.levels[level_n]

    for i=1,#level do
        for j=1,#level[i] do
            local char = level[i]:sub(j,j)
            local list = entities[conversion[char]["name"]]
            list[#list+1] = conversion[char]["func"]((j-1)*tilesize, (i-1)*tilesize)
        end
    end

    return entities
end

return data
