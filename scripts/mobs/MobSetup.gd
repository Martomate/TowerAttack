class_name MobSetup

const RegenSpeed = 0.25
const ReflectTime = 0.5
const DodgeTime = 0.5

var type: MobType

var healthLevel = 0 setget set_healthLevel, get_healthLevel
var _maxHealthLevel = 15

var speedLevel = 0 setget set_speedLevel, get_speedLevel
var _maxSpeedLevel = 15

var shouldRegen = false

var shouldReflect = false

var shouldDodge = false

func copy(c):
    c.type = type
    c.healthLevel = healthLevel
    c.speedLevel = speedLevel
    c.shouldRegen = shouldRegen
    c.shouldReflect = shouldReflect
    c.shouldDodge = shouldDodge
    return c

func _healthMultiplier():
    return pow(1.2, healthLevel)

func _speedMultiplier():
    return pow(1.1, speedLevel)

func _regenMultiplier():
    return _multIf(shouldRegen, 1.18)

func _reflectMultiplier():
    return _multIf(shouldReflect, 1.2)

func _dodgeMultiplier():
    return _multIf(shouldDodge, 1.15)

func _multIf(b: bool, m: float):
    if b:
        return m
    else:
        return 1

func maxHealth():
    return round(type.maxHealth * _healthMultiplier())

func speed():
    return round(type.speed * _speedMultiplier())

func totalPriceMultiplier():
    var mul = 1.0
    mul *= _healthMultiplier()
    mul *= _speedMultiplier()
    mul *= _regenMultiplier()
    mul *= _reflectMultiplier()
    mul *= _dodgeMultiplier()
    return mul

func price():
    return type.price() * totalPriceMultiplier()


func set_healthLevel(newLevel: int):
    healthLevel = min(max(newLevel, 0), _maxHealthLevel)

func get_healthLevel():
    return healthLevel

func set_speedLevel(newLevel: int):
    speedLevel = min(max(newLevel, 0), _maxSpeedLevel)

func get_speedLevel():
    return speedLevel
