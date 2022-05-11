import "mocks/PlaydateGraphicsImage-Mock"
import "mocks/PlaydateGraphicsSprite-Mock"

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

local setClipRectCalledWith
function PlaydateGraphicsMock.setClipRect(x, y, width, height)
    if (setClipRectCalledWith == nil) then
        setClipRectCalledWith = {
            {
                x = x,
                y = y,
                width = width,
                height = height
            }
        }
    else
        table.insert(setClipRectCalledWith, {
            x = x,
            y = y,
            width = width,
            height = height
        })
    end
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