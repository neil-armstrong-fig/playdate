import "images/SpriteLoading"

class("Luggage").extends()

function Luggage:init(graphics, position)
    self.position = position
    self.rotation = 0
    self.isPlayerControlDone = false
    self.sprite = SpriteLoading.loadLuggageSprite(graphics, position)
end

function Luggage:startPlayerControl()
    self.sprite:setScale(1)
end

function Luggage:endPlayerControl()
    self.isPlayerControlDone = true
end

function Luggage:logicLoop()
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

import "Luggage-Test"