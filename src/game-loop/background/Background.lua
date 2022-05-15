import "images/SpriteLoading"
import "game-loop/background/actors/Gears"

class("Background").extends()

function Background:init(graphics)
    local backgroundImage = SpriteLoading.loadBackgroundSprite(graphics)
    backgroundImage:setZIndex(-1)
    backgroundImage:moveTo(200, 120)

    local beltImage = SpriteLoading.loadBeltSprite(graphics)
    beltImage:moveTo(175, 182)
    beltImage:setZIndex(-2)

    self.gears = Gears(graphics)
end

function Background:update()
    self.gears:update()
end

import "Background_Test"