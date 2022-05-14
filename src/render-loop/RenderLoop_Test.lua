import "ui/mocks/UiDrawer_Mock"
import "game-loop/state/builders/GameState_Builder"

local playdateGraphicsMock
local playdateMock
local uiDrawerMock

local gameState

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    playdateMock = buildPlaydateMock()
    uiDrawerMock = UiDrawerMock()

    gameState = GameState_Builder.buildTestGameState()

    target = RenderLoop(playdateGraphicsMock, {
        uiDrawerMock = uiDrawerMock,
        playdateMock = playdateMock
    })
end

TestRenderLoopClass = {
    testShouldUpdateDisplayOnUpdate = function()
        createTarget()

        target:update(gameState)

        luaunit.assertEquals(playdateGraphicsMock.sprite.updateWasCalled(), true)
        luaunit.assertEquals(uiDrawerMock:drawUiWasCalledWith()[1], gameState)
        luaunit.assertEquals(playdateMock.timer.updateTimersWasCalled(), true)
    end
}
