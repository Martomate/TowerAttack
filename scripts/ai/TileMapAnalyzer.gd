class_name TileMapAnalyzer

var ground: Ground

var gridInfo = []

func _init(ground: Ground):
    self.ground = ground
    initGrids()

func bestLocation(type: TowerType, blockedSpots: Array):
    var bestScore = -100000
    var bestX = 0
    var bestY = 0
    for y in range(ground.HEIGHT):
        for x in range(ground.WIDTH):
            var idx = x + y * ground.WIDTH
            if not ground.walkableAt(x, y) and not blockedSpots.has(idx):
                var info = gridInfo[idx]
                var score = info.numNeighbors * 4 - info.soonestNeighbor
                if score > bestScore && randf() < 0.8:
                    bestScore = score
                    bestX = x
                    bestY = y
    if bestScore != -100000:
        return bestX + bestY * ground.WIDTH
    else:
        return -1

func initGrids():
    for y in range(ground.HEIGHT):
        for x in range(ground.WIDTH):
            var info = GridInfo.new()
            info.x = x
            info.y = y
            
            if not ground.walkableAt(x, y):
                var numNeighbors = 0
                var soonestNeighbor = 10000
                
                for dy in range(-1, 2):
                    for dx in range(-1, 2):
                        if (dx != 0 || dy != 0):
                            if ground.walkableAt(x+dx, y+dy):
                                numNeighbors += 1
                                var pIdx = ground.pathIndex(x+dx, y+dy)
                                if pIdx < soonestNeighbor:
                                    soonestNeighbor = pIdx
                
                info.numNeighbors = numNeighbors
                info.soonestNeighbor = soonestNeighbor
            else:
                info.numNeighbors = -1
                info.soonestNeighbor = 10000
            
            gridInfo.append(info)
