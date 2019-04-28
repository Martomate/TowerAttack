extends Node

var towerTypes: TowerTypes = TowerTypes.new()
var towerTypeBlue = TowerType.new("Blue", 80, 4.0)
var towerTypeRed = TowerType.new("Red", 80, 5)

func init():
    towerTypes.register(towerTypeBlue)
    towerTypes.register(towerTypeRed)
