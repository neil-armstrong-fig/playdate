import "images/ImageLoading"
import "game-loop/background/actors/Gears"

local function createBackgroundImage(graphics)
    -- We want an environment displayed behind our sprite.
    -- There are generally two ways to do this:
    -- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
    -- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
    --       and call :setZIndex() with some low number so the background stays behind
    --       your other sprites.
    local backgroundImage = graphics.sprite.new(ImageLoading.loadBackgroundImage(graphics))
    backgroundImage:setZIndex(-1)
    backgroundImage:moveTo(200, 120)
    backgroundImage:add()

    local beltImage = graphics.sprite.new(ImageLoading.loadBeltImage(graphics))
    beltImage:moveTo(175, 182)
    beltImage:setZIndex(-2)
    beltImage:add()
end

class("Background").extends()

function Background:init(graphics)
    createBackgroundImage(graphics)
    self.gears = Gears(graphics)
end

function Background:update()
    self.gears:update()
end

import "Background_Test"