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
local imageMocks
function PlaydateGraphicsImageBuilderMock.new(filePath)
    imageBuilderNewWasCalledWith = filePath
    local imageMock = PlaydateGraphicsImageMock()
    imageMocks = TestHelpers.addCapturedParams(imageMocks, imageMock)
    return imageMock
end
function PlaydateGraphicsImageBuilderMock.newCalledWith()
    return imageBuilderNewWasCalledWith
end
function PlaydateGraphicsImageBuilderMock.generatedMocks()
    return imageMocks
end

function buildPlaydateGraphicsImageMock()
    imageBuilderNewWasCalledWith = nil
    imageMocks = nil

    return PlaydateGraphicsImageBuilderMock
end