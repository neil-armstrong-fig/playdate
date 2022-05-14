import "images/ImageLoading"

SpriteLoading = {}

function SpriteLoading.loadLuggageSprite(graphics, startingPosition)
    local sprite = graphics.sprite.new(ImageLoading.loadLuggageQueueItemImage(graphics))
    sprite:moveTo(startingPosition.x, startingPosition.y)
    sprite:setScale(0.5)
    sprite:add()

    return sprite
end