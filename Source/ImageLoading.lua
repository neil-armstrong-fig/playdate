local graphics <const> = playdate.graphics

local function loadImageFile(fileName)
    local filePath = string.format("Images/%s", fileName);

    local image = graphics.image.new(filePath)
    assert(image, string.format("No image found at %s", filePath)) -- make sure the image was where we thought

    return image
end

ImageLoading = {}

function ImageLoading.loadPlayerImage()
    return loadImageFile("playerImage")
end

function ImageLoading.loadBackgroundImage()
    return loadImageFile("background")
end
