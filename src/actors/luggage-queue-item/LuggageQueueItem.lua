class("LuggageQueueItem").extends()

local function createImage(graphics, startingPosition)
    local sprite = graphics.sprite.new(ImageLoading.loadPlayerImage(graphics))
    sprite:moveTo(startingPosition.x, startingPosition.y)
    sprite:setScale(0.5)
    sprite:add()

    return sprite
end

function LuggageQueueItem:init(graphics)
    self.position = {
        x = 285,
        y = 15
    }
    self.sprite = createImage(graphics, self.position)
end

import "LuggageQueueItem-Test"