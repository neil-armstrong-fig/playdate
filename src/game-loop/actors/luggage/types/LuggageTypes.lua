class("LuggageType").extends()

function LuggageType:init(name, spriteLoader)
    self.name = name
    self.spriteLoader = spriteLoader
end

function LuggageType:loadSprite(graphics)
    return self.spriteLoader(graphics)
end

LuggageTypes = {
    [1] = LuggageType("Suitcase", SpriteLoading.loadSuitcaseSprite),
    [2] = LuggageType("Ball", SpriteLoading.loadBallSprite),
    [3] = LuggageType("Carrier", SpriteLoading.loadCarrierSprite),
    [4] = LuggageType("Surfboard", SpriteLoading.loadSurfboardSprite),
}
LuggageTypes.size = table.length(LuggageTypes)