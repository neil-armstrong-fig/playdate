import "game-loop/actors/luggage/Luggage"

Luggage_Builder = {
    buildTestLuggage = function(graphics)
        if (graphics == nil) then
            graphics = buildPlaydateGraphicsMock()
        end

        return Luggage(graphics, {
            x = 200,
            y = 60
        })
    end
}