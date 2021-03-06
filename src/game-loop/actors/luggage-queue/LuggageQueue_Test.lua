local playdateGraphicsMock

local firstItem
local secondItem
local thirdItem
local forthItem

local target

local function createTarget()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = LuggageQueue(playdateGraphicsMock)

    firstItem = target.items[1]
    secondItem = target.items[2]
    thirdItem = target.items[3]
    forthItem = target.items[4]
end

testLuggageQueueClass_Init = {
    testShouldInitQueue = function()
        createTarget()

        luaunit.assertEquals(target.size, 3)
        luaunit.assertNotIsNil(firstItem)
        luaunit.assertEquals(firstItem.luggageType, LuggageTypes[1])
        luaunit.assertEquals(firstItem.position, {
            x = 245,
            y = 15
        })
        luaunit.assertNotIsNil(secondItem)
        luaunit.assertEquals(secondItem.luggageType, LuggageTypes[2])
        luaunit.assertEquals(secondItem.position, {
            x = 285,
            y = 15
        })
        luaunit.assertNotIsNil(thirdItem)
        luaunit.assertEquals(thirdItem.luggageType, LuggageTypes[3])
        luaunit.assertEquals(thirdItem.position, {
            x = 325,
            y = 15
        })
        luaunit.assertNotIsNil(forthItem)
        luaunit.assertEquals(forthItem.luggageType, LuggageTypes[4])
        luaunit.assertEquals(forthItem.position, {
            x = 365,
            y = 15
        })
    end,
}

testLuggageQueueClass_NextLuggage = {
    testShouldProduceNextLuggageInQueue = function()
        createTarget()

        local result = target:getActiveLuggage()

        luaunit.assertEquals(target.size, 3)
        luaunit.assertEquals(result, firstItem)
    end,
    testShouldRemoveItemFromQueueIfPlayerControlIsDone = function()
        createTarget()
        firstItem.isPlayerControlDone = true

        local result = target:getActiveLuggage()

        luaunit.assertEquals(target.size, 3)
        luaunit.assertEquals(result, target.items[1])
        luaunit.assertNotEquals(result, firstItem)
        luaunit.assertEquals(secondItem.position, {
            x = 245,
            y = 15
        })
        luaunit.assertEquals(thirdItem.position, {
            x = 285,
            y = 15
        })
    end,
}
