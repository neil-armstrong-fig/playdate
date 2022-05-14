import "utils/Lists"
import "game-loop/actors/luggage/Luggage"

class("Belt").extends()

function Belt:init()
    self.items = {}
    self.size = 0
end

function Belt:logicLoop(luggage)
    if (luggage.isPlayerControlDone) then
        self:_addLuggage(luggage)
    end
end

function Belt:_addLuggage(luggage)
    table.insert(self.items, luggage)
    self.size = self.size + 1
end