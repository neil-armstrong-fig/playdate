local playdateMock
local playdateGraphicsMock
local imageMock

local target

local function createTarget()
    playdateMock = buildPlaydateMock()
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Gears(playdateGraphicsMock, {
        playdateMock = playdateMock
    })
    imageMock = playdateGraphicsMock.image.generatedMocks()[1]
end

TestGearsClass = {
    testShouldInit = function()
        createTarget()

        luaunit.assertEquals(playdateGraphicsMock.image.newCalledWith(), "images/background/gear")
        local firstSmallGear = playdateGraphicsMock.sprite.generatedMocks()[1]
        luaunit.assertEquals(firstSmallGear.moveToCalledWith[1], {
            x = 377,
            y = 225,
        })
        luaunit.assertEquals(firstSmallGear.setScaleCalledWith[1], {
            scale = 0.5
        })
        luaunit.assertEquals(firstSmallGear.addWasCalled, true)
        local secondSmallGear = playdateGraphicsMock.sprite.generatedMocks()[2]
        luaunit.assertEquals(secondSmallGear.moveToCalledWith[1], {
            x = 377,
            y = 103,
        })
        luaunit.assertEquals(secondSmallGear.setScaleCalledWith[1], {
            scale = 0.5
        })
        luaunit.assertEquals(secondSmallGear.addWasCalled, true)
        local bigGear = playdateGraphicsMock.sprite.generatedMocks()[3]
        luaunit.assertEquals(bigGear.moveToCalledWith[1], {
            x = 245,
            y = 105,
        })
        luaunit.assertEquals(bigGear.addWasCalled, true)
    end
}

TestGearsClass_Update = {
    testShouldRotateImagesBasedOnCrankChanges = function()
        createTarget()
        playdateMock.simulateCrankChange(2.4)

        target:update()

        luaunit.assertEquals(target.firstSmallGear.rotation, 2.4)
        luaunit.assertEquals(target.secondSmallGear.rotation, -2.4)
        luaunit.assertEquals(target.bigGear.rotation, 2.4)
    end
}