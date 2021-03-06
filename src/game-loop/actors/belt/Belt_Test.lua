local startingX = 200
local startingY = 60
local speed = 5

local playdateGraphicsMock

local target

local function createTarget(config)
    playdateGraphicsMock = buildPlaydateGraphicsMock()
    target = Belt(config)
end

TestBeltClass = {
    testShouldInitWithDefaults = function()
        createTarget()

        luaunit.assertEquals(target.size, 0)
        luaunit.assertEquals(target.speed, 5)
        luaunit.assertEquals(target.timeRequiredToGoAroundBelt, 600)
    end,
    testShouldInitWithOverrides = function()
        createTarget({
            speed = 10,
            timeRequiredToGoAroundBelt = 20
        })

        luaunit.assertEquals(target.speed, 10)
        luaunit.assertEquals(target.timeRequiredToGoAroundBelt, 20)
    end,
}

TestBeltClass_UpdateDefault = {
    testShouldNotAddLuggageIfPlayIsNotDoneControllingItYet = function()
        createTarget()
        local luggage = Luggage_Builder.buildTestLuggage()

        target:update(luggage)

        luaunit.assertEquals(target.size, 0)
    end,
}

TestBeltClass_UpdatePlayerControlling = {
    testShouldAddLuggageIfPlayerIsDoneControllingIt = function()
        createTarget()
        local luggage = Luggage_Builder.buildTestLuggage()
        luggage.isPlayerControlDone = true

        target:update(luggage)

        luaunit.assertEquals(target.size, 1)
        luaunit.assertEquals(target.items[1], luggage)
    end,
}

TestBeltClass_UpdateMovingLuggage = {
    testShouldMoveLuggageOnUpdate = function()
        createTarget()
        local luggage = Luggage_Builder.buildTestLuggage()
        luggage.isPlayerControlDone = true
        luaunit.assertEquals(luggage.position, {
            x = startingX,
            y = startingY
        })

        target:update(luggage)
        luaunit.assertEquals(luggage.position.x, startingX + speed)
        target:update(Luggage_Builder.buildTestLuggage())
        luaunit.assertEquals(luggage.position.x, startingX + speed + speed)

    end,
    testShouldMoveLuggageBackToStartOfViewWhenCompletedCircuit = function()
        createTarget({
            speed = 10,
            timeRequiredToGoAroundBelt = startingX + 20
        })
        local luggage = Luggage_Builder.buildTestLuggage()
        luggage.isPlayerControlDone = true

        target:update(luggage)
        luaunit.assertEquals(luggage.position.x, startingX + 10)
        target:update(Luggage_Builder.buildTestLuggage())
        luaunit.assertEquals(luggage.position.x, startingX + 20)
        target:update(Luggage_Builder.buildTestLuggage())
        luaunit.assertEquals(luggage.position.x, -40)
        target:update(Luggage_Builder.buildTestLuggage())
        luaunit.assertEquals(luggage.position.x, -30)
    end,
}

TestBeltClass_UpdateCollisionDetection = {
    testShouldDetectCollision = function()
        createTarget()

        local luggageOnBelt = Luggage_Builder.buildTestLuggage()
        luggageOnBelt.isPlayerControlDone = true
        target:update(luggageOnBelt)

        local activeLuggage = Luggage_Builder.buildTestLuggage()
        activeLuggage.isDropping = true
        activeLuggage.sprite:simulateOverlappingSprites(luggageOnBelt.sprite)
        target:update(activeLuggage)

        luaunit.assertEquals(activeLuggage.isPlayerControlDone, true)
    end,
}