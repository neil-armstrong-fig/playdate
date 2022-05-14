class("PlaydateGraphicsSpriteMock").extends()

function PlaydateGraphicsSpriteMock:init()
    self.moveToCalledWith = nil
    self.setRotationCalledWith = nil
    self.addWasCalled = false
    self.removeWasCalled = false
end

function PlaydateGraphicsSpriteMock:moveTo(x, y)
    if (self.moveToCalledWith == nil) then
        self.moveToCalledWith = {
            {x = x, y = y}
        }
    else
        table.insert(self.moveToCalledWith, {x = x, y = y})
    end

    self.x = x
    self.y = y
end

function PlaydateGraphicsSpriteMock:setRotation(rotation)
    if (self.setRotationCalledWith == nil) then
        self.setRotationCalledWith = {
            {rotation = rotation}
        }
    else
        table.insert(self.setRotationCalledWith, {x = x, y = y})
    end
end

function PlaydateGraphicsSpriteMock:add()
    self.addWasCalled = true
end

function PlaydateGraphicsSpriteMock:remove()
    self.removeWasCalled = true
end

local PlaydateGraphicsSpriteBuilderMock = {}

local spriteBuilderNewWasCalledWith
local spriteMock
function PlaydateGraphicsSpriteBuilderMock.new(image)
    spriteBuilderNewWasCalledWith = image
    spriteMock = PlaydateGraphicsSpriteMock()
    return spriteMock
end
function PlaydateGraphicsSpriteBuilderMock.newCalledWith()
    return spriteBuilderNewWasCalledWith
end
function PlaydateGraphicsSpriteBuilderMock.generatedMock()
    return spriteMock
end

local spriteSetBackgroundDrawingCallbackCalledWith
function PlaydateGraphicsSpriteBuilderMock.setBackgroundDrawingCallback(callback)
    spriteSetBackgroundDrawingCallbackCalledWith = callback
end
function PlaydateGraphicsSpriteBuilderMock.setBackgroundDrawingCallbackCalledWith()
    return spriteSetBackgroundDrawingCallbackCalledWith
end

local updateWasCalled
function PlaydateGraphicsSpriteBuilderMock.update()
    updateWasCalled = true
end
function PlaydateGraphicsSpriteBuilderMock.updateWasCalled()
    return updateWasCalled
end

function buildPlaydateGraphicsSpriteMock()
    spriteBuilderNewWasCalledWith = nil
    spriteMock = nil

    spriteSetBackgroundDrawingCallbackCalledWith = nil
    updateWasCalled = nil

    return PlaydateGraphicsSpriteBuilderMock
end