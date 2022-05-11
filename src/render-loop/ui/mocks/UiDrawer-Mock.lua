class("UiDrawerMock").extends()

local drawUiWasCalledWith
function UiDrawerMock:drawUi(gameState)
    if (drawUiWasCalledWith == nil) then
        drawUiWasCalledWith = {
            gameState
        }
    else
        table.insert(drawUiWasCalledWith, gameState)
    end
end
function UiDrawerMock:drawUiWasCalledWith()
    return drawUiWasCalledWith
end