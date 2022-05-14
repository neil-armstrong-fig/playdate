class("Player").extends()

function Player:init(config)
    self.playdate = playdate
    self.rotation = 0
    self.speed = 5
    self.bottomOfBeltPosition = 200

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

function Player:update(luggage)
    if (self:_isNewLuggage(luggage)) then
        self:_startControllingNewLuggage(luggage)
    end

    self:_updateRotation()

    if (self:_shouldDrop()) then
        self:_handleDrop()
    end
end

function Player:_isNewLuggage(luggage)
    return self.luggage ~= luggage
end

function Player:_startControllingNewLuggage(luggage)
    self.luggage = luggage
    self.luggage:startPlayerControl()
    self.luggage.position = {
        x = 200,
        y = 60
    }
end

function Player:_updateRotation()
    local originalRotation = self.luggage.rotation

    local crankChange = self.playdate.getCrankChange()
    if (crankChange == 0.0) then
        return
    end

    self.luggage.rotation = originalRotation + crankChange
end

function Player:_shouldDrop()
    return self.isDropping or self.playdate.buttonIsPressed(playdate.kButtonA)
end

function Player:_handleDrop()
    self.isDropping = true
    self.luggage.position.y = self.luggage.position.y + self.speed

    if (self.luggage.position.y >= self.bottomOfBeltPosition) then
        self.luggage.position.y = self.bottomOfBeltPosition
        self.luggage:endPlayerControl()
        self.isDropping = false
    end
end

import "Player_Test"