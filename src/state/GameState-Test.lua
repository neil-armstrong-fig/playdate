import "./test-setup/UnitTest"
import "./actors/player/builders/Player_Builder"

TestGameStateClass = {
    testShouldCreateGameState = function()
        local gameState = GameState(Player_Builder.buildTestPlayer())

        luaunit.assertEquals(gameState.playerPosition.x, 200)
        luaunit.assertEquals(gameState.playerPosition.y, 120)
    end,
    testShouldFailAssertIfPlayerPositionIsNil = function()
        local caughtError = nil

        local result = xpcall(
                function()
                    return GameState({
                        position = nil
                    })
                end,
                function(error)
                    caughtError = error
                end
        )

        luaunit.assertEquals(result, false)
        luaunit.assertNotIsNil(caughtError)
        luaunit.assertEquals(string.match(caughtError, "Player position was nil"), "Player position was nil")
    end,
}

UnitTest.runTests()