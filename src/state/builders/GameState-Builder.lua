import "actors/player/builders/Player_Builder"

GameState_Builder = {
    buildTestGameState = function()
        return GameState(Player_Builder.buildTestPlayer())
    end
}