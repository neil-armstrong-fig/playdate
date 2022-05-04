import "./images/ImageLoading"

local function createBackgroundImage(graphics)
    -- We want an environment displayed behind our sprite.
    -- There are generally two ways to do this:
    -- 1) Use setBackgroundDrawingCallback() to draw a background image. (This is what we're doing below.)
    -- 2) Use a tilemap, assign it to a sprite with sprite:setTilemap(tilemap),
    --       and call :setZIndex() with some low number so the background stays behind
    --       your other sprites.
    local backgroundImage = ImageLoading.loadBackgroundImage()

    function drawBackgroundCallback(x, y, width, height)
        graphics.setClipRect(x, y, width, height) -- let's only draw the part of the screen that's dirty
        backgroundImage:draw(0, 0)
        graphics.clearClipRect() -- clear so we don't interfere with drawing that comes after this
    end
    graphics.sprite.setBackgroundDrawingCallback(drawBackgroundCallback)
end

class("Background").extends()

function Background:init(graphics)
    createBackgroundImage(graphics)
end