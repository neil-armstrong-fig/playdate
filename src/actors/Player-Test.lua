import "./test-setup/UnitTest"

local expectedStartingSpeed = 5
local expectedStartingX = 200
local expectedStartingY = 120

local acceleratedSpeed = 20

local playdateMock
local target

local function cleanup()
    if (target ~= nil) then
        target:cleanup()
    end
end

local function createTarget(config)
    cleanup()

    playdateMock = buildPlaydateMock()
    target = Player(table.merge(config, {
        playdateMock = playdateMock
    }))
end

TestPlayerClass_Init = {
    -- Init
    testShouldInitPlayer = function()
        createTarget()

        luaunit.assertEquals(target.speed, expectedStartingSpeed)
        luaunit.assertEquals(target.sprite.height, 84)
        luaunit.assertEquals(target.sprite.width, 92)
        luaunit.assertEquals(target.sprite.x, expectedStartingX)
        luaunit.assertEquals(target.sprite.y, expectedStartingY)
    end,
}

TestPlayerClass_LogicLoopUp = {
    testShouldMovePlayerUpWhenUpButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonUp)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX)
        luaunit.assertEquals(target.sprite.y, expectedStartingY - expectedStartingSpeed)
    end,
    testShouldMovePlayerUpAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonUp)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX)
        luaunit.assertEquals(target.sprite.y, expectedStartingY - acceleratedSpeed)
    end,
}

TestPlayerClass_LogicLoopDown = {
    testShouldMovePlayerDownWhenDownButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonDown)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX)
        luaunit.assertEquals(target.sprite.y, expectedStartingY + expectedStartingSpeed)
    end,
    testShouldMovePlayerDownAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonDown)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX)
        luaunit.assertEquals(target.sprite.y, expectedStartingY + acceleratedSpeed)
    end,
}

TestPlayerClass_LogicLoopRight = {
    testShouldMovePlayerToTheRightWhenRightButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonRight)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX + expectedStartingSpeed)
        luaunit.assertEquals(target.sprite.y, expectedStartingY)
    end,
    testShouldMovePlayerToTheRightAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonRight)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX + acceleratedSpeed)
        luaunit.assertEquals(target.sprite.y, expectedStartingY)
    end,
}

TestPlayerClass_LogicLoopLeft = {
    testShouldMovePlayerToTheLeftWhenLeftButtonPressed = function()
        createTarget()

        playdateMock.simulateButtonPress(playdate.kButtonLeft)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX - expectedStartingSpeed)
        luaunit.assertEquals(target.sprite.y, expectedStartingY)
    end,
    testShouldMovePlayerToTheLeftAtAcceleratedSpeed = function()
        createTarget({speed = acceleratedSpeed})

        playdateMock.simulateButtonPress(playdate.kButtonLeft)
        target:logicLoop()

        luaunit.assertEquals(target.sprite.x, expectedStartingX - acceleratedSpeed)
        luaunit.assertEquals(target.sprite.y, expectedStartingY)
        target:cleanup()
    end
}

UnitTest.runTests(cleanup)