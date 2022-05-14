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
    self.speed = 5
    self.bottomOfBeltPosition = 200

    self.sprite = createImage(graphics, self.position)

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

local function updateRotation(playdate, originalRotation)
    local crankChange = playdate.getCrankChange()
    if (crankChange == 0.0) then
        return originalRotation
    end

    return originalRotation + crankChange
end

local function handleMovementKeys(playdate, originalPosition, speed)
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

local function pressedDropButton(playdate)
    return playdate.buttonIsPressed(playdate.kButtonA)
end

local function calculateDropLuggageTick(currentPosition, speed, bottomOfBeltPosition)
    if (currentPosition.y == bottomOfBeltPosition) then
        return currentPosition
    end

    local newY = currentPosition.y + speed

    if (newY > bottomOfBeltPosition) then
        return {
            x = currentPosition.x,
            y = bottomOfBeltPosition
        }
    end

    return {
        x = currentPosition.x,
        y = newY
    }
end

local function updateSpriteRotation(sprite, newRotation)
    if (sprite.rotation ~= newRotation) then
        sprite:setRotation(newRotation)
    end
end

local function updateSpritePosition(sprite, newPosition)
    if (sprite.x ~= newPosition.x or sprite.y ~= newPosition.y) then
        sprite:moveTo(newPosition.x, newPosition.y)
    end
end

function Player:logicLoop()
    self.rotation = updateRotation(self.playdate, self.rotation)

    if (self.isDropping or pressedDropButton(self.playdate)) then
        self.isDropping = true
        self.position = calculateDropLuggageTick(self.position, self.speed, self.bottomOfBeltPosition)
    end

    self.position = handleMovementKeys(self.playdate, self.position, self.speed)

    updateSpriteRotation(self.sprite, self.rotation)
    updateSpritePosition(self.sprite, self.position)
end

function Player:cleanup()
    self.sprite:remove()
end

import "Player-Test"