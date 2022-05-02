import "PlaydateLuaUnitFix"
import "luaunit"

import "mocks/Playdate-Mock"

local function unitTestsEnabled()
    return playdate.isSimulator == 1
end

local anyTestsFailed = false

UnitTest = {}

-- Will only test a table that beings with `Test`
-- Also make sure test file is imported at the bottom of the file under test so everything works in the test file
function UnitTest.runTests(cleanup)
    if (unitTestsEnabled() == false) then
        return
    end

    playdate.stop()

    luaunit.PRINT_TABLE_REF_IN_ERROR_MSG = true
    local luaunit_args = { '--output', 'text', '--verbose', '-r' }
    local testRunner = luaunit.LuaUnit.new()
    local testRunResult = testRunner:runSuite(table.unpack(luaunit_args))
    cleanup()

    if (testRunResult ~= 0) then
        anyTestsFailed = true
    end

    if (anyTestsFailed) then
        playdate.simulator.writeToFile(table.toString(testRunner.result.failures), "~/Downloads/testFailure.txt")
    end

    if (anyTestsFailed == false) then
        playdate.start()
    end
end
