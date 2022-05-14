import "test-setup/UnitTest"

local expectedStartingX = 285
local expectedStartingY = 15

local playdateGraphicsMock
local spriteMock

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = LuggageQueueItem(playdateGraphicsMock)
    spriteMock = playdateGraphicsMock.sprite.generatedMock()
end

TestLuggageQueueItemClass = {
    testShouldInit = function()
        createTarget()

        luaunit.assertEquals(target.speed, expectedStartingSpeed)
        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(spriteMock.moveToCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.setScaleCalledWith[1], {
            scale = 0.5
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
    end
}