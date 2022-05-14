TestHelpers = {}

function TestHelpers.addCapturedParams(currentlyCapturedParams, newParams)
    if (currentlyCapturedParams == nil) then
        return {newParams}
    else
        table.insert(currentlyCapturedParams, newParams)
        return currentlyCapturedParams
    end
end