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

TestPlayerClass = {}

-- Init
function TestPlayerClass:testInit()
    createTarget()

    luaunit.assertEquals(target.speed, expectedStartingSpeed)
    luaunit.assertEquals(target.sprite.height, 84)
    luaunit.assertEquals(target.sprite.width, 92)
    luaunit.assertEquals(target.sprite.x, expectedStartingX)
    luaunit.assertEquals(target.sprite.y, expectedStartingY)
end

-- Up
function TestPlayerClass:testUpButtonPressed()
    createTarget()

    playdateMock.simulateButtonPress(playdate.kButtonUp)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX)
    luaunit.assertEquals(target.sprite.y, expectedStartingY - expectedStartingSpeed)
end

function TestPlayerClass:testUpButtonPressedAtAcceleratedSpeed()
    createTarget({ speed = acceleratedSpeed })

    playdateMock.simulateButtonPress(playdate.kButtonUp)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX)
    luaunit.assertEquals(target.sprite.y, expectedStartingY - acceleratedSpeed)
end

-- Down
function TestPlayerClass:testDownButtonPressed()
    createTarget()

    playdateMock.simulateButtonPress(playdate.kButtonDown)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX)
    luaunit.assertEquals(target.sprite.y, expectedStartingY + expectedStartingSpeed)
end

function TestPlayerClass:testDownButtonPressedAtAcceleratedSpeed()
    createTarget({ speed = acceleratedSpeed })

    playdateMock.simulateButtonPress(playdate.kButtonDown)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX)
    luaunit.assertEquals(target.sprite.y, expectedStartingY + acceleratedSpeed)
end

-- Right
function TestPlayerClass:testRightButtonPressed()
    createTarget()

    playdateMock.simulateButtonPress(playdate.kButtonRight)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX + expectedStartingSpeed)
    luaunit.assertEquals(target.sprite.y, expectedStartingY)
end

function TestPlayerClass:testRightButtonPressedAtAcceleratedSpeed()
    createTarget({ speed = acceleratedSpeed })

    playdateMock.simulateButtonPress(playdate.kButtonRight)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX + acceleratedSpeed)
    luaunit.assertEquals(target.sprite.y, expectedStartingY)
end

-- Left
function TestPlayerClass:testLeftButtonPressed()
    createTarget()

    playdateMock.simulateButtonPress(playdate.kButtonLeft)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX - expectedStartingSpeed)
    luaunit.assertEquals(target.sprite.y, expectedStartingY)
end

function TestPlayerClass:testLeftButtonPressedAtAcceleratedSpeed()
    createTarget({ speed = acceleratedSpeed })

    playdateMock.simulateButtonPress(playdate.kButtonLeft)
    target:logicLoop()

    luaunit.assertEquals(target.sprite.x, expectedStartingX - acceleratedSpeed)
    luaunit.assertEquals(target.sprite.y, expectedStartingY)
    target:cleanup()
end

UnitTest.runTests(cleanup)