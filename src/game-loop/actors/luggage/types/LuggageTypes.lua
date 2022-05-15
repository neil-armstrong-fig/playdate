local imageCache = {}

class("LuggageType").extends()

function LuggageType:init(name, imageLoader)
    self.name = name
    self.imageLoader = imageLoader
end

function LuggageType:loadImage(graphics)
    if (imageCache[self.name] ~= nil) then
        return imageCache[self.name]
    end

    local image = self.imageLoader(graphics)
    if (graphics.isMock == false) then
        imageCache[self.name] = image
    end
    return image
end

LuggageTypes = {
    [1] = LuggageType("Suitcase", SpriteLoading.loadSuitcaseSprite),
    [2] = LuggageType("Ball", SpriteLoading.loadBallSprite),
    [3] = LuggageType("Carrier", SpriteLoading.loadCarrierSprite),
    [4] = LuggageType("Surfboard", SpriteLoading.loadSurfboardSprite),
}
LuggageTypes.size = table.length(LuggageTypes)