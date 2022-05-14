import "./images/ImageLoading"

local function createPlayerImage(graphics, startingPosition)
    -- Set up the player sprite.
    -- The :setCenter() call specifies that the sprite will be anchored at its center.
    -- The :moveTo() call moves our sprite to the center of the display.
    local playerSprite = graphics.sprite.new(ImageLoading.loadPlayerImage(graphics))
    playerSprite:moveTo(startingPosition.x, startingPosition.y) -- this is where the center of the sprite is placed;
    playerSprite:add() -- This is critical!

    return playerSprite
end

class("Player").extends()

function Player:init(graphics, config)
    self.playdate = playdate
    self.position = {
        x = 200,
        y = 120
    }
    self.rotation = 0

    self.sprite = createPlayerImage(graphics, self.position)
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

local function updatePlayerPosition(playdate, originalPosition, speed)
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

local function updateRotation(originalRotation)
    return originalRotation + 1
end

function Player:logicLoop()
    self.rotation = updateRotation(self.rotation)
    self.sprite:setRotation(self.rotation)

    self.position = updatePlayerPosition(self.playdate, self.position, self.speed)
    if (self.sprite.x ~= self.position.x or self.sprite.y ~= self.position.y) then
        self.sprite:moveTo(self.position.x, self.position.y)
    end
end

function Player:cleanup()
    self.sprite:remove()
end

import "Player-Test"