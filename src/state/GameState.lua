class("GameState").extends()

function GameState:init(player)
    self.playerPosition = player.position
    assert(self.playerPosition, "Player position was nil")

    self.playerRotation = player.rotation
    assert(self.playerRotation, "Player rotation was nil")
end

import "GameState-Test"