import "./test-setup/UnitTest"
import "./state/builders/GameState-Builder"

local playdateGraphicsMock

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    return UiDraw(playdateGraphicsMock)
end

TestUiDrawClass = {
    testShouldDrawPlayerLocation = function()
        local uiDraw = createTarget()

        uiDraw:drawUi(GameState_Builder.buildTestGameState())

        local actual = playdateGraphicsMock.drawTextCalledWith()
        luaunit.assertEquals(actual[1], {
            text = "Player: (200, 120)",
            x = 2,
            y = 220
        })
    end
}

UnitTest.runTests()