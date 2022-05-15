import "images/SpriteLoading"
import "game-loop/actors/luggage/types/LuggageTypes"

class("Luggage").extends()

function Luggage:init(graphics, position, luggageType)
    self.position = position
    self.rotation = 0
    self.isPlayerControlDone = false
    self.isDropping = false
    self.collisionEnabled = false

    if (luggageType == nil) then
        luggageType = math.randomseed(playdate.getCurrentTimeMilliseconds() % LuggageTypes.size) + 1
    end
    self.luggageType = LuggageTypes[luggageType]

    self.sprite = self.luggageType:loadSprite(graphics)
    self.sprite:moveTo(position.x, position.y)
    self.sprite:setScale(0.5)
end

function Luggage:startPlayerControl()
    self.sprite:setScale(1)
    self.collisionEnabled = true
end

function Luggage:dropBy(speed)
    self.isDropping = true
    self.position.y = self.position.y + speed
end

function Luggage:update()
    self:_updateSpriteRotation()
    self:_updateSpritePosition()
end

function Luggage:_updateSpriteRotation()
    if (self.sprite.rotation ~= self.rotation) then
        self.sprite:setRotation(self.rotation)

        if (self.collisionEnabled) then
            self.sprite:setCollideRect(0, 0, self.sprite:getSize())
        end
    end
end

function Luggage:_updateSpritePosition()
    if (self.sprite.x ~= self.position.x or self.sprite.y ~= self.position.y) then
        self.sprite:moveTo(self.position.x, self.position.y)
    end
end

function Luggage:getBoundingRect()
    return {
        left = self.position.x - 16,
        right = self.position.x + 16,
        top = self.position.y - 16,
        bottom = self.position.y + 16
    }
end

function Luggage:hasCollidedWith(other)
    local overlappingSprites = self.sprite:overlappingSprites()
    if (overlappingSprites == {}) then return
        false
    end

    local isInOverlappingSpriteList = lists.find(overlappingSprites, function(overlappingSprite)
        return overlappingSprite == other.sprite
    end) ~= nil

    return isInOverlappingSpriteList
end

function Luggage:hasHit(other)
    print("Collision detected")
    self:endPlayerControl()
end

function Luggage:endPlayerControl(moveTo)
    if (moveTo) then
        self.position.y = moveTo
    end
    self.sprite:setZIndex(-2)
    self.isPlayerControlDone = true
    self.isDropping = false
end

import "Luggage_Test"