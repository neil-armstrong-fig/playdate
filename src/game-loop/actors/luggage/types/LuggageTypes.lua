local spriteCache = {}

class("LuggageType").extends()

function LuggageType:init(name, spriteLoader)
    self.name = name
    self.spriteLoader = spriteLoader
end

function LuggageType:loadSprite(graphics)
    if (spriteCache[self.name] ~= nil) then
        return spriteCache[self.name]
    end

    local sprite = self.spriteLoader(graphics)
    if (graphics.isMock == false) then
        spriteCache[self.name] = sprite
    end
    return sprite
end

LuggageTypes = {
    [1] = LuggageType("Suitcase", SpriteLoading.loadSuitcaseSprite),
    [2] = LuggageType("Ball", SpriteLoading.loadBallSprite),
    [3] = LuggageType("Carrier", SpriteLoading.loadCarrierSprite),
    [4] = LuggageType("Surfboard", SpriteLoading.loadSurfboardSprite),
}
LuggageTypes.size = table.length(LuggageTypes)