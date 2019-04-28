class_name MobTypes

var types: Dictionary = {}

func byName(name: String):
    return types.get(name)

func register(type: MobType):
    types[type.name] = type
