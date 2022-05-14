import "utils/Lists"
import "game-loop/actors/luggage/Luggage"

class("Belt").extends()

function Belt:init(config)
    self.items = {}
    self.size = 0
    self.speed = 5
    self.timeRequiredToGoAroundBelt = 600

    if (config == nil) then
        return
    end

    if (config.speed) then
        self.speed = config.speed
    end
    if (config.timeRequiredToGoAroundBelt) then
        self.timeRequiredToGoAroundBelt = config.timeRequiredToGoAroundBelt
    end
end

function Belt:logicLoop(luggage)
    if (luggage.isPlayerControlDone) then
        self:_addLuggage(luggage)
    end

    self:_forEachItem(
            function(item)
                local x = item.position.x
                if (x < self.timeRequiredToGoAroundBelt) then
                    item.position.x = item.position.x + self.speed
                else
                    item.position.x = -40
                end

                item:logicLoop()
            end
    )
end

function Belt:_addLuggage(luggage)
    table.insert(self.items, luggage)
    self.size = self.size + 1
end

function Belt:_forEachItem(callback)
    lists.forEach(
            self.items,
            function(item)
                callback(item)
            end
    )
end

import "Belt_Test"