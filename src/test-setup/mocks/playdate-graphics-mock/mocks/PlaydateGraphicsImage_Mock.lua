import "test-setup/mocks/helpers/TestHelpers"

class("PlaydateGraphicsImageMock").extends()

function PlaydateGraphicsImageMock:init()
    self.drawWasCalledWith = nil
end

function PlaydateGraphicsImageMock:draw(x, y)
    local params = {x = x, y = y}
    self.drawWasCalledWith = TestHelpers.addCapturedParams(self.drawWasCalledWith, params)
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