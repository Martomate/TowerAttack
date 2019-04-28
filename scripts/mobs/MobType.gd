class_name MobType

const priceMultiplier = 0.01

var name: String
var maxHealth: float
var speed: float

func _init(name: String, maxHealth: float, speed: float):
    self.name = name
    self.maxHealth = maxHealth
    self.speed = speed

func price():
    return maxHealth * speed * priceMultiplier
