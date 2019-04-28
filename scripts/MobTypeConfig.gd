extends Node

var mobTypes: MobTypes = MobTypes.new()
var mobTypeBlue = MobType.new("Blue", 100, 120)
var mobTypeYellow = MobType.new("Yellow", 70, 180)

func init():
    mobTypes.register(mobTypeBlue)
    mobTypes.register(mobTypeYellow)