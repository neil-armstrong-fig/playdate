local function loadImageFile(graphics, fileName)
    local filePath = string.format("images/%s", fileName);

    local image = graphics.image.new(filePath)
    assert(image, string.format("No image found at path '%s'", filePath))

    return image
end

ImageLoading = {}

function ImageLoading.loadBackgroundImage(graphics)
    return loadImageFile(graphics, "background/full-background")
end

function ImageLoading.loadLuggageQueueItemImage(graphics)
    return loadImageFile(graphics, "luggage/suitcase")
end