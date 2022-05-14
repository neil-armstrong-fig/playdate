import "mocks/PlaydateTimer_Mock"

local PlaydateMock = {
    kButtonUp = playdate.kButtonUp,
    kButtonDown = playdate.kButtonDown,
    kButtonRight = playdate.kButtonRight,
    kButtonLeft = playdate.kButtonLeft,
    kButtonA = playdate.kButtonA,
    kButtonB = playdate.kButtonB,
}

local buttonToPressMock
function PlaydateMock.simulateButtonPress(buttonToPress)
    buttonToPressMock = buttonToPress
end
function PlaydateMock.buttonIsPressed(buttonToCheck)
    if (buttonToCheck == nil) then
        return false
    end

    return buttonToPressMock == buttonToCheck
end

local crankChangeMock
function PlaydateMock.simulateCrankChange(crankChange)
    crankChangeMock = crankChange
end
function PlaydateMock.getCrankChange()
    return crankChangeMock
end

-- Always build the mock to ensure state is reset!
function buildPlaydateMock()
    PlaydateMock.timer = buildPlaydateTimer()

    buttonToPressMock = nil
    crankChangeMock = 0.0

    return PlaydateMock
end