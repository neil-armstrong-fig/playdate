local PlaydateTimerMock = {}

local updateTimersWasCalled
function PlaydateTimerMock.updateTimers()
    updateTimersWasCalled = true
end
function PlaydateTimerMock.updateTimersWasCalled()
    return updateTimersWasCalled
end

function buildPlaydateTimer()
    updateTimersWasCalled = false

    return PlaydateTimerMock
end