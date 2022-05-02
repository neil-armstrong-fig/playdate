local graphics <const> = playdate.graphics

local function loadImageFile(fileName)
    local filePath = string.format("images/%s", fileName);

    local image = graphics.image.new(filePath)
    assert(image, string.format("No image found at path '%s'", filePath))

    return image
end

ImageLoading = {}

function ImageLoading.loadPlayerImage()
    return loadImageFile("playerImage")
end

function ImageLoading.loadBackgroundImage()
    return loadImageFile("background")
end
