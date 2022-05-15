import "images/SpriteLoading"
import "game-loop/actors/luggage/types/LuggageTypes"

class("Luggage").extends()

function Luggage:init(graphics, position, luggageType)
    self.position = position
    self.rotation = 0
    self.isPlayerControlDone = false

    if (luggageType == nil) then
        luggageType = math.randomseed(playdate.getCurrentTimeMilliseconds() % LuggageTypes.size) + 1
    end
    self.luggageType = LuggageTypes[luggageType]

    self.sprite = self.luggageType:loadImage(graphics)
    self.sprite:moveTo(position.x, position.y)
    self.sprite:setScale(0.5)
end

function Luggage:startPlayerControl()
    self.sprite:setScale(1)
end

function Luggage:endPlayerControl(bottomOfBeltPosition)
    self.position.y = bottomOfBeltPosition
    self.sprite:setZIndex(-2)
    self.isPlayerControlDone = true
end

function Luggage:update()
    self:_updateSpriteRotation()
    self:_updateSpritePosition()
end

function Luggage:_updateSpriteRotation()
    if (self.sprite.rotation ~= self.rotation) then
        self.sprite:setRotation(self.rotation)
    end
end

function Luggage:_updateSpritePosition(sprite, newPosition)
    if (self.sprite.x ~= self.position.x or self.sprite.y ~= self.position.y) then
        self.sprite:moveTo(self.position.x, self.position.y)
    end
end

import "Luggage_Test"