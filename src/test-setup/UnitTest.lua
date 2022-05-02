import "PlaydateLuaUnitFix"
import "luaunit"

import "mocks/Playdate-Mock"

local function unitTestsEnabled()
    return playdate.isSimulator == 1
end

local anyTestsFailed = false

UnitTest = {}

-- Will only test a table called `TestMyStuff`
-- Also make sure test file is imported at the bottom of the file under test
function UnitTest.runTests(cleanup)
    if (unitTestsEnabled() == false) then
        return
    end

    playdate.stop()

    luaunit.PRINT_TABLE_REF_IN_ERROR_MSG = true
    local luaunit_args = { '--output', 'text', '--verbose', '-r' }
    local testRunResult = luaunit.LuaUnit.run(table.unpack(luaunit_args))
    cleanup()

    if (testRunResult ~= 0) then
        anyTestsFailed = true
    end

    if (anyTestsFailed == false) then
        playdate.start()
    end
end
