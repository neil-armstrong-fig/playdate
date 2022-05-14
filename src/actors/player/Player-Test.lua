import "test-setup/UnitTest"

local expectedStartingSpeed = 5
local expectedStartingX = 200
local expectedStartingY = 60
local expectedStartingRotation = 0

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
    testShouldInit = function()
        createTarget()

        luaunit.assertEquals(target.speed, expectedStartingSpeed)
        luaunit.assertNotIsNil(spriteMock)
        luaunit.assertEquals(spriteMock.moveToCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.addWasCalled, true)
    end,
}

TestPlayerClass_LogicLoopNoInteraction = {
    testShouldNotChangeStartingState = function()
        createTarget()

        target:logicLoop()

        luaunit.assertIsNil(spriteMock.moveToCalledWith[2])
        luaunit.assertEquals(spriteMock.moveToCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.setRotationCalledWith[1], {
            rotation = expectedStartingRotation
        })
    end,
}

TestPlayerClass_LogicLoopCranked = {
    testShouldRotateWhenCranked = function()
        createTarget()

        playdateMock.simulateCrankChange(0.3)
        target:logicLoop()

        luaunit.assertIsNil(spriteMock.moveToCalledWith[2])
        luaunit.assertEquals(spriteMock.moveToCalledWith[1], {
            x = expectedStartingX,
            y = expectedStartingY
        })
        luaunit.assertEquals(spriteMock.setRotationCalledWith[1], {
            rotation = expectedStartingRotation + 0.3
        })
    end,
}

TestPlayerClass_LogicLoopDropping = {
    testShouldMovePlayerWhenAButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonA)
        target:logicLoop()

        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedStartingX,
            y = expectedStartingY + expectedStartingSpeed
        })
        luaunit.assertEquals(spriteMock.setRotationCalledWith[1], {
            rotation = 0
        })
    end,
    testShouldMovePlayerWhenAButtonPressed = function()
        createTarget({
            speed = 500
        })

        playdateMock.simulateButtonPress(playdate.kButtonA)
        target:logicLoop()

        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedStartingX,
            y = target.bottomOfBeltPosition
        })
        luaunit.assertEquals(spriteMock.setRotationCalledWith[1], {
            rotation = 0
        })
    end,
}

TestPlayerClass_LogicLoopUp = {
    testShouldMovePlayerUpWhenUpButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonUp)
        target:logicLoop()

        local expectedX = expectedStartingX
        local expectedY = expectedStartingY - expectedStartingSpeed
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
        luaunit.assertEquals(spriteMock.moveToCalledWith[2], {
            x = expectedX,
            y = expectedY
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
