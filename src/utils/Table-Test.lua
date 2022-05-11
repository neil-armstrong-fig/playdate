import "./test-setup/UnitTest"

TestTable_Length = {
    testShouldReturnLengthOfTable = function()
        luaunit.assertEquals(table.length({test = "value"}), 1)
        luaunit.assertEquals(table.length({test = "value", test2 = "value"}), 2)
        luaunit.assertEquals(table.length({test = "value", test2 = "value", test3 = "value"}), 3)
    end,
}

TestTable_Merge = {
    testShouldMergeTables = function()
        local result = table.merge({table1 = "value"}, {table2 = "value"})

        luaunit.assertEquals(result, {table1 = "value", table2 = "value"})
    end,
    testShouldReturnTable2IfTable1IsNil = function()
        local result = table.merge(nil, {table2 = "value"})

        luaunit.assertEquals(result, {table2 = "value"})
    end,
    testShouldReturnTable1IfTable2IsNil = function()
        local result = table.merge({table1 = "value"}, nil)

        luaunit.assertEquals(result, {table1 = "value"})
    end,
}

TestTable_ToString = {
    testShouldPrintTable = function()
        local result = table.toString({test = "value"})

        luaunit.assertEquals(result, "{ test = value, }")
    end,
    testShouldReturnNilIfTableIsNil = function()
        local result = table.toString(nil)

        luaunit.assertEquals(result, "nil")
    end,
    testShouldCallStdLibToStringIfNotTable = function()
        local result = table.toString(2345)

        luaunit.assertEquals(result, "2345")
    end,
}