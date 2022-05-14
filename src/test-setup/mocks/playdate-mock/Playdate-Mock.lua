import "mocks/PlaydateTimer-Mock"

local PlaydateMock = {
    kButtonUp = playdate.kButtonUp,
    kButtonDown = playdate.kButtonDown,
    kButtonRight = playdate.kButtonRight,
    kButtonLeft = playdate.kButtonLeft,
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

-- Always build the mock to ensure state is reset!
function buildPlaydateMock()
    PlaydateMock.timer = buildPlaydateTimer()

    buttonToPressMock = nil

    return PlaydateMock
end