class_name AI

var analyzer: TileMapAnalyzer
var towerManager: TowerManager
var data: AIData

var placeTowerTimer = 0
var nextTowerType

func _init(tileMapAnalyzer: TileMapAnalyzer, towerManager: TowerManager, data: AIData):
    self.analyzer = tileMapAnalyzer
    self.towerManager = towerManager
    self.data = data
    setNextTowerType()

func update():
    if placeTowerTimer == 0:
        placeTowerTimer = 10
        
        var type = nextTowerType
        var bestLocation = analyzer.bestLocation(type, towerManager.towerLocations)
        if bestLocation != -1 && type.price() <= data.money:
            towerManager.buyTower(bestLocation, type)
            setNextTowerType()
    
    placeTowerTimer -= 1

func setNextTowerType():
    var allTowers = towerManager.types.allTypes()
    var r = randf()
    var towerChoice = int(r * allTowers.size())
    nextTowerType = allTowers[towerChoice]
