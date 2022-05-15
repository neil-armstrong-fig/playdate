local expectedStartingX = 285
local expectedStartingY = 15

local playdateGraphicsMock
local spriteMock

local target

local function createTarget(luggageType)
    if (luggageType == nil) then
        luggageType = 1
    end

    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Luggage(
            playdateGraphicsMock,
            {
                x = expectedStartingX,
                y = expectedStartingY
            },
            luggageType
    )
    spriteMock = playdateGraphicsMock.sprite.generatedMocks()[1]
end

TestLuggageClass = {
    testShouldInit = function()
        createTarget()

        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(spriteMock.moveToWasCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.setScaleWasCalledWith[1], {
            scale = 0.5
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
        luaunit.assertEquals(target.luggageType, LuggageTypes[1])
    end,
    testShouldInitLuggageType2 = function()
        createTarget(2)

        luaunit.assertEquals(target.luggageType, LuggageTypes[2])
    end,
    testShouldInitLuggageType3 = function()
        createTarget(3)

        luaunit.assertEquals(target.luggageType, LuggageTypes[3])
    end,
    testShouldInitLuggageType4 = function()
        createTarget(4)

        luaunit.assertEquals(target.luggageType, LuggageTypes[4])
    end,
    testShouldFailForUnknownLuggageType = function()
        luaunit.assertError(createTarget, -1)
        luaunit.assertError(createTarget, LuggageTypes.size + 1)
    end,
}

TestLuggageClass_PlayerControl = {
    testShouldSetScaleWhenPlayerControlStarts = function()
        createTarget()

        target:startPlayerControl()

        luaunit.assertEquals(spriteMock.setScaleWasCalledWith[2], {
            scale = 1
        })
    end,
    testShouldConfigureLuggageForBeltWhenPlayerControlEnds = function()
        createTarget()

        target:endPlayerControl(300)

        luaunit.assertEquals(target.position.y, 300)
        luaunit.assertEquals(spriteMock.setZIndexWasCalledWith[1], {
            zIndex = -2
        })
        luaunit.assertEquals(target.isPlayerControlDone, true)
        luaunit.assertEquals(target.isDropping, false)
    end,
}

TestLuggageClass_Dropping = {
    testShouldDropLuggage = function()
        createTarget()

        target:dropBy(10)

        luaunit.assertEquals(target.isDropping, true)
        luaunit.assertEquals(target.position.y, expectedStartingY + 10)
    end,
}

TestLuggageClass_LogicLoop = {
    testShouldNotUpdateSpriteIfNoChange = function()
        createTarget()

        target:update()

        luaunit.assertIsNil(spriteMock.moveToWasCalledWith[2])
        luaunit.assertIsNil(spriteMock.setRotationWasCalledWith)
    end,
    testShouldUpdateSpritePositionWhenChanged = function()
        createTarget()
        target.position = {
            x = 10,
            y = 20
        }

        target:update()

        luaunit.assertEquals(spriteMock.moveToWasCalledWith[2], {
            x = 10,
            y = 20
        })
    end,
    testShouldUpdateSpriteRotationWhenChanged = function()
        createTarget()
        target.rotation = 30

        target:update()

        luaunit.assertEquals(spriteMock.setRotationWasCalledWith[1], {
            rotation = 30
        })
    end,
}
