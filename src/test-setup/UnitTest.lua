import "PlaydateLuaUnitFix"
import "luaunit"

import "mocks/Playdate-Mock"

local testNamesCompleted = {}

local function listContains(list, itemToFind)
    for _, item in pairs(list) do
        if (item == itemToFind) then
            return true
        end
    end

    return false
end

local function getTestNamesFromGlobalEnvironment()
    return luaunit.LuaUnit.collectTests()
end

local function getNewTestsToExecute()
    local allTestNames = getTestNamesFromGlobalEnvironment()

    local newTestsToRun = {}
    for _, testNameToCheck in pairs(allTestNames) do
        if (listContains(testNamesCompleted, testNameToCheck) == false) then
            table.insert(newTestsToRun, testNameToCheck)
        end
    end
    return newTestsToRun
end

local function removeTestFromGlobalEnvironment(testName)
    _G[testName] = nil
end

local function runTests()
    local testNamesToExecute = getNewTestsToExecute()
    if (testNamesToExecute == {}) then
        return 0
    end

    local testRunnerArguments = {"--output", "text", "--quiet"}

    print("\nRunning tests...")
    for _, testNameToExecute in pairs(testNamesToExecute) do
        print(testNameToExecute)
        table.insert(testRunnerArguments, testNameToExecute)
    end

    local testResult = luaunit.LuaUnit.run(table.unpack(testRunnerArguments))

    for _, completedTestName in pairs(testNamesToExecute) do
        table.insert(testNamesCompleted, completedTestName)
        removeTestFromGlobalEnvironment(completedTestName)
    end

    return testResult
end

local function unitTestsEnabled()
    return playdate.isSimulator == 1
end

local function removeAllTestsFromGlobalEnvironment()
    for _, testName in pairs(getTestNamesFromGlobalEnvironment()) do
        removeTestFromGlobalEnvironment(testName)
    end
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
