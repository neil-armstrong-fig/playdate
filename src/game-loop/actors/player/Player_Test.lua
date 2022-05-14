local expectedStartingSpeed = 5
local expectedStartingX = 200
local expectedStartingY = 60
local expectedStartingRotation = 0

local luggage

local playdateGraphicsMock
local playdateMock
local spriteMock

local target

local function createTarget(config)
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    playdateMock = buildPlaydateMock()
    target = Player(table.merge(config, {
        playdateMock = playdateMock
    }))
    luggage = Luggage_Builder.buildTestLuggage(playdateGraphicsMock)
    spriteMock = playdateGraphicsMock.sprite.generatedMocks()[1]
end

TestPlayerClass_Init = {
    testShouldInit = function()
        createTarget()

        luaunit.assertEquals(target.speed, expectedStartingSpeed)
        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
    end,
}

TestPlayerClass_UpdateNoInteraction = {
    testShouldNotChangeStartingState = function()
        createTarget()

        target:update(luggage)

        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(luggage.rotation, expectedStartingRotation)
    end,
}

TestPlayerClass_Luggage = {
    testShouldChangeLuggage = function()
        createTarget()
        local differentLuggage = Luggage_Builder.buildTestLuggage(playdateGraphicsMock)

        target:update(luggage)
        target:update(differentLuggage)

        luaunit.assertEquals(target.luggage, differentLuggage)
    end,
}

TestPlayerClass_UpdateCrank = {
    testShouldRotateWhenCrankedForwards = function()
        createTarget()

        playdateMock.simulateCrankChange(0.3)
        target:update(luggage)

        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(luggage.rotation, expectedStartingRotation + 0.3)
    end,
    testShouldRotateWhenCrankedBackwards = function()
        createTarget()

        playdateMock.simulateCrankChange(-4)
        target:update(luggage)

        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(luggage.rotation, expectedStartingRotation - 4)
    end,
}

TestPlayerClass_UpdateDropping = {
    testShouldMovePlayerWhenAButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonA)
        target:update(luggage)

        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = expectedStartingY + expectedStartingSpeed
        })
        luaunit.assertEquals(luggage.rotation, 0)
        luaunit.assertEquals(target.isDropping, true)
    end,
    testShouldMovePlayerToBottomIfGoneTooFar = function()
        createTarget({
            speed = 500
        })

        playdateMock.simulateButtonPress(playdate.kButtonA)
        target:update(luggage)

        luaunit.assertEquals(luggage.position, {
            x = expectedStartingX,
            y = target.bottomOfBeltPosition
        })
        luaunit.assertEquals(luggage.rotation, 0)
        luaunit.assertEquals(luggage.isPlayerControlDone, true)
        luaunit.assertEquals(target.isDropping, false)
    end,
}
