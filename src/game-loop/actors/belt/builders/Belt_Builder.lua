import "game-loop/actors/belt/Belt"
import "game-loop/actors/luggage/builders/Luggage_Builder"

Belt_Builder = {
    buildTestBelt = function()
        local belt = Belt()

        local luggage1 = Luggage_Builder.buildTestLuggage()
        local luggage2 = Luggage_Builder.buildTestLuggage()

        luggage1.isPlayerControlDone = true
        luggage2.isPlayerControlDone = true

        belt:update(luggage1)
        belt:update(luggage2)

        return belt
    end
}