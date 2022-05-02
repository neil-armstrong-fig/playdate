import "UnitTest"

local expectedStartingSpeed = 5
local expectedStartingX = 200
local expectedStartingY = 120

local acceleratedSpeed = 20

TestMyStuff = {}

-- Init
function TestMyStuff:testInit()
    local playdateMock = buildPlaydateMock()

    local player = Player({playdateMock = playdateMock})

    luaunit.assertEquals(player.speed, expectedStartingSpeed)
    luaunit.assertEquals(player.sprite.height, 84)
    luaunit.assertEquals(player.sprite.width, 92)
    luaunit.assertEquals(player.sprite.x, expectedStartingX)
    luaunit.assertEquals(player.sprite.y, expectedStartingY)
end

-- Up
function TestMyStuff:testUpButtonPressed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock})

    playdateMock.simulateButtonPress(playdate.kButtonUp)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX)
    luaunit.assertEquals(player.sprite.y, expectedStartingY - expectedStartingSpeed)
end

function TestMyStuff:testUpButtonPressedAtAcceleratedSpeed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock, speed = acceleratedSpeed})

    playdateMock.simulateButtonPress(playdate.kButtonUp)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX)
    luaunit.assertEquals(player.sprite.y, expectedStartingY - acceleratedSpeed)
end

-- Down
function TestMyStuff:testDownButtonPressed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock})

    playdateMock.simulateButtonPress(playdate.kButtonDown)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX)
    luaunit.assertEquals(player.sprite.y, expectedStartingY + expectedStartingSpeed)
end

function TestMyStuff:testDownButtonPressedAtAcceleratedSpeed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock, speed = acceleratedSpeed})

    playdateMock.simulateButtonPress(playdate.kButtonDown)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX)
    luaunit.assertEquals(player.sprite.y, expectedStartingY + acceleratedSpeed)
end

-- Right
function TestMyStuff:testRightButtonPressed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock})

    playdateMock.simulateButtonPress(playdate.kButtonRight)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX + expectedStartingSpeed)
    luaunit.assertEquals(player.sprite.y, expectedStartingY)
end

function TestMyStuff:testRightButtonPressedAtAcceleratedSpeed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock, speed = acceleratedSpeed})

    playdateMock.simulateButtonPress(playdate.kButtonRight)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX + acceleratedSpeed)
    luaunit.assertEquals(player.sprite.y, expectedStartingY)
end

-- Left
function TestMyStuff:testLeftButtonPressed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock})

    playdateMock.simulateButtonPress(playdate.kButtonLeft)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX - expectedStartingSpeed)
    luaunit.assertEquals(player.sprite.y, expectedStartingY)
end

function TestMyStuff:testLeftButtonPressedAtAcceleratedSpeed()
    local playdateMock = buildPlaydateMock()
    local player = Player({playdateMock = playdateMock, speed = acceleratedSpeed})

    playdateMock.simulateButtonPress(playdate.kButtonLeft)
    player.logicLoop(player)

    luaunit.assertEquals(player.sprite.x, expectedStartingX - acceleratedSpeed)
    luaunit.assertEquals(player.sprite.y, expectedStartingY)
end

UnitTest.runTests()