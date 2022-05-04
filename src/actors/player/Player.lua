import "./images/ImageLoading"

local function createPlayerImage(graphics, startingPosition)
    -- Set up the player sprite.
    -- The :setCenter() call specifies that the sprite will be anchored at its center.
    -- The :moveTo() call moves our sprite to the center of the display.
    local playerSprite = graphics.sprite.new(ImageLoading.loadPlayerImage())
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

    self.sprite = createPlayerImage(graphics, self.position)
    self.speed = 5

    if (config == null) then
        return
    end
    if (config.speed) then
        self.speed = config.speed
    end
    if (config.playdateMock) then
        self.playdate = config.playdateMock
    end
end

function Player:logicLoop()
    if self.playdate.buttonIsPressed(playdate.kButtonUp) then
        self.position.y = self.position.y - self.speed
    end
    if self.playdate.buttonIsPressed(playdate.kButtonDown) then
        self.position.y = self.position.y + self.speed
    end

    if self.playdate.buttonIsPressed(playdate.kButtonLeft) then
        self.position.x = self.position.x - self.speed
    end
    if self.playdate.buttonIsPressed(playdate.kButtonRight) then
        self.position.x = self.position.x + self.speed
    end

    self.sprite:moveTo(self.position.x, self.position.y)
end

function Player:cleanup()
    self.sprite:remove()
end

import "Player-Test"