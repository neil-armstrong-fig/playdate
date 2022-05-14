import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "test-setup/UnitTest"

import "utils/Table"
import "utils/Lists"

import "background/Background"

import "game-loop/GameLoop"
import "render-loop/RenderLoop"

local graphics <const> = playdate.graphics

local background = Background(graphics)

local gameLoop = GameLoop(graphics)
local renderLoop = RenderLoop(graphics)

function playdate.update()
    local gameState = gameLoop:update()
    renderLoop:update(gameState)
end

UnitTest.runTests()