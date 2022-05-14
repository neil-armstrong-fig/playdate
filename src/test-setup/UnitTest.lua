import "PlaydateLuaUnitFix"
import "luaunit"

import "mocks/playdate-mock/Playdate_Mock"
import "mocks/playdate-graphics-mock/PlaydateGraphics_Mock"

local logTestNames = false
luaunit.SUPER_QUIET_LOGS = logTestNames

local function getTestNamesFromGlobalEnvironment()
    return luaunit.LuaUnit.collectTests()
end

local function removeAllTestsFromGlobalEnvironment()
    for _, testName in pairs(getTestNamesFromGlobalEnvironment()) do
        _G[testName] = nil
    end
end

local function runTests()
    local testNamesToExecute = getTestNamesFromGlobalEnvironment()
    if (testNamesToExecute == {}) then
        return 0
    end

    local testRunnerArguments = {"--output", "text", "--quiet"}

    if (logTestNames) then
        print("\nRunning tests...")
    end
    for _, testNameToExecute in pairs(testNamesToExecute) do
        if (logTestNames) then
            print(testNameToExecute)
        end
        table.insert(testRunnerArguments, testNameToExecute)
    end

    local testResult = luaunit.LuaUnit.run(table.unpack(testRunnerArguments))

    removeAllTestsFromGlobalEnvironment()

    return testResult
end

local function unitTestsEnabled()
    return playdate.isSimulator == 1
end

local anyTestsFailed = false

UnitTest = {}

-- Will only test a table that begins with `Test`
-- Also make sure test file is imported at the bottom of the file under test so everything works in the test file
function UnitTest.runTests(cleanup)
    if (unitTestsEnabled() == false) then
        removeAllTestsFromGlobalEnvironment()
        return
    end

    playdate.stop()

    local testResult = runTests()

    if (cleanup ~= nil) then
        cleanup()
    end

    if (testResult ~= 0) then
        anyTestsFailed = true
    end

    if (anyTestsFailed == false) then
        playdate.start()
    end
end
