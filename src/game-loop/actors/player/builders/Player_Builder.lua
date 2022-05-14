import "game-loop/actors/luggage/builders/Luggage_Builder"

Player_Builder = {
    buildTestPlayer = function()
        local player = Player(buildPlaydateGraphicsMock(), {
            playdateMock = buildPlaydateMock()
        })

        player.luggage = Luggage_Builder.buildTestLuggage()
        return player
    end
}