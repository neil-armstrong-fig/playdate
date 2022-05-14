local function createTestList()
    return {"1", "2", "3"}
end

TestLists_Length = {
    testShouldReturnLengthOfList = function()
        luaunit.assertEquals(lists.length({"1"}), 1)
        luaunit.assertEquals(lists.length({"1", "2"}), 2)
        luaunit.assertEquals(lists.length({"1", "2", "3"}), 3)
    end,
}

TestLists_Filter = {
    testShouldFilterList = function()
        local result = lists.filter(
                createTestList(),
                function(item)
                    return item ~= "2"
                end
        )

        luaunit.assertEquals(result, {"1", "3"})
    end,
    testShouldReturnEmptyListIfListIsNil = function()
        local filterFunctionExecuted = false

        local result = lists.filter(
                nil,
                function()
                    filterFunctionExecuted = true
                    return true
                end
        )

        luaunit.assertEquals(result, {})
        luaunit.assertEquals(filterFunctionExecuted, false)
    end,
    testShouldReturnUnFilteredListIfFilterFunctionIsNil = function()
        local testList = createTestList()

        local result = lists.filter(
                testList,
                nil
        )

        luaunit.assertEquals(result, testList)
    end,
    testShouldNotFilterListIfListIsEmpty = function()
        local filterFunctionExecuted = false

        local result = lists.filter(
                {},
                function()
                    filterFunctionExecuted = true
                    return true
                end
        )

        luaunit.assertEquals(result, {})
        luaunit.assertEquals(filterFunctionExecuted, false)
    end,
}

TestLists_ForEach = {
    testShouldExecuteCallbackForEachElement = function()
        local numberOfTimesCallbackCalled = 0

        lists.forEach(
                createTestList(),
                function(item)
                    luaunit.assertNotIsNil(item)
                    numberOfTimesCallbackCalled = numberOfTimesCallbackCalled + 1
                end
        )

        luaunit.assertEquals(numberOfTimesCallbackCalled, 3)
    end,
}

TestLists_Find = {
    testShouldFindItemIfItExistsInList = function()
        local result = lists.find(
                createTestList(),
                function(item)
                    return item == "2"
                end
        )

        luaunit.assertEquals(result, "2")
    end,
    testShouldReturnNilIfListIsNil = function()
        local findFunctionWasCalled = false

        local result = lists.find(
                nil,
                function()
                    findFunctionWasCalled = true
                    return true
                end
        )

        luaunit.assertEquals(result, nil)
        luaunit.assertEquals(findFunctionWasCalled, false)
    end,
    testShouldReturnNilIfFindFunctionIsNil = function()
        local result = lists.find(
                createTestList(),
                nil
        )

        luaunit.assertEquals(result, nil)
    end,
    testShouldReturnNilIfItemNotFound = function()
        local result = lists.find(
                createTestList(),
                function()
                    return false
                end
        )

        luaunit.assertEquals(result, nil)
    end,
}

TestLists_Contains = {
    testShouldReturnTrueIfItExistsInList = function()
        local result = lists.contains(
                createTestList(),
                "2"
        )

        luaunit.assertEquals(result, true)
    end,
    testShouldReturnFalseIfListIsNil = function()
        local result = lists.contains(
                nil,
                "2"
        )

        luaunit.assertEquals(result, false)
    end,
    testShouldReturnFalseIfFindFunctionIsNil = function()
        local result = lists.contains(
                createTestList(),
                nil
        )

        luaunit.assertEquals(result, false)
    end,
    testShouldReturnFalseIfItemNotFound = function()
        local result = lists.contains(
                createTestList(),
                "not in list"
        )

        luaunit.assertEquals(result, false)
    end,
}

TestLists_ToString = {
    testShouldReturnListAsString = function()
        local result = lists.toString(createTestList())

        luaunit.assertEquals(result, "[1,2,3,]")
    end,
}
