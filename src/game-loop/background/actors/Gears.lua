import "images/ImageLoading"

class("Gears").extends()

function Gears:init(graphics, config)
    local gearImage = ImageLoading.loadGearImage(graphics)

    self.firstSmallGear = graphics.sprite.new(gearImage)
    self.firstSmallGear:moveTo(377, 225)
    self.firstSmallGear:setScale(0.5)
    self.firstSmallGear.rotation = 0
    self.firstSmallGear:add()

    self.secondSmallGear = graphics.sprite.new(gearImage)
    self.secondSmallGear:moveTo(377, 103)
    self.secondSmallGear:setScale(0.5)
    self.secondSmallGear.rotation = 0
    self.secondSmallGear:add()

    self.bigGear = graphics.sprite.new(gearImage)
    self.bigGear:moveTo(245, 105)
    self.bigGear.rotation = 0
    self.bigGear:add()

    self.playdate = playdate
    if (config == nil) then
        return
    end
    if (config.playdateMock) then
        self.playdate = config.playdateMock
    end
end

function Gears:update()
    local crankChange = self.playdate.getCrankChange()
    if (crankChange ~= 0) then
        printTable(self.firstSmallGear)
        self:_updateRotation(self.firstSmallGear, crankChange)
        self:_updateRotation(self.secondSmallGear, -crankChange)
        self:_updateRotation(self.bigGear, crankChange)
    end
end

function Gears:_updateRotation(gearSprite, crankChange)
    local newRotation = gearSprite.rotation + crankChange
    gearSprite.rotation = newRotation
    gearSprite:setRotation(gearSprite.rotation)
end

import "Gears_Test"