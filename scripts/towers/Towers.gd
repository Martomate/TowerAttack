extends Node2D

signal moneyEarned(money)

var BlueTower = preload("res://scenes/BlueTower.tscn")
var RedTower = preload("res://scenes/RedTower.tscn")

const MoneyPerMob = 0.4

var towers: Array

var towerTypes: TowerTypes

func init(types: TowerTypes):
    reset()
    self.towerTypes = types

func addTower(x: int, y: int, type: TowerType):
    var towerF
    if type.name == "Red":
        towerF = RedTower
    else:
        towerF = BlueTower
    var tower = towerF.instance()
    tower.init(x, y, type)
    tower.connect("killedMob", self, "onTowerKilledMob", [tower])
    add_child(tower)
    towers.append(tower)

func onTowerKilledMob(mob, tower):
    emit_signal("moneyEarned", mob.maxHealth * MoneyPerMob)

func reset():
    towers = []
    for t in get_children():
        remove_child(t)
