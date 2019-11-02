local soundMap = {
    getHeart = {"Theme_C64_getGold.ogg", "static"},
    finish = {"Theme_C64_goldFinish3.ogg", "stream"}
}

local soundSystem = {
    sources = {}
}

function soundSystem.init()
    for key, value in pairs(soundMap) do
        soundSystem.sources[key] = love.audio.newSource(("assets/sounds/%s"):format(value[1]), value[2])
    end
end

function soundSystem.play(name)
    soundSystem.sources[name]:play()
end

return soundSystem
