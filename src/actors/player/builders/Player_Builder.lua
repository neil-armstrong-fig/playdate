Player_Builder = {
    buildTestPlayer = function()
        return Player(buildPlaydateGraphicsMock(), {
            playdateMock = buildPlaydateMock()
        })
    end
}