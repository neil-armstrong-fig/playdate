class("UiDraw").extends()

function UiDraw:init(graphics)
    self.drawText = graphics.drawText
end

function UiDraw:drawUi(gameState)
    local positionText = "Player: (" .. gameState.playerPosition.x .. ", " .. gameState.playerPosition.y .. ")"
    self.drawText(positionText, 2, 220)
end

import "UiDraw-Test"