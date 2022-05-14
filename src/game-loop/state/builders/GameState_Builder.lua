import "game-loop/actors/player/builders/Player_Builder"
import "game-loop/actors/belt/builders/Belt_Builder"

GameState_Builder = {
    buildTestGameState = function()
        return GameState(
                Player_Builder.buildTestPlayer(),
                Belt_Builder.buildTestBelt()
        )
    end
}