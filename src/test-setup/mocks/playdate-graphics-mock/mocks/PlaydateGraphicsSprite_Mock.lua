import "test-setup/mocks/helpers/TestHelpers"

class("PlaydateGraphicsSpriteMock").extends()

function PlaydateGraphicsSpriteMock:init()
    self.rotation = 0

    self.simulatedOverlappingSprites = {}
    self.simulatedSize = 32

    self.moveToWasCalledWith = nil
    self.setRotationWasCalledWith = nil
    self.setScaleWasCalledWith = nil
    self.setZIndexWasCalledWith = nil
    self.setCollideRectWasCalledWith = nil
    self.addWasCalled = false
    self.removeWasCalled = false
end

function PlaydateGraphicsSpriteMock:moveTo(x, y)
    local params = {x = x, y = y}
    self.moveToWasCalledWith = TestHelpers.addCapturedParams(self.moveToWasCalledWith, params)

    self.x = x
    self.y = y
end

function PlaydateGraphicsSpriteMock:setRotation(rotation)
    local params = {rotation = rotation}
    self.setRotationWasCalledWith = TestHelpers.addCapturedParams(self.setRotationWasCalledWith, params)

    self.rotation = rotation
end

function PlaydateGraphicsSpriteMock:setScale(scale)
    local params = {scale = scale}
    self.setScaleWasCalledWith = TestHelpers.addCapturedParams(self.setScaleWasCalledWith, params)

    self.scale = scale
end

function PlaydateGraphicsSpriteMock:setZIndex(zIndex)
    local params = {zIndex = zIndex}
    self.setZIndexWasCalledWith = TestHelpers.addCapturedParams(self.setZIndexWasCalledWith, params)

    self.scale = scale
end

function PlaydateGraphicsSpriteMock:simulateOverlappingSprites(sprite)
    self.simulatedOverlappingSprites = {sprite}
end
function PlaydateGraphicsSpriteMock:overlappingSprites()
    return self.simulatedOverlappingSprites
end

function PlaydateGraphicsSpriteMock:simulateGetSize(simulatedSize)
   self.simulatedSize =  simulatedSize
end
function PlaydateGraphicsSpriteMock:getSize()
    return self.simulatedSize
end

function PlaydateGraphicsSpriteMock:setCollideRect(x, y, size)
    local params = {x = x, y = y, size = size}
    self.setCollideRectWasCalledWith = TestHelpers.addCapturedParams(self.setCollideRectWasCalledWith, params)
end

function PlaydateGraphicsSpriteMock:add()
    self.addWasCalled = true
end

function PlaydateGraphicsSpriteMock:remove()
    self.removeWasCalled = true
end

local PlaydateGraphicsSpriteBuilderMock = {}

local spriteBuilderNewWasCalledWith
local spriteMocks
function PlaydateGraphicsSpriteBuilderMock.new(image)
    spriteBuilderNewWasCalledWith = image
    local spriteMock = PlaydateGraphicsSpriteMock()
    spriteMocks = TestHelpers.addCapturedParams(spriteMocks, spriteMock)
    return spriteMock
end
function PlaydateGraphicsSpriteBuilderMock.newCalledWith()
    return spriteBuilderNewWasCalledWith
end
function PlaydateGraphicsSpriteBuilderMock.generatedMocks()
    return spriteMocks
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
    spriteMocks = nil

    spriteSetBackgroundDrawingCallbackCalledWith = nil
    updateWasCalled = nil

    return PlaydateGraphicsSpriteBuilderMock
end