local playdateGraphicsMock

local backgroundImageMock
local beltImageMock

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Background(playdateGraphicsMock)
    backgroundImageMock = playdateGraphicsMock.sprite.generatedMocks()[1]
    beltImageMock = playdateGraphicsMock.sprite.generatedMocks()[2]
end

TestBackgroundClass = {
    testShouldInit = function()
        createTarget()

        luaunit.assertEquals(backgroundImageMock.moveToWasCalledWith[1], {
            x = 200,
            y = 120
        })
        luaunit.assertEquals(backgroundImageMock.setZIndexWasCalledWith[1], {zIndex = -1})
        luaunit.assertEquals(backgroundImageMock.addWasCalled, true)
        luaunit.assertEquals(beltImageMock.moveToWasCalledWith[1], {
            x = 175,
            y = 182
        })
        luaunit.assertEquals(beltImageMock.setZIndexWasCalledWith[1], {zIndex = -2})
        luaunit.assertEquals(beltImageMock.addWasCalled, true)
        luaunit.assertNotIsNil(target.gears)
    end,
}