import "ui/UiDrawer"

class("RenderLoop").extends()

function RenderLoop:init(graphics, config)
    self.graphics = graphics
    self.playdate = playdate
    self.uiDrawer = UiDrawer(graphics)

    if (config == nil) then
        return
    end
    if (config.uiDrawerMock) then
        self.uiDrawer = config.uiDrawerMock
    end
    if (config.playdateMock) then
        self.playdate = config.playdateMock
    end
end

function RenderLoop:update(gameState)
    -- Call the function below in playdate.update() to draw sprites
    self.graphics.sprite.update()

    self.uiDrawer:drawUi(gameState)

    self.playdate.timer.updateTimers()
end

import "RenderLoop_Test"