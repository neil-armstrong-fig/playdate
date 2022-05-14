import "actors/player/Player"
import "actors/luggage-queue/LuggageQueue"
import "actors/belt/Belt"
import "state/GameState"

class("GameLoop").extends()

function GameLoop:init(graphics)
    self.player = Player({speed = 5})
    self.luggageQueue = LuggageQueue(graphics)
    self.belt = Belt()
end

function GameLoop:update()
    local firstLuggage = self.luggageQueue:nextLuggage()

    self.player:logicLoop(firstLuggage)
    self.luggageQueue:logicLoop()

    self.belt:logicLoop(firstLuggage)

    return GameState(
            self.player,
            self.belt
    )
end