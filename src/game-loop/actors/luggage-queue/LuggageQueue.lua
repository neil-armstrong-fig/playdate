import "utils/Lists"
import "game-loop/actors/luggage/Luggage"

class("LuggageQueue").extends()

local spacing = 40

local function firstInQueuePosition()
    return {
        x = 245,
        y = 15
    }
end

local function secondInQueuePosition()
    local position = firstInQueuePosition()
    position.x = position.x + spacing
    return position
end

local function thirdInQueuePosition()
    local position = secondInQueuePosition()
    position.x = position.x + spacing
    return position
end

local function forthInQueuePosition()
    local position = thirdInQueuePosition()
    position.x = position.x + spacing
    return position
end

function LuggageQueue:init(graphics)
    self.graphics = graphics

    self.items = {
        Luggage(graphics, firstInQueuePosition(), 1),
        Luggage(graphics, secondInQueuePosition(), 2),
        Luggage(graphics, thirdInQueuePosition(), 3),
        Luggage(graphics, forthInQueuePosition(), 4)
    }
    self.size = 3
end

function LuggageQueue:getActiveLuggage()
    local firstInQueue = self.items[1]
    if (firstInQueue.isPlayerControlDone == false) then
        return firstInQueue
    end

    self:_popQueue()
    return self.items[1]
end

function LuggageQueue:_popQueue()
    self:_removeFirstLuggage()
    self:_forEachItem(
            function(item)
                item.position.x = item.position.x - spacing
            end
    )
    self:_addNewLuggage()
end

function LuggageQueue:_removeFirstLuggage()
    table.remove(self.items, 1)
    self.size = self.size - 1
end

function LuggageQueue:_addNewLuggage()
    table.insert(self.items, Luggage(self.graphics, forthInQueuePosition()))
    self.size = self.size + 1
end

function LuggageQueue:update()
    self:_forEachItem(
            function(item)
                item:update()
            end
    )
end

function LuggageQueue:_forEachItem(callback)
    lists.forEach(
            self.items,
            function(item)
                callback(item)
            end
    )
end

import "LuggageQueue_Test"