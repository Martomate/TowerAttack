class_name TowerManager

signal buildTower(idx, type)

var types: TowerTypes

var towerLocations = []

func _init(types: TowerTypes):
    self.types = types

func buyTower(idx: int, type: TowerType):
    towerLocations.append(idx)
    emit_signal("buildTower", idx, type)
    pass
