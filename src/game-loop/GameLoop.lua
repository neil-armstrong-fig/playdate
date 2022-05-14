import "background/Background"
import "actors/player/Player"
import "actors/luggage-queue/LuggageQueue"
import "actors/belt/Belt"
import "state/GameState"

class("GameLoop").extends()

function GameLoop:init(graphics)
    self.background = Background(graphics)
    self.player = Player({speed = 5})
    self.luggageQueue = LuggageQueue(graphics)
    self.belt = Belt()
end

function GameLoop:update()
    self.background:update()

    local activeLuggage = self.luggageQueue:getActiveLuggage()

    self.player:update(activeLuggage)
    self.luggageQueue:update()
    self.belt:update(activeLuggage)

    return GameState(
            self.player,
            self.belt
    )
end