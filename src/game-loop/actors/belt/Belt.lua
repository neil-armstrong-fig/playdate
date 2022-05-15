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

function Belt:update(activeLuggage)
    if (activeLuggage.isPlayerControlDone) then
        self:_addLuggage(activeLuggage)
    end

    self:_moveLuggageOnBelt()

    if (activeLuggage.isDropping) then
        self:_checkCollisions(activeLuggage)
    end
end

function Belt:_moveLuggageOnBelt()
    self:_forEachItem(function(itemOnBelt)
        local x = itemOnBelt.position.x
        if (x < self.timeRequiredToGoAroundBelt) then
            itemOnBelt.position.x = itemOnBelt.position.x + self.speed
        else
            itemOnBelt.position.x = -40
        end

        itemOnBelt:update()
    end)
end

function Belt:_checkCollisions(activeLuggage)
    self:_forEachItem(function(itemOnBelt)
        if (activeLuggage:hasCollidedWith(itemOnBelt)) then
            activeLuggage:hasHit(itemOnBelt)
            self:_addLuggage(activeLuggage)
        end
    end)
end

function Belt:_addLuggage(activeLuggage)
    table.insert(self.items, activeLuggage)
    self.size = self.size + 1
end

function Belt:_forEachItem(callback)
    lists.forEach(self.items, function(itemOnBelt)
        callback(itemOnBelt)
    end)
end

import "Belt_Test"