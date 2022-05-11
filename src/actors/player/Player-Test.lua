import "./test-setup/UnitTest"

local expectedStartingSpeed = 5
local expectedStartingX = 200
local expectedStartingY = 120

local acceleratedSpeed = 20

local playdateGraphicsMock
local playdateMock
local spriteMock

local target

local function createTarget(config)
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    playdateMock = buildPlaydateMock()
    target = Player(playdateGraphicsMock, table.merge(config, {
        playdateMock = playdateMock
    }))
    spriteMock = playdateGraphicsMock.sprite.generatedMock()
end

TestPlayerClass_Init = {
    testShouldInitPlayer = function()
        createTarget()

        luaunit.assertEquals(target.speed, expectedStartingSpeed)
        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(spriteMock.wasMovedTo[1], {
            x = 200,
            y = 120
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
    end,
}

TestPlayerClass_LogicLoopUp = {
    testShouldMovePlayerUpWhenUpButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonUp)
        target:logicLoop()

        local expectedX = expectedStartingX
        local expectedY = expectedStartingY - expectedStartingSpeed
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 200,
            y = 115
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
    testShouldMovePlayerUpAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonUp)
        target:logicLoop()

        local expectedX = expectedStartingX
        local expectedY = expectedStartingY - acceleratedSpeed
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 200,
            y = 100
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
}

TestPlayerClass_LogicLoopDown = {
    testShouldMovePlayerDownWhenDownButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonDown)
        target:logicLoop()

        local expectedX = expectedStartingX
        local expectedY = expectedStartingY + expectedStartingSpeed
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 200,
            y = 125
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
    testShouldMovePlayerDownAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonDown)
        target:logicLoop()

        local expectedX = expectedStartingX
        local expectedY = expectedStartingY + acceleratedSpeed
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 200,
            y = 140
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
}

TestPlayerClass_LogicLoopRight = {
    testShouldMovePlayerToTheRightWhenRightButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonRight)
        target:logicLoop()

        local expectedX = expectedStartingX + expectedStartingSpeed
        local expectedY = expectedStartingY
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 205,
            y = 120
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
    testShouldMovePlayerToTheRightAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonRight)
        target:logicLoop()

        local expectedX = expectedStartingX + acceleratedSpeed
        local expectedY = expectedStartingY
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 220,
            y = 120
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
}

TestPlayerClass_LogicLoopLeft = {
    testShouldMovePlayerToTheLeftWhenLeftButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonLeft)
        target:logicLoop()

        local expectedX = expectedStartingX - expectedStartingSpeed
        local expectedY = expectedStartingY
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 195,
            y = 120
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
    testShouldMovePlayerToTheLeftAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonLeft)
        target:logicLoop()

        local expectedX = expectedStartingX - acceleratedSpeed
        local expectedY = expectedStartingY
        luaunit.assertEquals(spriteMock.wasMovedTo[2], {
            x = 180,
            y = 120
        })
        luaunit.assertEquals(target.position.x, expectedX)
        luaunit.assertEquals(target.position.y, expectedY)
    end,
}

TestPlayerClass_Cleanup = {
    testShouldCleanUpSprite = function()
        createTarget()

        target:cleanup()

        luaunit.assertEquals(spriteMock.removeWasCalled, true)
    end,
}
