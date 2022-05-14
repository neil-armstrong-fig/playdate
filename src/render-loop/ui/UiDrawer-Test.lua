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

        luaunit.assertEquals(playdateGraphicsMock.drawTextCalledWith()[1], {
            text = "Player: (200, 60)",
            x = 2,
            y = 220
        })

        luaunit.assertEquals(playdateGraphicsMock.drawTextCalledWith()[2], {
            text = "Belt: (2)",
            x = 2,
            y = 200
        })
    end
}