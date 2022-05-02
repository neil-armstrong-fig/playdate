# mkdir build
New-Item -ItemType Directory -Force build

# Build release
$directory = (pwd).path
$inputPath = "${directory}\Source"
$outputPath = "build\game.pdx"
echo "Building ${inputPath} into ${outputPath}"
pdc "${inputPath}" "${outputPath}"

# Stop simulators
Stop-Process -Name PlaydateSimulator

# Run simulator
build\game.pdx\main.pdz