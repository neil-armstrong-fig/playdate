import "images/ImageLoading"

local function createImage(graphics, startingPosition)
    local sprite = graphics.sprite.new(ImageLoading.loadPlayerImage(graphics))
    sprite:moveTo(startingPosition.x, startingPosition.y)
    sprite:add()

    return sprite
end

class("Player").extends()

function Player:init(graphics, config)
    self.playdate = playdate
    self.position = {
        x = 200,
        y = 60
    }
    self.rotation = 0

    self.sprite = createImage(graphics, self.position)
    self.speed = 5

    if (config == nil) then
        return
    end
    if (config.speed) then
        self.speed = config.speed
    end
    if (config.playdateMock) then
        self.playdate = config.playdateMock
    end
end

local function updateRotation(originalRotation)
    return originalRotation + 1
end

local function updatePosition(playdate, originalPosition, speed)
    local x = originalPosition.x
    local y = originalPosition.y

    if playdate.buttonIsPressed(playdate.kButtonUp) then
        y = y - speed
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        y = y + speed
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        x = x - speed
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        x = x + speed
    end

    if (x ~= originalPosition.x or y ~= originalPosition.y) then
        return {x = x, y = y}
    else
        return originalPosition
    end
end

function Player:logicLoop()
    self.rotation = updateRotation(self.rotation)
    self.sprite:setRotation(self.rotation)

    self.position = updatePosition(self.playdate, self.position, self.speed)
    if (self.sprite.x ~= self.position.x or self.sprite.y ~= self.position.y) then
        self.sprite:moveTo(self.position.x, self.position.y)
    end
end

function Player:cleanup()
    self.sprite:remove()
end

import "Player-Test"