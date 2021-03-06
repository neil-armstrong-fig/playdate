local function loadImageFile(graphics, fileName)
    local filePath = string.format("images/%s", fileName);

    local image = graphics.image.new(filePath)
    assert(image, string.format("No image found at path '%s'", filePath))

    return image
end

ImageLoading = {}

function ImageLoading.loadBackgroundImage(graphics)
    return loadImageFile(graphics, "background/without-belt")
end

function ImageLoading.loadBeltImage(graphics)
    return loadImageFile(graphics, "background/belt")
end

function ImageLoading.loadGearImage(graphics)
    return loadImageFile(graphics, "background/gear")
end

function ImageLoading.loadSuitcaseImage(graphics)
    return loadImageFile(graphics, "luggage/suitcase")
end

function ImageLoading.loadBallImage(graphics)
    return loadImageFile(graphics, "luggage/ball")
end

function ImageLoading.loadCarrierImage(graphics)
    return loadImageFile(graphics, "luggage/carrier")
end

function ImageLoading.loadSurfboardImage(graphics)
    return loadImageFile(graphics, "luggage/surfboard")
end