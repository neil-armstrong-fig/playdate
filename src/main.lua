import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "utils/TableMerge"

import "actors/Player"
import "actors/Background"
import "RenderLoop"

local player = Player({speed = 20})
local background = Background()

-- `playdate.update()` is the heart of every Playdate game.
-- This function is called right before every frame is drawn onscreen.
-- Use this function to poll input, run game logic, and move sprites.
function playdate.update()
    player:logicLoop()

    renderLoop()
end

