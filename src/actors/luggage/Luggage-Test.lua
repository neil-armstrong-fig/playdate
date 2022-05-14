import "test-setup/UnitTest"

local expectedStartingX = 285
local expectedStartingY = 15

local playdateGraphicsMock
local spriteMock

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Luggage(playdateGraphicsMock, {
        x = expectedStartingX,
        y = expectedStartingY
    })
    spriteMock = playdateGraphicsMock.sprite.generatedMock()
end

TestLuggageQueueItemClass = {
    testShouldInit = function()
        createTarget()

        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(spriteMock.moveToCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.setScaleCalledWith[1], {
            scale = 0.5
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
    end,
}

TestLuggageQueueItemClass_PlayerControl = {
    testShouldSetScaleWhenPlayerControlStarts = function()
        createTarget()

        target:startPlayerControl()

        luaunit.assertEquals(spriteMock.setScaleCalledWith[2], {
            scale = 1
        })
    end,
    testShouldFlagWhenPlayerControlEnds = function()
        createTarget()

        target:endPlayerControl()

        luaunit.assertEquals(target.isPlayerControlDone, true)
    end,
}

TestLuggageQueueItemClass_LogicLoop = {
    testShouldNotUpdateSpriteIfNoChange = function()
        createTarget()

        target:logicLoop()

        luaunit.assertIsNil(spriteMock.moveToCalledWith[2])
        luaunit.assertIsNil(spriteMock.setRotationCalledWith)
    end,
    testShouldUpdateSpritePositionWhenChanged = function()
        createTarget()

        target.position = {
           x = 10,
           y = 20
        }
        target:logicLoop()

        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = 10,
            y = 20
        })
    end,
    testShouldUpdateSpriteRotationWhenChanged = function()
        createTarget()

        target.rotation = 30
        target:logicLoop()

        luaunit.assertEquals(spriteMock.setRotationCalledWith[1], {
            rotation = 30
        })
    end,
}
