import "test-setup/UnitTest"
import "state/builders/GameState-Builder"

local playdateGraphicsMock

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = UiDrawer(playdateGraphicsMock)
end

TestUiDrawClass = {
    testShouldDrawPlayerLocation = function()
        createTarget()

        target:drawUi(GameState_Builder.buildTestGameState())

        local actual = playdateGraphicsMock.drawTextCalledWith()
        luaunit.assertEquals(actual[1], {
            text = "Player: (200, 60)",
            x = 2,
            y = 220
        })
    end
}