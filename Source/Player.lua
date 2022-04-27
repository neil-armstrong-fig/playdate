import "ImageLoading"

local graphics <const> = playdate.graphics

local function createPlayerImage()
    -- Set up the player sprite.
    -- The :setCenter() call specifies that the sprite will be anchored at its center.
    -- The :moveTo() call moves our sprite to the center of the display.
    local playerSprite = graphics.sprite.new(ImageLoading.loadPlayerImage())
    playerSprite:moveTo(200, 120) -- this is where the center of the sprite is placed; (200,120) is the center of the Playdate screen
    playerSprite:add() -- This is critical!

    return playerSprite
end

class("Player").extends()

function Player:init(config)
    self.sprite = createPlayerImage()
    self.speed = 5

    if (config == null) then
        return
    end

    if (config.speed) then
        self.speed = config.speed
    end
end

function Player:logicLoop()
    -- Poll the d-pad and move our player accordingly.
    -- (There are multiple ways to read the d-pad; this is the simplest.)
    -- Note that it is possible for more than one of these directions
    -- to be pressed at once, if the user is pressing diagonally.
    if playdate.buttonIsPressed(playdate.kButtonUp) then
        self.sprite:moveBy(0, -self.speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonRight) then
        self.sprite:moveBy(self.speed, 0)
    end
    if playdate.buttonIsPressed(playdate.kButtonDown) then
        self.sprite:moveBy(0, self.speed)
    end
    if playdate.buttonIsPressed(playdate.kButtonLeft) then
        self.sprite:moveBy(-self.speed, 0)
    end
end