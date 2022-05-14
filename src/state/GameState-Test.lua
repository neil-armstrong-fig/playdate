import "test-setup/UnitTest"
import "actors/player/builders/Player_Builder"

TestGameStateClass_PlayerPosition = {
    testShouldCreateGameStateSuccessfully = function()
        local gameState = GameState(Player_Builder.buildTestPlayer())

        luaunit.assertEquals(gameState.playerPosition.x, 200)
        luaunit.assertEquals(gameState.playerPosition.y, 60)
    end,
    testShouldFailAssertIfIsNil = function()
        local caughtError
        local player = Player_Builder.buildTestPlayer()
        player.position = nil

        local result = xpcall(
                function()
                    return GameState(player)
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

TestGameStateClass_PlayerRotation= {
    testShouldCreateGameStateSuccessfully = function()
        local gameState = GameState(Player_Builder.buildTestPlayer())

        luaunit.assertEquals(gameState.playerRotation, 0)
    end,
    testShouldFailAssertIfIsNil = function()
        local caughtError
        local player = Player_Builder.buildTestPlayer()
        player.rotation = nil

        local result = xpcall(
                function()
                    return GameState(player)
                end,
                function(error)
                    caughtError = error
                end
        )

        luaunit.assertEquals(result, false)
        luaunit.assertNotIsNil(caughtError)
        luaunit.assertEquals(string.match(caughtError, "Player rotation was nil"), "Player rotation was nil")
    end,
}