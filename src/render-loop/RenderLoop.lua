import "ui/UiDraw"

class("RenderLoop").extends()

function RenderLoop:init(graphics)
    self.graphics = graphics
    self.uiDrawer = UiDraw(graphics)
end

function RenderLoop:update(gameState)
    -- Call the function below in playdate.update() to draw sprites
    self.graphics.sprite.update()

    self.uiDrawer:drawUi(gameState)

    playdate.timer.updateTimers()
end