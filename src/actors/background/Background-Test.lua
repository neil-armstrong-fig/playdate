import "./test-setup/UnitTest"

local playdateGraphicsMock
local playdateMock
local imageMock

local target

local function createTarget(config)
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Background(playdateGraphicsMock, table.merge(config, {
        playdateMock = playdateMock
    }))
    imageMock = playdateGraphicsMock.image.generatedMock()
end

TestBackgroundClass = {
    testShouldSetupBackgroundImage = function()
        createTarget()

        luaunit.assertNotIsNil(playdateGraphicsMock.sprite.setBackgroundDrawingCallbackCalledWith())
        playdateGraphicsMock.sprite.setBackgroundDrawingCallbackCalledWith()(10, 20, 30, 40)

        luaunit.assertEquals(playdateGraphicsMock.setClipRectCalledWith()[1], {
            x = 10,
            y = 20,
            width = 30,
            height = 40
        })
        luaunit.assertEquals(imageMock.drawWasCalledWith[1], {x = 0, y = 0})
        luaunit.assertEquals(playdateGraphicsMock.clearClipRectCalled(), true)
    end,
}

UnitTest.runTests()