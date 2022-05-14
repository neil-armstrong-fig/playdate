import "test-setup/UnitTest"
import "actors/player/builders/Player_Builder"
import "actors/belt/builders/Belt_Builder"

local target

local function createTarget(config)
    local player = Player_Builder.buildTestPlayer()
    local belt = Belt_Builder.buildTestBelt()

    if (config ~= nil) then
        if (config.player ~= nil) then
            player = config.player
        end
        if (config.belt ~= nil) then
            belt = config.belt
        end
    end

    target = GameState(
            player,
            belt
    )
end

TestGameStateClass_PlayerPosition = {
    testShouldCreateGameStateSuccessfully = function()
        createTarget()

        luaunit.assertEquals(target.playerPosition.x, 200)
        luaunit.assertEquals(target.playerPosition.y, 60)
    end,
    testShouldFailAssertIfIsNil = function()
        local caughtError
        local player = Player_Builder.buildTestPlayer()
        player.luggage.position = nil

        local result = xpcall(
                function()
                    return createTarget({
                        player = player
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

TestGameStateClass_PlayerRotation = {
    testShouldCreateGameStateSuccessfully = function()
        createTarget()

        luaunit.assertEquals(target.playerRotation, 0)
    end,
    testShouldFailAssertIfIsNil = function()
        local caughtError
        local player = Player_Builder.buildTestPlayer()
        player.luggage.rotation = nil

        local result = xpcall(
                function()
                    return createTarget({
                        player = player
                    })
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

TestGameStateClass_BeltSize = {
    testShouldCreateGameStateSuccessfully = function()
        createTarget()

        luaunit.assertEquals(target.numberOfItemsOnBelt, 2)
    end,
    testShouldFailAssertIfIsNil = function()
        local caughtError
        local player = Player_Builder.buildTestPlayer()
        player.luggage.rotation = nil

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