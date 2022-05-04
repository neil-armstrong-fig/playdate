class("PlaydateGraphicsSpriteMock").extends()

function PlaydateGraphicsSpriteMock:init()
    self.wasMovedTo = nil
    self.addWasCalled = false
    self.removeWasCalled = false
end

function PlaydateGraphicsSpriteMock:moveTo(x, y)
    if (self.wasMovedTo == nil) then
        self.wasMovedTo = {
            {x = x, y = y}
        }
    else
        table.insert(self.wasMovedTo, {x = x, y = y})
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

PlaydateGraphicsMock = {}

local drawTextWasCalledWith
function PlaydateGraphicsMock.drawText(text, x, y)
    if (drawTextWasCalledWith == nil) then
        drawTextWasCalledWith = {
            {
                text = text,
                x = x,
                y = y
            }
        }
    else
        table.insert(drawTextWasCalledWith, {
            text = text,
            x = x,
            y = y
        })
    end
end
function PlaydateGraphicsMock.drawTextCalledWith()
    return drawTextWasCalledWith
end

PlaydateGraphicsMock.sprite = PlaydateGraphicsSpriteBuilderMock

-- Always build the mock to ensure state is reset!
function buildPlaydateGraphicsMock()
    spriteNewWasCalledWith = nil
    spriteMock = nil

    drawTextWasCalledWith = nil

    return PlaydateGraphicsMock
end