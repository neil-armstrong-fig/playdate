import "luaunit/playdate_luaunit_fix"
import "luaunit/luaunit"
import "Mock-Playdate"

local function unitTestsEnabled()
    return playdate.isSimulator
end

UnitTest = {}

-- Will only test a table called `TestMyStuff`
-- Also make sure test file is imported at the bottom of the file under test
function UnitTest.runTests()
    if (unitTestsEnabled() == false) then
        return
    end

    playdate.stop()
    luaunit.PRINT_TABLE_REF_IN_ERROR_MSG = true

    local testOutputFilename = "test_output"
    local outputType = "text"
    local luaunit_args = { '--output', 'text', '--verbose', '-r' }
    local returnValue = luaunit.LuaUnit.run(table.unpack(luaunit_args))
    print("unit test return value = " .. returnValue)
end
