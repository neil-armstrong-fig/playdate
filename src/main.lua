import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "utils/Table"
import "utils/Lists"

import "actors/player/Player"
import "actors/luggage-queue/LuggageQueue"
import "actors/belt/Belt"
import "actors/background/Background"

import "state/GameState"

import "render-loop/RenderLoop"

local graphics <const> = playdate.graphics

local player = Player({speed = 5})
local luggageQueue = LuggageQueue(graphics)
local belt = Belt()
local background = Background(graphics)

local renderLoop = RenderLoop(graphics)

function playdate.update()
    local firstLuggage = luggageQueue:nextLuggage()

    player:logicLoop(firstLuggage)
    luggageQueue:logicLoop()

    belt:logicLoop(firstLuggage)

    local currentGameState = GameState(
            player,
            belt
    )
    renderLoop:update(currentGameState)
end

UnitTest.runTests()