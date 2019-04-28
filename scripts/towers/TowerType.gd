class_name TowerType

var name: String
var power: float
var priceMultiplier: float

func _init(name: String, power: float, priceMultiplier: float):
    self.name = name
    self.power = power
    self.priceMultiplier = priceMultiplier

func price():
    return power * priceMultiplier
