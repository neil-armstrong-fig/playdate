import "images/ImageLoading"

SpriteLoading = {}

function SpriteLoading.loadBackgroundSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadBackgroundImage(graphics))
    sprite:add()
    return sprite
end

function SpriteLoading.loadBeltSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadBeltImage(graphics))
    sprite:add()
    return sprite
end

function SpriteLoading.loadSuitcaseSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadSuitcaseImage(graphics))
    sprite:add()
    return sprite
end

function SpriteLoading.loadBallSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadBallImage(graphics))
    sprite:add()
    return sprite
end

function SpriteLoading.loadCarrierSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadCarrierImage(graphics))
    sprite:add()
    return sprite
end

function SpriteLoading.loadSurfboardSprite(graphics)
    local sprite = graphics.sprite.new(ImageLoading.loadSurfboardImage(graphics))
    sprite:add()
    return sprite
end