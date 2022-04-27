local graphics <const> = playdate.graphics

function renderLoop()
    -- Call the functions below in playdate.update() to draw sprites and keep
    -- timers updated. (We aren't using timers in this example, but in most
    -- average-complexity games, you will.)
    graphics.sprite.update()
    playdate.timer.updateTimers()
end