import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "utils/Table"

import "actors/Player"
import "actors/Background"
import "RenderLoop"

local player = Player({speed = 20})
local background = Background()

function playdate.update()
    player:logicLoop()

    renderLoop()
end

