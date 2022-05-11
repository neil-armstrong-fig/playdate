class("UiDrawer").extends()

function UiDrawer:init(graphics)
    self.drawText = graphics.drawText
end

function UiDrawer:drawUi(gameState)
    local positionText = "Player: (" .. gameState.playerPosition.x .. ", " .. gameState.playerPosition.y .. ")"
    self.drawText(positionText, 2, 220)
end

import "UiDrawer-Test"