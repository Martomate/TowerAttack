class_name Ground extends TileMap

const WIDTH = 16
const HEIGHT = 10

var tileTypes = preload("res://tilesets/GroundTiles.tres")

var mobStartY: int

var pathIndices = {}

func init():
    initPath()

func pixelToTile(pixel: Vector2):
    return world_to_map(pixel)

func walkableAt(x: int, y: int):
    var id = get_cell(x, y)
    return id != -1 && tileTypes.tile_get_name(id) == "Dirt"

func pathIndex(x: int, y: int):
    if pathIndices.has(x + y * WIDTH):
        return pathIndices[x + y * WIDTH]
    else:
        return -1

func initPath():
    var startY = mobStartY
    var cx = 0
    var cy = startY
    var px = -1
    var py = startY
    
    pathIndices[0 + startY * WIDTH] = 0
    var pIdx = 1
    
    while (cx > -1 && cx < WIDTH && cy > -1 && cy < HEIGHT):
        var dx = [1, 0, -1, 0]
        var dy = [0, 1, 0, -1]
        var found = false
        for i in range(4):
            var xx = cx + dx[i]
            var yy = cy + dy[i]
            if ((xx != px || yy != py) && walkableAt(xx, yy)):
                pathIndices[xx + yy * WIDTH] = pIdx
                pIdx += 1
                px = cx
                py = cy
                cx = xx
                cy = yy
                found = true
                break
        if !found:
            break
    var nx = cx + (cx - px)
    var ny = cy + (cy - py)

func loadLevel(level: int):
    var map = load(str("res://levels/Level", level, ".tscn")).instance() as TileMap
    for y in range(HEIGHT):
        for x in range(WIDTH):
            set_cell(x, y, map.get_cell(x, y))
