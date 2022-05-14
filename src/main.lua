import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "utils/Table"
import "utils/Lists"

import "actors/player/Player"
import "actors/luggage-queue-item/LuggageQueueItem"
import "actors/background/Background"

import "state/GameState"

import "render-loop/RenderLoop"

local graphics <const> = playdate.graphics

local player = Player(graphics, {speed = 5})
local luggageQueueItem = LuggageQueueItem(graphics)
local background = Background(graphics)

local renderLoop = RenderLoop(graphics)

function playdate.update()
    player:logicLoop()

    local currentGameState = GameState(
            player
    )

    renderLoop:update(currentGameState)
end

UnitTest.runTests()