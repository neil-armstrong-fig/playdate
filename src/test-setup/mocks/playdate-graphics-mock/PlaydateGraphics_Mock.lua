import "mocks/PlaydateGraphicsImage_Mock"
import "mocks/PlaydateGraphicsSprite_Mock"
import "test-setup/mocks/helpers/TestHelpers"

PlaydateGraphicsMock = {}

local drawTextWasCalledWith
function PlaydateGraphicsMock.drawText(text, x, y)
    local params = {
        text = text,
        x = x,
        y = y
    }
    drawTextWasCalledWith = TestHelpers.addCapturedParams(drawTextWasCalledWith, params)
end
function PlaydateGraphicsMock.drawTextCalledWith()
    return drawTextWasCalledWith
end

local setClipRectCalledWith
function PlaydateGraphicsMock.setClipRect(x, y, width, height)
    local params = {
        x = x,
        y = y,
        width = width,
        height = height
    }
    setClipRectCalledWith = TestHelpers.addCapturedParams(setClipRectCalledWith, params)
end
function PlaydateGraphicsMock.setClipRectCalledWith()
    return setClipRectCalledWith
end

local clearClipRectCalled
function PlaydateGraphicsMock.clearClipRect()
    clearClipRectCalled = true
end
function PlaydateGraphicsMock.clearClipRectCalled()
    return clearClipRectCalled
end

-- Always build the mock to ensure state is reset!
function buildPlaydateGraphicsMock()
    PlaydateGraphicsMock.sprite = buildPlaydateGraphicsSpriteMock()
    PlaydateGraphicsMock.image = buildPlaydateGraphicsImageMock()

    drawTextWasCalledWith = nil
    setClipRectCalledWith = nil
    clearClipRectCalled = false

    return PlaydateGraphicsMock
end