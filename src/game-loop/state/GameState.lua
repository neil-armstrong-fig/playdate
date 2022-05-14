class("GameState").extends()

function GameState:init(player, belt)
    self.playerPosition = player.luggage.position
    assert(self.playerPosition, "Player position was nil")

    self.playerRotation = player.luggage.rotation
    assert(self.playerRotation, "Player rotation was nil")

    self.numberOfItemsOnBelt = belt.size
    assert(self.numberOfItemsOnBelt, "Belt size was nil")
end

import "GameState-Test"