local PlaydateMock = {}

local buttonToPressMock
function PlaydateMock.simulateButtonPress(buttonToPress)
    buttonToPressMock = buttonToPress
end
function PlaydateMock.buttonIsPressed(buttonToCheck)
    return buttonToPressMock == buttonToCheck
end

-- Always build the mock to ensure state is reset!
function buildPlaydateMock()
    buttonToPressMock = nil

    return PlaydateMock
end