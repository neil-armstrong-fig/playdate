class("PlaydateGraphicsImageMock").extends()

function PlaydateGraphicsImageMock:init()
    self.drawWasCalledWith = nil
end

function PlaydateGraphicsImageMock:draw(x, y)
    if (self.drawWasCalledWith == nil) then
        self.drawWasCalledWith = {
            {x = x, y = y}
        }
    else
        table.insert(self.drawWasCalledWith, {x = x, y = y})
    end
end

local PlaydateGraphicsImageBuilderMock = {}

local imageBuilderNewWasCalledWith
local imageMock
function PlaydateGraphicsImageBuilderMock.new(filePath)
    imageBuilderNewWasCalledWith = filePath
    imageMock = PlaydateGraphicsImageMock()
    return imageMock
end
function PlaydateGraphicsImageBuilderMock.newCalledWith()
    return imageBuilderNewWasCalledWith
end
function PlaydateGraphicsImageBuilderMock.generatedMock()
    return imageMock
end

function buildPlaydateGraphicsImageMock()
    imageBuilderNewWasCalledWith = nil
    imageMock = nil

    return PlaydateGraphicsImageBuilderMock
end